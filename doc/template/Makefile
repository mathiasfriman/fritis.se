#
# Makefile för boken boktitel
#
#
SOURCE_FILES=boktitel.xml fritis.dsl fritis.css index.in Makefile fdl.xml fdl-sv.xml
TARGET=boktitel

DATE=$(shell date +"%Y-%m-%d %H:%M:%S")
VERSION=$(shell gawk '/<revnumber>.*<\/revnumber>/ { match($$0, />(.*)</, arr); print arr[1]}' ${TARGET}.xml)

TITLE="Bokens Titel"
BASE_FILE_NAME=$(TARGET)

.PHONY: index.html

all: html index.html ps pdf dist

pub: all
	chmod -R o+r,g-rwxs *
	rsync -e "ssh -l rejas" --delete --recursive ./ namatj.rejas.se:www.rejas.se/static/fritis/$(TARGET)/

$(TARGET).tar.gz: $(SOURCE_FILES)
	mkdir $(TARGET)
	cp $(SOURCE_FILES) $(TARGET)
	tar -czf $(TARGET).tar.gz $(TARGET)
	rm -rf $(TARGET)

dist: $(TARGET).tar.gz

html: $(SOURCE_FILES) index.html
	docbook2html -d fritis.dsl#html $<

ps: $(TARGET).ps

$(TARGET).ps: $(SOURCE_FILES)
	docbook2ps -d fritis.dsl#print $<

pdf: $(TARGET).pdf

$(TARGET).pdf: $(TARGET).ps
	ps2pdf $(TARGET).ps

index.html: index.in
	cat index.in | sed s/__TITLE__/$(TITLE)/ | \
	sed s/__BASE_FILE_NAME__/$(BASE_FILE_NAME)/g  | \
	sed s/__DATE__/'$(DATE)'/g | \
	sed s/__VERSION__/'$(VERSION)'/g > index.html

clean:
	rm -f *.html $(TARGET).ps $(TARGET).pdf $(TARGET).tar.gz
