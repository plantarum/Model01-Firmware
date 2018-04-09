# This stub makefile for a Kaleidoscope plugin pulls in 
# all targets from the Kaleidoscope-Plugin library

export ARDUINO_PATH = /home/tws/hacking/arduino-1.8.5/
UNAME_S := $(shell uname -s)

ifeq ($(UNAME_S),Darwin)
SKETCHBOOK_DIR ?= $(HOME)/Documents/Arduino
PACKAGE_DIR ?= $(HOME)/Library/Arduino15
else
SKETCHBOOK_DIR ?= $(HOME)/Arduino
PACKAGE_DIR ?= $(HOME)/.arduino15
endif


ARDUINO_INSTALLED_ENV=$(shell ls -dt $(PACKAGE_DIR)/packages/keyboardio/hardware/avr/* 2>/dev/null |head -n 1)
MANUALLY_INSTALLED_ENV=$(shell ls -dt $(SKETCHBOOK_DIR)/hardware/keyboardio/avr 2>/dev/null |head -n 1)



ifneq ("$(wildcard $(ARDUINO_INSTALLED_ENV)/boards.txt)","")

ifneq ("$(wildcard $(MANUALLY_INSTALLED_ENV)/boards.txt)","")

$(info ***************************************************************************)
$(info It appears that you have installed two copies of Kaleidoscope. One copy was)
$(info installed using Arduino's "Board Manager", while the other was installed by)
$(info hand, probably using "git".)
$(info )
$(info This will likely cause some trouble as you try to build keyboard firmware)
$(info using Kaleidoscope. You may want to remove either: )
$(info )
$(info $(PACKAGE_DIR)/packages/keyboardio/ which was installed using Arduino)
$(info )
$(info or)
$(info )
$(info $(SKETCHBOOK_DIR)/hardware/keyboardio/ which was installed by hand.)
$(info )
$(info ***************************************************************************)
$(info )
	
endif

BOARD_HARDWARE_PATH = $(ARDUINO_INSTALLED_ENV)
KALEIDOSCOPE_PLUGIN_MAKEFILE_DIR ?= build-tools/makefiles/
KALEIDOSCOPE_BUILDER_DIR ?= $(ARDUINO_INSTALLED_ENV)/libraries/Kaleidoscope/bin/



endif


BOARD_HARDWARE_PATH ?= $(SKETCHBOOK_DIR)/hardware
KALEIDOSCOPE_PLUGIN_MAKEFILE_DIR ?= keyboardio/avr/build-tools/makefiles/

include $(BOARD_HARDWARE_PATH)/$(KALEIDOSCOPE_PLUGIN_MAKEFILE_DIR)/rules.mk
