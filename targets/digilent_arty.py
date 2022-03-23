#!/usr/bin/env python3

#
# This file is part of LiteX-Boards.
#
# Copyright (c) 2015-2019 Florent Kermarrec <florent@enjoy-digital.fr>
# Copyright (c) 2020-2022 Antmicro <www.antmicro.com>
# SPDX-License-Identifier: BSD-2-Clause

# This variable defines all the external programs that this module
# relies on.  lxbuildenv reads this variable in order to ensure
# the build will finish without exiting due to missing third-party
# programs.
LX_DEPENDENCIES = ["riscv", "vivado"]

# Import lxbuildenv to integrate the deps/ directory
import lxbuildenv

import os
import argparse

from migen import *

from litex_boards.targets.digilent_arty import BaseSoC
from litex.build.xilinx.vivado import vivado_build_args, vivado_build_argdict
from litex.build.generic_platform import *

from litex.soc.integration.soc import SoCRegion
from litex.soc.integration.soc_core import *
from litex.soc.integration.builder import *
from litex.soc.cores.bitbang import I2CMaster
from litex.soc.interconnect.stream import SyncFIFO

from litevideo.output import VideoOut

from ov2640 import OV2640
from gpu_2d import GPU_2D
from fastvdma import FastVDMA


# Platform description for HDMI connector on Expansion Board ---------------------------------------
def hdmi_pmod_io():
    return[
        ("hdmi_out", 0,
            Subsignal("clk_p",   Pins("T13"), IOStandard("TMDS_33")), # JC9
            Subsignal("clk_n",   Pins("U13"), IOStandard("TMDS_33")), # JC10
            Subsignal("data0_p", Pins("U12"), IOStandard("TMDS_33")), # JC1
            Subsignal("data0_n", Pins("V12"), IOStandard("TMDS_33")), # JC2
            Subsignal("data1_p", Pins("V10"), IOStandard("TMDS_33")), # JC3
            Subsignal("data1_n", Pins("V11"), IOStandard("TMDS_33")), # JC4
            Subsignal("data2_p", Pins("U14"), IOStandard("TMDS_33")), # JC7
            Subsignal("data2_n", Pins("V14"), IOStandard("TMDS_33")), # JC8
        ),
    ]
_hdmi_pmod_io = hdmi_pmod_io()

# Platform description for OV2640 cameras with I2C multiplexer on Expansion Board ------------------
def double_ov2640_pmod_io():
    return [
        ("ov2640", 0,
            Subsignal("data",   Pins("pmoda:3 pmodb:4 pmodb:1 pmodb:0 pmoda:7 pmoda:6 pmoda:1 pmoda:5"), IOStandard("LVCMOS33")),
            Subsignal("pclk",   Pins("pmoda:2"), IOStandard("LVCMOS33")),
            Subsignal("href",   Pins("pmoda:0"), IOStandard("LVCMOS33")),
            Subsignal("vsync",  Pins("pmoda:4"), IOStandard("LVCMOS33")),
        ),
        ("ov2640", 1,
            Subsignal("data",   Pins("pmodd:5 pmodd:6 pmodd:3 pmodd:2 pmodd:1 pmodd:0 pmodb:3 pmodb:6"), IOStandard("LVCMOS33")),
            Subsignal("pclk",   Pins("pmodd:4"), IOStandard("LVCMOS33")),
            Subsignal("href",   Pins("pmodb:2"), IOStandard("LVCMOS33")),
            Subsignal("vsync",  Pins("pmodb:5"), IOStandard("LVCMOS33")),
        ),
        ("i2c_pmod", 0,
            Subsignal("scl",    Pins("pmodb:7"), IOStandard("LVCMOS33")),
            Subsignal("sda",    Pins("pmodd:7"), IOStandard("LVCMOS33")),
        )
]
_double_ov2640_pmod_io = double_ov2640_pmod_io()


# ArtySoC ------------------------------------------------------------------------------------------

