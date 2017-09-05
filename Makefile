.PHONY: all clean format reactor serve

SRC_PATH := src
STATIC_PATH := static
TEST_PATH := tests
STYLES_PATH := styles

ELM_MAKE := elm-make
ELM_MAKE_FLAG := --warn --yes

BUILD := build
TARGET_JS := $(BUILD)/main.js
TARGET_CSS := $(BUILD)/main.css
TARGET := $(TARGET_JS) $(TARGET_CSS) $(BUILD)/index.html
SRC_JS := $(shell find $(SRC_PATH) -name '*.js')
SRC_ELM := $(shell find $(SRC_PATH) -name '*.elm')
TEST_ELM := $(wildcard $(TEST_PATH)/*.elm)
SRC := $(SRC_PATH)/Main.elm $(SRC_JS) $(SRC_ELM)
SRC_CSS := $(STYLES_PATH)/Stylesheets.elm $(STYLES_PATH)/SharedStyles.elm

all: $(TARGET)

$(TARGET): $(BUILD)

$(BUILD):
	mkdir $@

$(BUILD)/main.js: $(SRC) $(BUILD)
	$(ELM_MAKE) $< --output $@ $(ELM_MAKE_FLAG)

$(STATIC_PATH)/main.css: $(SRC_CSS)
	elm css --output $(STATIC_PATH) $<

$(TARGET_CSS): $(STATIC_PATH)/main.css $(BUILD)
	cp $< $@

$(BUILD)/%.html: %.html $(BUILD)
	cp $< $@

format: $(SRC_ELM) $(TEST_ELM)
	elm-format-0.18 $^ --yes

clean:
	rm -rf elm-stuff/build-artifacts/
	rm -f $(TARGET)
	rm -rf $(BUILD)

live: $(SRC)
	elm-live \
		--output=$(STATIC_PATH)/main.js $< \
		--host=$(shell hostname) \
		--pushstate \
		--debug \
		--dir=$(STATIC_PATH)

cloc:
	cloc --vcs=git
