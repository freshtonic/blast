
COFFEE = $(shell find src -name \*.coffee | grep -v bin)

JS = $(subst src, dist, $(addsuffix .js, $(basename $(COFFEE))))

VENDOR_JS = $(shell find vendor -type f)

dist/concatenation-order.txt: $(JS)
	@./sort-js > $@

dist/blast.js: dist/concatenation-order.txt
	cat $(shell cat $^) > $@

all: dist/blast.js
	@echo Done\!

dist/%.js: src/%.coffee
	@coffee --nodejs --no-deprecation  -o $(subst src, dist, $(dir $@)) -c $<

clean:
	@rm -f $(JS) concatenation-order.txt

.PHONY: clean all

.DEFAULT: all