class ArtySoC(BaseSoC):
    csr_map = {**BaseSoC.csr_map, **{
        "i2c_pmod":    0,            # addr: 0xf0000000
        "fastvdma_ov2640_left":  1,  # addr: 0xf0000800
        "fastvdma_ov2640_right": 2,  # addr: 0xf0001000
        "ethmac":      3,            # addr: 0xf0001800
        "ethphy":      4,            # addr: 0xf0002000
        "uart":        5,            # addr: 0xf0002800
        "timer0":      6,            # addr: 0xf0003000
        "framebuffer": 7,            # addr: 0xf0003800
        "gpu":         8,            # addr: 0xf0004000
        "gpu_dma_r1":  9,            # addr: 0xf0004800
        "gpu_dma_r2": 10,            # addr: 0xf0005000
        "gpu_dma_w":  11,            # addr: 0xf0005800
    }}
    interrupt_map = {**BaseSoC.interrupt_map, **{
        "uart":       0,
        "timer0":     1,
        "ethmac":     2,
        "fastvdma_ov2640_left":  3,
        "fastvdma_ov2640_right": 4,
        "gpu_dma_r1": 5,
        "gpu_dma_r2": 6,
        "gpu_dma_w":  7,
    }}
    mem_map = {**BaseSoC.mem_map, **{
        "rom":                   0x00000000,
        "sram":                  0x10000000,
        "main_ram":              0x40000000,
        "ethmac":                0x80000000,
        "fastvdma_ov2640_left":  0x8000a000,
        "fastvdma_ov2640_right": 0x8000b000,
        "gpu_dma_r1":            0x8000c000,
        "gpu_dma_r2":            0x8000d000,
        "gpu_dma_w":             0x8000e000,
        "csr":                   0xf0000000,
    }}
    def __init__(self, **kwargs):
        BaseSoC.__init__(self, **kwargs)

        self.clock_domains.cd_clk100 = ClockDomain()
        self.crg.pll.create_clkout(self.cd_clk100, 100e6)

        # OV2640 Cameras ---------------------------------------------------------------------------
        self.platform.add_extension(_double_ov2640_pmod_io)
        self.platform.add_extension(_hdmi_pmod_io)

        self.submodules.i2c_pmod = I2CMaster(self.platform.request("i2c_pmod"))

        # Left camera DMA reader (camera -> memory)
        self.submodules.fastvdma_ov2640_left = fastvdma_ov2640_left = FastVDMA(self.platform, "AXIS_WB_WB")
        self.bus.add_slave("fastvdma_slave_control_1", self.fastvdma_ov2640_left.wb_slave_control, SoCRegion(origin=0x8000a000, size=0x00001000, cached=False))
        self.bus.add_master(name="fastvdma_master_writer_1", master=fastvdma_ov2640_left.wb_master_writer)

        # Right camera DMA reader (camera -> memory)
        self.submodules.fastvdma_ov2640_right = fastvdma_ov2640_right = FastVDMA(self.platform, "AXIS_WB_WB")
        self.bus.add_slave("fastvdma_slave_control_2", self.fastvdma_ov2640_right.wb_slave_control, SoCRegion(origin=0x8000b000, size=0x00001000, cached=False))
        self.bus.add_master(name="fastvdma_master_writer_2", master=fastvdma_ov2640_right.wb_master_writer)

        # Left camera signals synchronization
        self.submodules.ov2640_left = OV2640(self.platform.request("ov2640", number=0), fastvdma_ov2640_left.io_sync_readerBusy)

        # Right camera signals synchronization
        self.submodules.ov2640_right = OV2640(self.platform.request("ov2640", number=1), fastvdma_ov2640_right.io_sync_readerBusy)

        self.platform.add_platform_command("set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets ov2640_left_pclk_clk]")
        self.platform.add_platform_command("set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets ov2640_right_pclk_clk]")

        # Connect camera to DMA
        self.comb += [
            # connection to FIFO
            fastvdma_ov2640_left.axi_stream_reader.data.eq(self.ov2640_left.fifo.source.data),
            fastvdma_ov2640_left.axi_stream_reader.valid.eq(self.ov2640_left.fifo.source.valid),
            self.ov2640_left.fifo.source.ready.eq(fastvdma_ov2640_left.axi_stream_reader.ready),
            fastvdma_ov2640_left.io_sync_readerSync.eq(self.ov2640_left.vsync[0] & ~self.ov2640_left.vsync[1]),

            fastvdma_ov2640_right.axi_stream_reader.data.eq(self.ov2640_right.fifo.source.data),
            fastvdma_ov2640_right.axi_stream_reader.valid.eq(self.ov2640_right.fifo.source.valid),
            self.ov2640_right.fifo.source.ready.eq(fastvdma_ov2640_right.axi_stream_reader.ready),
            fastvdma_ov2640_right.io_sync_readerSync.eq(self.ov2640_right.vsync[0] & ~self.ov2640_right.vsync[1]),
        ]

        # HDMI -------------------------------------------------------------------------------------
        dram_port = self.sdram.crossbar.get_port(
                mode         = "read",
                data_width   = 32,
                clock_domain = "pix",
                reverse      = False,
                rx_buffer_depth     = 32,
                cmd_buffer_depth    = 32,
                priority    = 1)

        self.clock_domains.cd_hdmi = ClockDomain()
        self.specials += Instance("BUFG", i_I=self.crg.cd_sys.clk, o_O=self.cd_hdmi.clk)

        self.submodules.framebuffer = framebuffer = ClockDomainsRenamer("hdmi")(VideoOut(
            device    = self.platform.device,
            pads      = self.platform.request("hdmi_out"),
            dram_port = dram_port,
            fifo_depth= 1024))

        self.comb += [
            self.cd_hdmi.rst.eq(self.framebuffer.reset.storage | self.crg.cd_sys.rst),
            framebuffer.driver.clocking.cd_pix.rst.eq(self.cd_hdmi.rst),
        ]

        clocking = framebuffer.driver.clocking
        self.platform.add_period_constraint(clocking.cd_pix.clk,   1e9/31.5e6)
        self.platform.add_period_constraint(clocking.cd_pix5x.clk, 1e9/(5*31.5e6))
        self.platform.add_false_path_constraints(
            self.crg.cd_sys.clk,
            framebuffer.driver.clocking.cd_pix.clk,
            framebuffer.driver.clocking.cd_pix5x.clk)

        # -| FastVDMA RAM reader 1 |----------------------------------------------------------------
        self.submodules.gpu_dma_r1 = FastVDMA(self.platform, "WB_WB_AXIS")

        # Attach FastVDMA's frontends to Wishbone bus
        self.bus.add_slave("gpu_dma_r1_ctrl", self.gpu_dma_r1.wb_slave_control,
                            SoCRegion(origin=0x8000c000, size=0x1000, cached=False))
        self.bus.add_master("gpu_dma_r1", self.gpu_dma_r1.wb_master_reader)

        # -| FastVDMA RAM reader 2 |----------------------------------------------------------------
        self.submodules.gpu_dma_r2 = FastVDMA(self.platform, "WB_WB_AXIS")

        # Attach FastVDMA's frontends to Wishbone bus
        self.bus.add_slave("gpu_dma_r2_ctrl", self.gpu_dma_r2.wb_slave_control,
                            SoCRegion(origin=0x8000d000, size=0x1000, cached=False))
        self.bus.add_master("gpu_dma_r2", self.gpu_dma_r2.wb_master_reader)

        # -| FastVDMA RAM writer |------------------------------------------------------------------
        self.submodules.gpu_dma_w = FastVDMA(self.platform, "AXIS_WB_WB")

        # Attach FastVDMA's frontends to Wishbone bus
        self.bus.add_slave("gpu_dma_w_ctrl", self.gpu_dma_w.wb_slave_control,
                            SoCRegion(origin=0x8000e000, size=0x1000, cached=False))
        self.bus.add_master("gpu_dma_w", self.gpu_dma_w.wb_master_writer)

        # Pass both inputs to GPU through FIFO to synchronize signals
        self.submodules.input1_fifo = input1_fifo = SyncFIFO([("data", 32)], 512)
        self.submodules.input2_fifo = input2_fifo = SyncFIFO([("data", 32)], 512)

        self.comb += [
            # Inputs from memory (images from cameras)
            self.gpu_dma_r1.axi_stream_writer.connect(input1_fifo.sink, omit={"user"}),

            # Inputs from memory (generated images with text)
            self.gpu_dma_r2.axi_stream_writer.connect(input2_fifo.sink, omit={"user"}),
        ]

        # -| Alpha blender |------------------------------------------------------------------------
        gpu_dmas = [input1_fifo.source, input2_fifo.source, self.gpu_dma_w.axi_stream_reader]
        self.submodules.gpu = GPU_2D(gpu_dmas)


