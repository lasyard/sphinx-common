DRAWIO_CMD ?= /Applications/draw.io.app/Contents/MacOS/draw.io -x -f png
DRAWIO_SRC_DIR ?= _images
DRAWIO_DST_DIR ?= _generated_images

DRAWIO_SRCS := $(shell find $(DRAWIO_SRC_DIR) -type f -name '*.drawio')
DRAWIO_PNGS := $(patsubst $(DRAWIO_SRC_DIR)/%.drawio,$(DRAWIO_DST_DIR)/%.png,$(DRAWIO_SRCS))

$(DRAWIO_DST_DIR)/%.png: $(DRAWIO_SRC_DIR)/%.drawio
	- mkdir -p $(@D)
	$(DRAWIO_CMD) -o $@ $^

.PHONY: drawio drawio_clean

drawio: $(DRAWIO_PNGS)

drawio_clean:
	-rm -f $(DRAWIO_PNGS)
