#!/usr/bin/env python3

SHELL = /bin/bash

export UART_SPEED	?= 1843200
export PROJ_ROOT	:= $(realpath $(CURDIR))
export TARGET		?= digilent_arty
export TTY		:= $(wildcard /dev/ttyUSB?)

ifneq '$(TARGET)' 'digilent_arty'
	$(error Target $(TARGET) is not supported.)
endif

.PHONY: software program bitstream upload litex-software setup-litex setup-zephyr clean clean-software clean-bitstream

software:
	pushd $(PROJ_ROOT)/software/video-overlays-zephyr-app &&\
	west build -p auto -b litex_vexriscv app &&\
	popd

program:
ifeq "$(TTY)" ""
	$(error Device detection failed. If your board is connected, please set TTY flag, e.g. TTY="/dev/ttyUSB1")
else
	litex_term $(TTY) --speed $(UART_SPEED) --kernel $(PROJ_ROOT)/software/video-overlays-zephyr-app/build/zephyr/zephyr.bin
endif

bitstream:
	python3 $(PROJ_ROOT)/targets/$(TARGET).py --build --with-ethernet --eth-ip 192.0.2.1 --timer-uptime --csr-data-width 8 --uart-baudrate $(UART_SPEED) --csr-csv build/digilent_arty/csr.csv $(EXTRA_LITEX_ARGS)

upload:
	python3 $(PROJ_ROOT)/targets/$(TARGET).py --no-compile-software --load --lx-ignore-deps $(EXTRA_LITEX_ARGS)

litex-software:
	python3 $(PROJ_ROOT)/targets/$(TARGET).py --lx-ignore-deps --with-ethernet --eth-ip 192.0.2.1 --timer-uptime --csr-data-width 8 --uart-baudrate $(UART_SPEED) --csr-csv build/digilent_arty/csr.csv $(EXTRA_LITEX_ARGS)

setup-litex:
	$(PROJ_ROOT)/scripts/setup_litex

setup-zephyr:
	$(PROJ_ROOT)/scripts/setup_zephyr

clean: clean-software clean-bitstream

clean-software:
	rm -rf $(PROJ_ROOT)/software/zephyr/build

clean-bitstream:
	rm -rf $(PROJ_ROOT)/build
