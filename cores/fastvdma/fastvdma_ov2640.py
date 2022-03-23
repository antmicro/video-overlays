# Copyright (c) 2021-2022 Antmicro <www.antmicro.com>
# SPDX-License-Identifier: BSD-2-Clause

import os

from migen import *
from litex.soc.interconnect import wishbone, axi
from litex.soc.interconnect.csr_eventmanager import *
from litex.soc.interconnect.csr import *

class FastVDMA_OV2640(Module, AutoCSR):
    """Verilog based FastVDMA Core

    Parameters
    ----------
    mode : string in ["AXIS_to_WB", "AXIS_to_AXIS"]
    - "AXIS_to_WB": AXI Stream to Wishbone
    - "AXIS_to_AXIS": AXI Stream to AXI Stream

    Both modes use Wishbone to control FastVDMA CSRs
    """
    def __init__(self, platform, mode="AXIS_to_WB"):
        assert mode in ["AXIS_to_WB", "AXIS_to_AXIS"]

        self.wb_slave_control = wishbone.Interface(data_width=32, adr_width=30)

        if mode == "AXIS_to_WB":
            verilog_filename = "fastvdma_axis_to_wb.v"

            self.wb_master_writer = wishbone.Interface(data_width=32, adr_width=30)
            self.axi_stream_reader = axi.AXIStreamInterface(data_width=32, user_width=32)
        elif mode == "AXIS_to_AXIS":
            verilog_filename = "fastvdma_axis_to_axis.v"

            self.axi_stream_reader = axi.AXIStreamInterface(data_width=32, user_width=32)
            self.axi_m = axi.AXIStreamInterface(data_width=32, user_width=32)

        self.io_irq_readerDone   = Signal()
        self.io_irq_writerDone   = Signal()

        self.io_sync_readerSync  = Signal()
        self.io_sync_writerSync  = Signal()
        self.io_sync_readerBusy  = Signal()
        self.io_sync_writerBusy  = Signal()

        if mode == "AXIS_to_WB":
            self.specials += Instance("AXIS_to_WB",
                i_clock                 = ClockSignal(),
                i_reset                 = ResetSignal(),

                i_io_control_dat_i      = self.wb_slave_control.dat_w,
                o_io_control_dat_o      = self.wb_slave_control.dat_r,
                i_io_control_cyc_i      = self.wb_slave_control.cyc,
                i_io_control_stb_i      = self.wb_slave_control.stb,
                i_io_control_we_i       = self.wb_slave_control.we,
                i_io_control_adr_i      = self.wb_slave_control.adr,
                i_io_control_sel_i      = self.wb_slave_control.sel,
                o_io_control_ack_o      = self.wb_slave_control.ack,
                o_io_control_err_o      = self.wb_slave_control.err,

                i_io_read_tdata         = self.axi_stream_reader.data,
                i_io_read_tvalid        = self.axi_stream_reader.valid,
                o_io_read_tready        = self.axi_stream_reader.ready,
                i_io_read_tuser         = self.axi_stream_reader.user,
                i_io_read_tlast         = self.axi_stream_reader.last,

                i_io_write_dat_i        = self.wb_master_writer.dat_r,
                o_io_write_dat_o        = self.wb_master_writer.dat_w,
                o_io_write_cyc_o        = self.wb_master_writer.cyc,
                o_io_write_stb_o        = self.wb_master_writer.stb,
                o_io_write_we_o         = self.wb_master_writer.we,
                o_io_write_adr_o        = self.wb_master_writer.adr,
                o_io_write_sel_o        = self.wb_master_writer.sel,
                i_io_write_ack_i        = self.wb_master_writer.ack,
                i_io_write_err_i        = self.wb_master_writer.err,

                o_io_irq_readerDone     = self.io_irq_readerDone,
                o_io_irq_writerDone     = self.io_irq_writerDone,

                i_io_sync_readerSync    = self.io_sync_readerSync,
                i_io_sync_writerSync    = self.io_sync_writerSync,
                o_io_sync_readerBusy    = self.io_sync_readerBusy,
                o_io_sync_writerBusy    = self.io_sync_writerBusy,
            )
        elif mode == "AXIS_to_AXIS":
            self.specials += Instance("AXIS_to_AXIS",
                i_clock                 = ClockSignal(),
                i_reset                 = ResetSignal(),

                i_io_control_dat_i      = self.wb_slave_control.dat_w,
                o_io_control_dat_o      = self.wb_slave_control.dat_r,
                i_io_control_cyc_i      = self.wb_slave_control.cyc,
                i_io_control_stb_i      = self.wb_slave_control.stb,
                i_io_control_we_i       = self.wb_slave_control.we,
                i_io_control_adr_i      = self.wb_slave_control.adr,
                i_io_control_sel_i      = self.wb_slave_control.sel,
                o_io_control_ack_o      = self.wb_slave_control.ack,
                o_io_control_err_o      = self.wb_slave_control.err,

                i_io_read_tdata         = self.axi_stream_reader.data,
                i_io_read_tvalid        = self.axi_stream_reader.valid,
                o_io_read_tready        = self.axi_stream_reader.ready,
                i_io_read_tuser         = self.axi_stream_reader.user,
                i_io_read_tlast         = self.axi_stream_reader.last,

                o_io_write_tdata        = self.axi_m.data,
                o_io_write_tvalid       = self.axi_m.valid,
                i_io_write_tready       = self.axi_m.ready,
                o_io_write_tuser        = self.axi_m.user,
                o_io_write_tlast        = self.axi_m.last,

                o_io_irq_readerDone     = self.io_irq_readerDone,
                o_io_irq_writerDone     = self.io_irq_writerDone,

                i_io_sync_readerSync    = self.io_sync_readerSync,
                i_io_sync_writerSync    = self.io_sync_writerSync,
                o_io_sync_readerBusy    = self.io_sync_readerBusy,
                o_io_sync_writerBusy    = self.io_sync_writerBusy,
            )

        # Add IRQs
        self.submodules.ev = EventManager()
        self.ev.writerDone = EventSourceLevel()
        self.ev.finalize()

        self.comb += [
            self.ev.writerDone.trigger.eq(self.io_irq_writerDone),
        ]

        platform.add_source(os.path.join(os.path.abspath(os.path.dirname(__file__)), verilog_filename), language="verilog")
