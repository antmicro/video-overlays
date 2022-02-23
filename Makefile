#!/usr/bin/env python3

SHELL = /bin/bash

export UART_SPEED	?= 1843200
export PROJ_ROOT	:= $(realpath $(CURDIR))
export TARGET		?= digilent_arty

ifneq '$(TARGET)' 'digilent_arty'
	$(error Target $(TARGET) is not supported.)
endif

.PHONY: software bitstream litex-software setup-litex setup-zephyr clean clean-software clean-bitstream

software:
	pushd $(PROJ_ROOT)/software/video-overlays-zephyr-app &&\
	west build -p auto -b litex_vexriscv app &&\
	popd

bitstream:
	python3 $(PROJ_ROOT)/targets/$(TARGET).py --build --with-ethernet --eth-ip 192.0.2.1 --timer-uptime --csr-data-width 8 --uart-baudrate $(UART_SPEED) --csr-csv build/digilent_arty/csr.csv $(EXTRA_LITEX_ARGS)

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
