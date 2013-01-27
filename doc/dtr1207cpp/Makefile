
SOURCE=boken.xml
SOURCES=$(wildcard *.xml)
DOCBOOK2PDF=$(shell which docbook2pdf 2>/dev/null|head -1)
DOCBOOK2HTML=$(shell which docbook2html 2>/dev/null|head -1)

XSLTPROC=/sw/bin/xsltproc
FOP=/Users/jonas/fop-0.20.5/fop.sh

ifeq ($(DOCBOOK2PDF),"")
pdf: $(SOURCES)
       $(XSLTPROC) \
          --output dtr1207cpp.fo \
          /fo/docbook.xsl \
          $(SOURCE)
       $(FOP) -fo dtr1207cpp.fo -pdf dtr1207cpp.pdf

else
dtr1207cpp.pdf: $(SOURCES)
	$(DOCBOOK2PDF) $(SOURCE)
	mv boken.pdf dtr1207cpp.pdf

dtr1207cpp-a5.pdf: $(SOURCES)
	SGML_OPTIONS="paper-type=A5" $(DOCBOOK2PDF) $(SOURCE)
	mv boken.pdf dtr1207cpp-a5.pdf
endif

ifeq ($(DOCBOOK2HTML),"")
html: $(SOURCES)
       $(XSLTPROC) \
          --output dtr1207cpp.html \
          docbookx.xsl \
          $(SOURCE)

else
html: html/index.html
html/index.html: $(SOURCES)
	mkdir -p html && \
	cd html && \
	$(DOCBOOK2HTML) ../boken.xml

endif

clean:
	rm -rf dtr1207cpp.html dtr1207cpp.pdf html
