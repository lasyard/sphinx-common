PUML_CMD := java -jar ~/bin/plantuml.jar -failfast2 -tpng
PUML_SRC_DIR ?= images
PUML_DST_DIR ?= _generated_images

PUML_SRCS := $(shell find $(PUML_SRC_DIR) -type f -name '*.puml')
PUML_PNGS := $(patsubst $(PUML_SRC_DIR)/%.drawio,$(PUML_DST_DIR)/%.png,$(PUML_SRCS))

$(PUML_DST_DIR)/%.png: $(PUML_SRC_DIR)/%.puml
	$(PUML_CMD) $^
	mkdir -p $(@D) && mv -f $(^:%.puml=%.png) $@

.PHONY: puml puml_clean

puml: $(PUML_PNGS)

puml_clean:
	-rm -f $(PUML_PNGS)
