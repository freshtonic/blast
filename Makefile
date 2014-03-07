
COFFEE = $(shell find src -name \*.coffee | grep -v bin)

JS = $(subst src, dist, $(addsuffix .js, $(basename $(COFFEE))))

all: blast.js

dist/blast.js: $(JS)
	@cat $(JS) > $@

dist/%.js: src/%.coffee
	@echo Compiling $< to $@
	@coffee --nodejs --no-deprecation  -o $(subst src, pkg, $(dir $@)) -c $<

clean:
	@rm -f $(JS)

.PHONY: clean all

.DEFAULT: all
