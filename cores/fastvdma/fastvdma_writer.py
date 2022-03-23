# Copyright (c) 2021-2022 Antmicro <www.antmicro.com>
# SPDX-License-Identifier: BSD-2-Clause

import os

from migen import *

from litex.soc.interconnect import wishbone
from litex.soc.interconnect.axi import *
from litex.soc.interconnect.csr_eventmanager import *

class FastVDMAWriter(Module, AutoCSR):
    def __init__(self, platform, data_width=32, adr_width=30):
        # Add verilog file with generated netlist for FastVDMA -------------------------------------
        platform.add_source(os.path.join(os.path.abspath(os.path.dirname(__file__)), "fastvdma_writer.v"), language="verilog")

        # Attach FastVDMA signals to Wishbone and AXI Stream ---------------------------------------
        self.wb_ctrl = wishbone.Interface(data_width, adr_width)
        self.wb_w = wishbone.Interface(data_width, adr_width)
        self.axi_s = AXIStreamInterface(data_width=32, user_width=32)

        self.irq_readerDone = Signal()
        self.irq_writerDone = Signal()

        self.sync_readerSync = Signal()
        self.sync_writerSync = Signal()

        self.specials += Instance("fastvdma_writer",
            i_clock = ClockSignal(),
            i_reset = ResetSignal(),
            i_io_control_dat_i = self.wb_ctrl.dat_w,
            o_io_control_dat_o = self.wb_ctrl.dat_r,
            i_io_control_cyc_i = self.wb_ctrl.cyc,
            i_io_control_stb_i = self.wb_ctrl.stb,
            i_io_control_we_i = self.wb_ctrl.we,
            i_io_control_adr_i = self.wb_ctrl.adr,
            i_io_control_sel_i = self.wb_ctrl.sel,
            o_io_control_ack_o = self.wb_ctrl.ack,
            #o_io_control_stall_o = 0,
            o_io_control_err_o = self.wb_ctrl.err,

            i_io_write_dat_i = self.wb_w.dat_r,
            o_io_write_dat_o = self.wb_w.dat_w,
            o_io_write_cyc_o = self.wb_w.cyc,
            o_io_write_stb_o = self.wb_w.stb,
            o_io_write_we_o = self.wb_w.we,
            o_io_write_adr_o = self.wb_w.adr,
            o_io_write_sel_o = self.wb_w.sel,
            i_io_write_ack_i = self.wb_w.ack,
            #i_io_write_stall_i = 0,
            i_io_write_err_i = self.wb_w.err,

            i_io_read_tdata = self.axi_s.data,
            i_io_read_tvalid = self.axi_s.valid,
            o_io_read_tready = self.axi_s.ready,
            i_io_read_tuser = self.axi_s.user,
            i_io_read_tlast = self.axi_s.last,

            o_io_irq_readerDone = self.irq_readerDone,
            o_io_irq_writerDone = self.irq_writerDone,

            i_io_sync_readerSync = self.sync_readerSync,
            i_io_sync_writerSync = self.sync_writerSync,
        )

        # Add IRQs
        self.submodules.ev = EventManager()
        self.ev.writerDone = EventSourceLevel()
        self.ev.finalize()

        self.comb += [
            self.ev.writerDone.trigger.eq(self.irq_writerDone),
        ]
