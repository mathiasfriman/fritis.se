#
#
#
#
SOURCE_FILES=datorkommunikation.xml .htaccess fritis.css fritis.dsl index.in Makefile outline.txt laborationer/lab1_hub_vs_switch.sxw fdl-sv.xml fdl.xml kommandotabell.xml rfcer.xml asciitabell.xml dectobintabell.xml hextodectabell.xml netmask.xml ovningsuppgifter.xml services.xml topdomains.xml chap_sakerhet.xml chap_epost.xml
TARGET=datorkommunikation

LABORATIONS= #laborationer/lab1_hub_vs_switch.pdf

DATE=$(shell date +"%Y-%m-%d %H:%M:%S")
VERSION=$(shell gawk '/<revnumber>.*<\/revnumber>/ { match($$0, />(.*)</, arr); print arr[1]}' ${TARGET}.xml)

TITLE="Datorkommunikation"
BASE_FILE_NAME=$(TARGET)

export SP_ENCODING=UTF-8

.PHONY: index.html

all: html index.html ps pdf dist laborations

pub: all
	chmod -R o+r,g-rwxs * .htaccess
	chmod 705 laborationer
	rsync -e "ssh -l rejas" --recursive ./ flinthjarta:/var/www/rejas.se/www/static/fritis/$(TARGET)/

#fdl-sv.xml: ../common/licenses/fdl-sv.xml
#	cp ../common/licenses/fdl-sv.xml fdl-sv.xml

$(TARGET).tar.gz: $(SOURCE_FILES)
	mkdir $(TARGET)
	cp $(SOURCE_FILES) $(TARGET)
	tar -czf $(TARGET).tar.gz $(TARGET)
	rm -rf $(TARGET)

dist: $(TARGET).tar.gz

laborations: $(LABORATIONS)

html: book1.html

book1.html: $(SOURCE_FILES)
	docbook2html -d fritis.dsl#html $<

ps: $(TARGET).ps

$(TARGET).ps: $(SOURCE_FILES)
	docbook2ps -V tex-backend -d fritis.dsl#print $<

#$(TARGET).pdf: $(SOURCE_FILES)
#	docbook2pdf -V tex-backend -d fritis.dsl#print $<


pdf: $(TARGET).pdf

$(TARGET).pdf: $(TARGET).ps
	ps2pdf $(TARGET).ps


laborationer/lab1_hub_vs_switch.pdf: laborationer/lab1_hub_vs_switch.sxw
	echo "You have to use OpenOffice.org to create laborationer/lab1_hub_vs_switch.pdf"
	exit -1

index.html: index.in
	cat index.in | sed s/__TITLE__/$(TITLE)/ | \
	sed s/__BASE_FILE_NAME__/$(BASE_FILE_NAME)/g  | \
	sed s/__DATE__/'$(DATE)'/g | \
	sed s/__VERSION__/'$(VERSION)'/g > index.html

clean:
	rm -f *.html $(TARGET).ps $(TARGET).pdf $(TARGET).tar.gz