# Build --------------------------------------------------------------------------------------------

def main():
    parser = argparse.ArgumentParser(description="LiteX SoC on Arty A7")
    parser.add_argument("--toolchain",           default="vivado",                 help="Toolchain use to build (default: vivado)")
    parser.add_argument("--build",               action="store_true",              help="Build bitstream")
    parser.add_argument("--load",                action="store_true",              help="Load bitstream")
    parser.add_argument("--variant",             default="a7-35",                  help="Board variant: a7-35 (default) or a7-100")
    parser.add_argument("--sys-clk-freq",        default=100e6,                    help="System clock frequency (default: 100MHz)")
    ethopts = parser.add_mutually_exclusive_group()
    ethopts.add_argument("--with-ethernet",      action="store_true",              help="Enable Ethernet support")
    ethopts.add_argument("--with-etherbone",     action="store_true",              help="Enable Etherbone support")
    parser.add_argument("--eth-ip",              default="192.168.1.50", type=str, help="Ethernet/Etherbone IP address")
    parser.add_argument("--eth-dynamic-ip",      action="store_true",              help="Enable dynamic Ethernet IP addresses setting")
    parser.add_argument("--no-ident-version",    action="store_false",             help="Disable build time output")
    builder_args(parser)
    soc_core_args(parser)
    vivado_build_args(parser)
    args = parser.parse_args()

    assert not (args.with_etherbone and args.eth_dynamic_ip)

    soc = ArtySoC(
        variant        = args.variant,
        toolchain      = args.toolchain,
        sys_clk_freq   = int(float(args.sys_clk_freq)),
        with_ethernet  = args.with_ethernet,
        with_etherbone = args.with_etherbone,
        eth_ip         = args.eth_ip,
        eth_dynamic_ip = args.eth_dynamic_ip,
        ident_version  = args.no_ident_version,
        **soc_core_argdict(args)
    )

    builder = Builder(soc, **builder_argdict(args))
    builder_kwargs = vivado_build_argdict(args) if args.toolchain == "vivado" else {}
    builder.build(**builder_kwargs, run=args.build)

    if args.load:
        prog = soc.platform.create_programmer()
        prog.load_bitstream(os.path.join(builder.gateware_dir, soc.build_name + ".bit"))

if __name__ == "__main__":
    main()
