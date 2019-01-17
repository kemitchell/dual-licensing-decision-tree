DETREE_GRAPHVIZ=node_modules/.bin/detree-graphviz
DETREE_HTML=node_modules/.bin/detree-html

all: build/tree.svg build/tree.png build/site

build/site: tree.lamos | $(DETREE_HTML) build
	$(DETREE_HTML) -d $< -t "Open Source License Wizard" -o $@

build/tree.dot: tree.lamos | $(DETREE_GRAPHVIZ) build
	$(DETREE_GRAPHVIZ) < $< > $@

%.svg: %.dot
	dot -Tsvg $< > $@

%.png: %.dot
	dot -Tpng $< > $@

build:
	mkdir -p $@

$(DETREE_GRAPHVIZ) $(DETREE_HTML):
	npm install

.PHONY: clean

clean:
	rm -rf build
