#
# Denna Makefile är inte klar. 
#
#
TARGET=handboken
SOURCE=handboken.xml

IMAGES=$(shell ls bilder/*.png)
EPS_IMAGES=$(shell for i in bilder/*.png; do echo $${i%.png}.eps; done)
JPG_IMAGES=$(shell for i in bilder/*.png; do echo $${i%.png}.jpeg; done)

SOURCE_FILES=fritis.css index.in Makefile fritis.dsl $(IMAGES)

%.eps: %.png
	convert $<  $@

%.jpeg: %.png
	convert $<  $@


TITLE="GIMP Handbok"
BASE_FILE_NAME=gimphandbok

DATE=$(shell date +"%Y-%m-%d %H:%M:%S")

.PHONY: index.html

all: html index.html ps pdf dist

pub: all
	chmod -R o+r,g-rwxs *
	rsync -e "ssh -l rejas" --delete --recursive ./ namatj.rejas.se:www.rejas.se/static/fritis/$(BASE_FILE_NAME)/



$(BASE_FILE_NAME).tar.gz: $(SOURCE_FILES) $(IMAGES)
	echo $(SOURCE_FILES)
	mkdir $(BASE_FILE_NAME)
	cp $(SOURCE_FILES) $(BASE_FILE_NAME)
	tar -czf $(BASE_FILE_NAME).tar.gz $(BASE_FILE_NAME)
	rm -rf $(BASE_FILE_NAME)

dist: $(BASE_FILE_NAME).tar.gz

html: $(SOURCE) $(JPG_IMAGES)
	docbook2html -d fritis.dsl#html $(SOURCE)

#
# Skapa en xmlfil med iso8859-15
#
$(SOURCE): handboken
	echo cat handboken | iconv -f utf8 -t iso8859-15 > $(SOURCE)
	cat handboken | iconv -f utf8 -t iso8859-15 > $(SOURCE)

ps: $(TARGET).ps

$(TARGET).ps: $(SOURCE) $(EPS_IMAGES)
	docbook2ps -d fritis.dsl#print $(SOURCE)

pdf: $(TARGET).pdf

$(TARGET).pdf: $(TARGET).ps
	ps2pdf $(TARGET).ps

index.html: index.in
	cat index.in | sed s/__TITLE__/$(TITLE)/ | \
	sed s/__BASE_FILE_NAME__/$(BASE_FILE_NAME)/g  | \
	sed s/__DATE__/"$(DATE)"/g > index.html

clean:
	rm -f *.html $(TARGET).ps $(TARGET).pdf $(BASE_FILE_NAME).tar.gz
