AD=asciidoctor
BASE_NAME=grokking-bitcoin
MAIN=$(BASE_NAME).adoc
OUTPUTDIR=build
FULLBOOK=-a chall
ALLCHAPTERS=ch1 ch2 ch3 ch4 ch5 ch6 ch7 ch8 ch9 ch10 ch11 chans chweb chappendixa

all: full chunked

full: setup
	$(AD) -v $(FULLBOOK) -b html5 $(MAIN) -o $(OUTPUTDIR)/$(BASE_NAME).html

chunked: $(ALLCHAPTERS)

$(ALLCHAPTERS): ch% : setup
	$(AD) -v -r ./hacks/sectnumoffset-treeprocessor.rb -a sectnumoffset=$$(($*-1)) -a ch$* -b html5 $(MAIN) -o $(OUTPUTDIR)/$(BASE_NAME)-$*.html

setup: builddir links

builddir:
	mkdir -p $(OUTPUTDIR)

links:
	rm -f $(OUTPUTDIR)/images $(OUTPUTDIR)/style
	ln -sfr images $(OUTPUTDIR)
	ln -sfr style $(OUTPUTDIR)

clean:
	rm -rf $(OUTPUTDIR)
