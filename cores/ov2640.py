# Copyright (c) 2021-2022 Antmicro <www.antmicro.com>
# SPDX-License-Identifier: BSD-2-Clause

from migen import *
from migen.genlib.cdc import MultiReg

from litex.soc.interconnect.csr import *
from litex.soc.interconnect.stream import AsyncFIFO

from litex.soc.cores.clock import *

# OV2640 pads layout:
# "data":  8
# "pclk":  1
# "href":  1
# "vsync": 1

class OV2640(Module, AutoCSR):
    def __init__(self, pads, _dma_busy_signal):

        assert isinstance(_dma_busy_signal, Signal)

        self.vsync = vsync = [Signal()  for _ in range(2)]
        href = [Signal()  for _ in range(2)]
        data = [Signal(8) for _ in range(2)]
        dma_busy_signal = Signal()

        _data  = getattr(pads, "data")
        _pclk  = getattr(pads, "pclk")
        _href  = getattr(pads, "href")
        _vsync = getattr(pads, "vsync")

        # Connect pads to signals
        self.specials += [
            MultiReg(_vsync, vsync[0], odomain="pclk"),
            MultiReg(vsync[0], vsync[1], odomain="pclk"),
            MultiReg(_href, href[0], odomain="pclk"),
            MultiReg(href[0], href[1], odomain="pclk"),
            MultiReg(_dma_busy_signal, dma_busy_signal, odomain="pclk"),
        ]
        for i in range(8):
            self.specials += MultiReg(_data[i], data[0][i], odomain="pclk"),
            self.specials += MultiReg(data[0][i], data[1][i], odomain="pclk"),

        # Use PCLK as clock signal
        self.clock_domains.cd_pclk = ClockDomain()
        self.specials += [
            Instance("IBUFG", i_I=_pclk, o_O=self.cd_pclk.clk),
        ]

        self.first_pixel = first_pixel = Signal()
        counter = Signal(32)
        last_data = Signal(len(_data))

        # FSM
        self.submodules.fsm = fsm = ClockDomainsRenamer("pclk")(FSM(reset_state="WAIT_START_DMA"))
        self.submodules.fifo = fifo = ClockDomainsRenamer({"write": "pclk", "read": "sys"})(AsyncFIFO([("data", 32)], depth=512))

        fsm.act("WAIT_START_DMA",
            NextValue(fifo.sink.valid, 0),
            If(vsync[1] & dma_busy_signal,
                NextValue(counter, 0),
                NextState("CAPTURE"),
            )
        )
        fsm.act("CAPTURE",
            NextValue(first_pixel, 0),
            NextValue(fifo.sink.valid, 0),
            If(~dma_busy_signal | ~vsync[1],
                NextState("WAIT_START_DMA")
            ).Else(
                If (vsync[1] & href[1],
                    NextValue(counter, counter + 1),
                    If(counter == 1,
                        NextValue(first_pixel, 1),
                    ),
                    If(~counter & 1, #if counter % 2 == 0:
                        NextValue(last_data, data[1]),
                    ).Else(
                        NextValue(fifo.sink.valid, 1),
                        NextValue(fifo.sink.data,                               # Save RGBA pixel as Little Endian (ABGR32)
                            (last_data[3:] << 3) |                              # red   = pixel[11:16]
                            ((last_data[:3] << 5) | (data[1][5:] << 2)) << 8 |  # green = pixel[5:11]
                            (data[1][:5] << 3) << 16 |                          # blue  = pixel[:5]
                            0xff << 24
                        ),
                    )
                )
            )
        )
