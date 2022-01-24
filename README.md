# Video Overlays

Copyright (c) 2021-2022 [Antmicro](https://www.antmicro.com)

## Overview

The Video Overlays project is a fully open source reference system for overlaying data onto a video stream on FPGA, based on the LiteX ecosystem and Zephyr RTOS. It provides an application with a CLI to control the OmniVision OV2640 camera configuration and a GPU IP Core to capture and process images. The stream from the camera can be displayed directly via HDMI or can be first processed by the GPU to apply an overlay on top of it.

## Supported features

The application which provides a CLI which exposes many configuration possibilites to the user:
- camera configuration:
  - resolution,
  - brightness,
  - saturation,
  - quality,
  - white balance,
  - gain control,
  - exposure control,
  - horizontal flip,
  - vertical flip,
  - output format (JPEG, RGB565),
  - colorbar,
  - clock divider,

- display configuration:
  - resolution (640x480, 800x600, 1024x768, 1280x1024),
  - reset IP-Core clock domains,
  - reset IP-Core registers.

- overlay:
  - manually set text to be overlaid by GPU on captured image,

- test functionalities:
  - display colors - display red, green and blue image with a 2s delay between them,
  - display buffer - display single image capture by the chosen choosed camera,
  - display video - display video captured by the chosen camera,
  - display video with overlay - display video captured by choosed camera processed by the GPU,
  - display image with overlay - display single image captured by choosed camera processed by the GPU,
  - generate and send overlay - generate single overlay image and send it via the UDP protocol,
  - send image - send image captured by chosen camera via the UDP protocol.

## Architecture

The SoC works on top of VexRiscv softcore which is 32-bit RISCV-V CPU written in [Spinal HDL](https://github.com/SpinalHDL/SpinalHDL).
The SoC is created using LiteX, LiteX's cores and independent FastVDMA cores:
- [LiteX](https://github.com/antmicro/litex/tree/video-overlays) - SoC builder,
- [LiteDRAM](https://github.com/antmicro/litedram/tree/upconverter_rewrite) - DRAM memory controller,
- [LiteEth](https://github.com/enjoy-digital/liteeth) - Ethernet core,
- [LiteX Boards](https://github.com/antmicro/litex-boards/tree/video-overlays) - basic reference SoC,
- [LiteVideo](https://github.com/antmicro/litevideo/tree/video-overlays) - HDMI interface,
- [FastVDMA](https://github.com/antmicro/fastvdma/) - DMA controllers.

Below you can see an architecture diagram with the most important IP-Cores:
<img src="docs/vo_architecture.png" width="800">

In order to provide maximum performance when receiving data from cameras, the `pclk` signal is treated as an additional `ClockDomain`. The data from the cameras is converted to RGBA32 in order to make it compatible with the input expected by the GPU. It is redirected through `AsyncFIFO` to FastVDMA which writes it to the RAM memory. Another 2 FastVDMA instances read data from memory and pass it to the GPU as an AXI Stream. The last FastVDMA instance writes the GPU output to the memory. It is then read by the LiteDRAM DMA controller inside the LiteVideo core.
All IP Cores which are configurable from the OS level are configured via the Control/Status Registers (CSRs).

## Hardware

The SoC is dedicated for an Arty A7-35T board, but it should be easily portable to any other board which supports 4x PMOD connectors needed to attach an Expansion Board. This project has been tested with the following hardware:
- [Arty A7-35T](https://digilent.com/reference/programmable-logic/arty-a7/start)
- [OmniVision OV2640](https://www.uctronics.com/download/cam_module/OV2640DS.pdf) - sensors were extracted from [Waveshare OV2640](https://www.waveshare.com/ov2640-camera-board.htm)
- [Camera board adapter]()
- [Arty Expansion Board]()
- each camera requires a 24-pin FFC cable with both connectors on the same side

Below is the whole setup with 2 cameras:
<img src="docs/arty_with_expansion_board.jpg" width="800">

## Building and running the project

### Prerequisites

Install the Vivado toolchain. You can download Vivado using this [link](https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/vivado-design-tools/archive.html).
The 2017.3 or newer version of Vivado is recommended.
Next follow the instructions below:

1. Get all required submodules:

```bash
git submodule update --init --recursive
```

2. Get all required packages:
```bash
apt-get install build-essential bzip2 python3 python3-dev python3-pip xc3sprog
./install.sh
```

### Build bitstream

1. Build the bitstream following these steps:

```bash
source ./init
source ${PATH_TO_VIVADO_TOOLCHAIN}/settings64.sh
targets/digilent_arty.py --build --with-ethernet --eth-ip 192.0.2.1 --timer-uptime --csr-data-width 8 --csr-csv csr.csv --uart-baudrate 1843200
```

### Upload bitstream

If you have already installed `xc3sprog` and built a bitstream, connect your board to PC and run following command:
```bash
xc3sprog -c nexys4 digilent_arty.bit
```

### Build and flash software

To build an application follow the instructions in the [Video Overlays Application repository](https://github.com/antmicro/video-overlays-zephyr-app). Then upload the binary with following command:
```bash
litex_term /dev/ttyUSB1 --speed 1843200 --kernel zephyr.bin
```
Note: `ttyUSB1` might be different on your machine so make sure what is your device name.

## Source code structure

- [targets](targets/digilent_arty.py) contains the SoC description for the supported boards:
- [third_party/litex/litex/soc/cores](third_party/litex/litex/soc/cores) contains sources of the LiteX Boards:
  - [fastvdma](third_party/litex/litex/soc/cores/fastvdma) contains FastVDMA IP-Cores and Verilog sources,
  - [ov2640.py](third_party/litex/litex/soc/cores/ov2640.py) is an IP-Core for OmniVision OV2640 image digital sensor,
  - [gpu.py](third_party/litex/litex/soc/cores/gpu.py) is an IP-Core with GPU capable of blending images or filling images with color.
