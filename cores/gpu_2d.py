# Copyright (c) 2021-2022 Antmicro <www.antmicro.com>
# SPDX-License-Identifier: Apache-2.0

from enum import IntEnum

from migen import *

from litex.soc.interconnect.axi import *
from litex.soc.interconnect.csr import *

# -| 2D GPU operating modes |------------------------------------------------------
class GPU_MODE(IntEnum):
    IDLE            = 0b00
    ALPHA_BLENDER   = 0b01
    FILL_AREA       = 0b10

class GPU_2D(Module, AutoCSR):
    def __init__(self, DMA):
        # -| GPU control status register |--------------------------------------
        self.ctrl_reg = CSRStorage(8, description="GPU mode control register")
        self.fill_clr = CSRStorage(32, description="Color to fill area with register")

        # -| Interface GPU's and DMAs I/O with AXI Stream |---------------------
        self.axi_in1 = AXIStreamInterface()
        self.axi_in2 = AXIStreamInterface()
        self.axi_out = AXIStreamInterface()
        self.comb += [
            # Input 1
            self.axi_in1.valid.eq(DMA[0].valid),
            DMA[0].ready.eq(self.axi_in1.ready),
            self.axi_in1.last.eq(DMA[0].last),

            # Input 2
            self.axi_in2.valid.eq(DMA[1].valid),
            DMA[1].ready.eq(self.axi_in2.ready),
            self.axi_in2.last.eq(DMA[1].last),

            # Output
            DMA[2].valid.eq(self.axi_out.valid),
            self.axi_out.ready.eq(DMA[2].ready),
            DMA[2].last.eq(self.axi_out.last),
        ]

        #self.sync += DMA[2].valid.eq(self.axi_out.valid)

        # -| AXI-Stream handshake |---------------------------------------------
        input_rdy  = [Signal() for _ in range(4)]
        output_rdy = Signal()

        self.comb += [
            input_rdy[0].eq(DMA[0].valid & DMA[1].valid
                            & DMA[0].ready & DMA[1].ready),
            output_rdy.eq(self.axi_out.valid & self.axi_out.ready)
        ]

        # Pass status of data reception to the output
        for i in range(3):
            self.sync += input_rdy[i+1].eq(input_rdy[i])

        self.comb += [
            If(input_rdy[0],
                self.axi_in1.data.eq(DMA[0].data),
                self.axi_in2.data.eq(DMA[1].data),
            ),
            If(output_rdy,
                DMA[2].data.eq(self.axi_out.data),
            )
        ]

        # -| GPU operating modes |----------------------------------------------
        # -| Alpha blender mode |-
        blender_rdy = Signal()
        self.comb += [
            blender_rdy.eq(DMA[0].valid & DMA[1].valid & DMA[2].ready),
            If(self.ctrl_reg.storage == GPU_MODE.ALPHA_BLENDER,
                # Input ready to process new pixels
                If(blender_rdy,
                    self.axi_in1.ready.eq(1),
                    self.axi_in2.ready.eq(1),
                ).Else(
                    self.axi_in1.ready.eq(0),
                    self.axi_in2.ready.eq(0),
                )
            )
        ]
        self.sync += [
            If(self.ctrl_reg.storage == GPU_MODE.ALPHA_BLENDER,
                # Output ready to transmit processed pixels
                If(input_rdy[3],
                    self.axi_out.valid.eq(1),
                ).Else(
                    self.axi_out.valid.eq(0),
                )
            )
        ]

        # Group 8-bit colors from input 1 and input 2 pixels
        rgba1 = [Signal(8) for _ in range(4)]
        rgba2 = [Signal(8) for _ in range(4)]
        for i in range(4):
            self.sync += rgba1[i].eq(self.axi_in1.data[8*i:8*(i+1)])
            self.sync += rgba2[i].eq(self.axi_in2.data[8*i:8*(i+1)])

        red     = [Signal(16) for _ in range(3)]
        green   = [Signal(16) for _ in range(3)]
        blue    = [Signal(16) for _ in range(3)]
        self.sync += [
            If(self.ctrl_reg.storage == GPU_MODE.ALPHA_BLENDER,
                # Blend RGBA colors with each other
                # Blend red colors (rgbax[0])
                red[0].eq((rgba1[3] + 1) * rgba1[0]),
                red[1].eq((256 - rgba1[3]) * rgba2[0]),
                red[2].eq(red[0] + red[1]),

                # Blend green colors (rgbax[1])
                green[0].eq((rgba1[3] + 1) * rgba1[1]),
                green[1].eq((256 - rgba1[3]) * rgba2[1]),
                green[2].eq(green[0] + green[1]),

                # Blend blue colors (rgbax[2])
                blue[0].eq((rgba1[3] + 1) * rgba1[2]),
                blue[1].eq((256 - rgba1[3]) * rgba2[2]),
                blue[2].eq(blue[0] + blue[1]),

                self.axi_out.data.eq(Cat(red[2][8:], green[2][8:], blue[2][8:], 0xFF))
            )
        ]

        # -| Fill area with a color mode |-
        self.sync += [
            If(self.ctrl_reg.storage == GPU_MODE.FILL_AREA,
                self.axi_out.data.eq(self.fill_clr.storage),
                If(self.axi_out.data == self.fill_clr.storage,
                    self.axi_out.valid.eq(1),
                ).Else(
                    self.axi_out.valid.eq(0),
                )
            )
        ]

