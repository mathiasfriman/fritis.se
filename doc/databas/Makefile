# 
# Makefile for Databashantering, Jonas Björk
# 2004-01-12 jonas@trinix.se
# 

D2HTML = docbook2html
RM	= rm -rf

TITLE = "Databashantering"
BASE_FILE_NAME = "databashantering"
DATE = $(shell date +"%Y-%m-%d %H:%M")
SOURCE	= databashantering.xml

.PHONY: index.html

all: html index.html pub

html:
	$(RM) output/
	mkdir output
	$(D2HTML) -d include/docbook.dsl -o output/ $(SOURCE)
	cp include/book.css output/

index.html: index.in
	cat index.in | sed s/__TITLE__/$(TITLE)/ | \
	sed s/__BASE_FILE_NAME__/$(BASE_FILE_NAME)/g | \
	sed s/__DATE__/"$(DATE)"/g > output/index.html

pub:
	cp output/* /home/wwwroot/databas/

clean:
	$(RM) output/ *.html
