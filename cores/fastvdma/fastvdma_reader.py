# Copyright (c) 2021-2022 Antmicro <www.antmicro.com>
# SPDX-License-Identifier: BSD-2-Clause

import os

from migen import *

from litex.soc.interconnect import wishbone
from litex.soc.interconnect.axi import *
from litex.soc.interconnect.csr_eventmanager import *

class FastVDMAReader(Module, AutoCSR):
    def __init__(self, platform, data_width=32, adr_width=30):
        # Add verilog file with generated netlist for FastVDMA -------------------------------------
        platform.add_source(os.path.join(os.path.abspath(os.path.dirname(__file__)), "fastvdma_reader.v"), language="verilog")

        # Attach FastVDMA signals to Wishbone and AXI Stream Master --------------------------------
        self.wb_ctrl = wishbone.Interface(data_width, adr_width)
        self.wb_r = wishbone.Interface(data_width, adr_width)
        self.axi_m = AXIStreamInterface(data_width=32, user_width=32)

        self.irq_readerDone = Signal()
        self.irq_writerDone = Signal()

        self.sync_readerSync = Signal()
        self.sync_writerSync = Signal()

        self.specials += Instance("fastvdma_reader",
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

            i_io_read_dat_i = self.wb_r.dat_r,
            o_io_read_dat_o = self.wb_r.dat_w,
            o_io_read_cyc_o = self.wb_r.cyc,
            o_io_read_stb_o = self.wb_r.stb,
            o_io_read_we_o = self.wb_r.we,
            o_io_read_adr_o = self.wb_r.adr,
            o_io_read_sel_o = self.wb_r.sel,
            i_io_read_ack_i = self.wb_r.ack,
            #i_io_read_stall_i = 0,
            i_io_read_err_i = self.wb_r.err,

            o_io_write_tdata = self.axi_m.data,
            o_io_write_tvalid = self.axi_m.valid,
            i_io_write_tready = self.axi_m.ready,
            o_io_write_tuser = self.axi_m.user,
            o_io_write_tlast = self.axi_m.last,

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
