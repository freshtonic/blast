
COFFEE = $(shell find src -name \*.coffee | grep -v bin)

JS = $(subst src, dist, $(addsuffix .js, $(basename $(COFFEE))))

VENDOR_JS = $(shell find vendor -type f)

dist/blast.js: $(VENDOR_JS) $(JS)
	@cat $(VENDOR_JS) $(JS) > $@

all: blast.js

dist/%.js: src/%.coffee
	@echo Compiling $< to $@
	@coffee --nodejs --no-deprecation  -o $(subst src, pkg, $(dir $@)) -c $<

clean:
	@rm -f $(JS)

.PHONY: clean all

.DEFAULT: all
