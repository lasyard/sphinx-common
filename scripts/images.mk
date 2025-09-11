CURRENT_DIR := $(dir $(lastword $(MAKEFILE_LIST)))

.PHONY: all clean

all: drawio puml
clean: drawio_clean puml_clean

include $(CURRENT_DIR)drawio.mk
include $(CURRENT_DIR)puml.mk
