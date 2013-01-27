<!--
	fritis.dsl

	Version: $Revision: 1.2 $


	Detta �r en Style Sheet f�r b�ckerna som skrivs f�r projektet
	Fritis - Fri IT i skolan.

	Fr�gor eller kommentarer skickas till marcus@rejas.se
-->

<!DOCTYPE style-sheet PUBLIC "-//James Clark//DTD DSSSL Style Sheet//EN" [
  <!-- default mode is print -->
  <!ENTITY % html  "IGNORE">
  <!ENTITY % print "INCLUDE">

  <![ %html; [
    <!ENTITY % print "IGNORE">
    <!ENTITY docbook.dsl PUBLIC "-//Norman Walsh//DOCUMENT DocBook HTML Stylesheet//EN" CDATA DSSSL>
  ]]>

  <![ %print; [
    <!ENTITY % html  "IGNORE">
    <!ENTITY docbook.dsl PUBLIC "-//Norman Walsh//DOCUMENT DocBook Print Stylesheet//EN" CDATA DSSSL>
  ]]>
]>

<style-sheet>

<style-specification id="print" use="common">
<style-specification-body> 
;;
;; F�ljande deklarationer g�ller bara f�r print. Det vill s�ga n�r denna
;; fil anropas med exempelvis:
;; 
;; docbook2ps -d fritis.dsl#print filnamn.xml
;;


;;
;; Vi anv�nder A4-papper, vanligtvis.
;;
(define %paper-type% "A4")



;;
;; F�r utskrift godk�nner vi brara EPS-grafik
;;
(define preferred-mediaobject-extensions  ;; this magic allows to use different graphical
   (list "eps"))			  ;; formats for printing and putting online
(define acceptable-mediaobject-extensions
   '())
(define preferred-mediaobject-notations
   (list "EPS"))
(define acceptable-mediaobject-notations
   (list "linespecific"))

;;(element (figure caption para)
;;	(make paragraph
;;	    space-before: 8pt
;;	    (process-children)))

;;
;; Fotn�tter :) 
;;
(define bop-footnotes
  ;; Make "bottom-of-page" footnotes?
  #t)


;;
;; Lite finjusteringar av layout.
;;
(define %head-after-factor% 0.2)	;; not much whitespace after orderedlist head
(define ($paragraph$)			;; more whitespace after paragraph than before
  (make paragraph
    first-line-start-indent: (if (is-first-para)
                                 %para-indent-firstpara%
                                 %para-indent%)
    space-before: (* %para-sep% 4)
    space-after: (/ %para-sep% 4)
    quadding: %default-quadding%
    hyphenate?: %hyphenation%
    language: (dsssl-language-code)
    (process-children)))


;; 
;; Avst�ndet mellan raderna, 1,6 �r lite mer �n vad som �r normalt. Jag
;; tycker att det g�r texten mer l�ttl�st, tycker du inte du det eller
;; om du tycker att det sliter f�r h�rt p� skogen s� �ndrar du det.
;;
(define %line-spacing-factor% 1.6)



;;
;; Kommentera bort denna om du vill ha raka marginaler. Det �r
;; bortkommenterat per default eftersom det leder till lite konstiga
;; avstavningar ibland men testa det g�rna.
;;
;(define %default-quadding%   
;  'justify)

;;
;; F�r tv�sidig utskrift, fungerar inte riktigt �nnu.
;;
(define %two-side% 
  ;; Is two-sided output being produced?
  #f)

</style-specification-body>
</style-specification>
<style-specification id="html" use="common">
<style-specification-body> 

;;
;; F�ljande deklarationer g�ller bara f�r html. Det vill s�ga n�r denna
;; fil anropas med exempelvis:
;; 
;; docbook2html -d fritis.dsl#html filnamn.xml
;;


;;
;; Vi formaterar HTML-koden med hj�lp av CSS. F�ljande definierar vilken
;; CSS-fil som skall anv�ndas. Default: fritis.css
;;
(define %html-header-tags% 
   '(("LINK" ("REL" "stylesheet")
      ("HREF" "./fritis.css") 
      ("TYPE" "text/css"))))



;;
;; Denn avg�r vad som skall utg�ra chunk-element.  Varje chunk hamnar p�
;; en egen html-sida. Detta �r lagon tycker jag. Vill du ha fler, mindre
;; HTML-sidor kan du l�gga sect, sect1 osv. till listan. 
;;
(define (chunk-element-list)
  (list (normalize "preface")
	(normalize "chapter")
	(normalize "appendix") 
	(normalize "article")
	(normalize "glossary")
	(normalize "bibliography")
	(normalize "index")
	(normalize "colophon")
	(normalize "setindex")
	(normalize "reference")
	(normalize "refentry")
	(normalize "part")
	(normalize "book") ;; just in case nothing else matches...
	(normalize "set")  ;; sets are definitely chunks...
	))


;;
;; Detta g�r att HTML-filnamnen skapas utifr�n det id som den aktuella
;; "chunken" har. Se d�rf�r till att ha id p� alla "chunk-element". Om
;; det inte finns ett id kommer namnet att automatgenereras. Detta �r
;; dumt eftersom detta namn �ndras. Externa l�nkar till sidan kommer
;; allts� v�ldigt l�tt att g� s�nder.
;;
(define %use-id-as-filename%
 #t)


;;
;; Den �ndelse som skall anv�ndas p� HTML-filerna.
;;
(define %html-ext%
  ".html")

</style-specification-body>
</style-specification>

<style-specification id="common" use="docbook">
<style-specification-body> 

;;
;; F�ljande deklarationer g�ller b�de html och print. 
;;

;;
;; Detta skall ge numrerade rader i ProgramListing, totalt otestat.
;;
(define %number-programlisting-lines%
  ;; Enumerate lines in a 'ProgramListing'?
  #t)

(define %linenumber-length%
  ;; Width of line numbers in enumerated environments
  ;; Line numbers will be padded to %linenumber-length% characters.
  0)


(define %linenumber-mod%
  ;; Controls line-number frequency in enumerated environments.
  ;; Every %linenumber-mod% line will be enumerated.
  1)


(define %linenumber-padchar%
  ;; Pad character in line numbers
  ;; Line numbers will be padded (on the left) with %linenumber-padchar%
  " ")





;;
;; Den svenska �vers�ttningen �r knasig. Denna �r s�kert �nnu knasigare, men jag gillar den b�ttre :)
;;
;;
(define (sv-xref-strings)
  (list (list (normalize "appendix")    (if %chapter-autolabel%
					    "appendix %n"
					    "appendix %t"))
	(list (normalize "article")     (string-append %gentext-sv-start-quote%
						       "%t"
						       %gentext-sv-end-quote%))
	(list (normalize "bibliography") "%t")
	(list (normalize "book")        "%t")
	(list (normalize "chapter")     (if %chapter-autolabel%
					    "kapitel %n"
					    "kapitel %t"))
	(list (normalize "equation")    "ekvation %n")
	(list (normalize "example")     "exempel %n")
	(list (normalize "figure")      "figur %n")
	(list (normalize "glossary")    "%t")
	(list (normalize "index")       "%t")
	(list (normalize "listitem")    "%n")
	(list (normalize "part")        "Del %n")
	(list (normalize "preface")     "%t")
	(list (normalize "procedure")   "Procedur %n, %t")
	(list (normalize "reference")   "Referens %n, %t")
	(list (normalize "section")     (if %section-autolabel%
					    "avsnitt %n"
					    "avsnittet %t "))
	(list (normalize "sect1")       (if %section-autolabel%
					    "avsnitt %n"
					    "avsnittet %t "))
	(list (normalize "sect2")       (if %section-autolabel%
					    "avsnitt %n"
					    "avsnittet %t "))
	(list (normalize "sect3")       (if %section-autolabel%
					    "avsnitt %n"
					    "avsnittet %t "))
	(list (normalize "sect4")       (if %section-autolabel%
					    "avsnitt %n"
					    "avsnittet %t "))
	(list (normalize "sect5")       (if %section-autolabel%
					    "avsnitt %n"
					    "avsnittet %t "))
	(list (normalize "simplesect")  (if %section-autolabel%
					    "avsnitt %n"
					    "avsnittet %t "))
	(list (normalize "sidebar")     "sidebar %t")
	(list (normalize "step")        "steg %n")
	(list (normalize "table")       "tabell %n")))

(define (gentext-sv-xref-strings gind)
  (let* ((giname (if (string? gind) gind (gi gind)))
	 (name   (normalize giname))
	 (xref   (assoc name (sv-xref-strings))))
    (if xref
	(car (cdr xref))
	(let* ((msg    (string-append "[xref till "
				      (if giname giname "element som
				      inte finns")
				      " stods ej]"))
	       (err    (node-list-error msg (current-node))))
	  msg))))

(define (sv-auto-xref-indirect-connector before) 
  ;; In English, the (cond) is unnecessary since the word is always the
  ;; same, but in other languages, that's not the case.  I've set this
  ;; one up with the (cond) so it stands as an example.
  (cond 
   ((equal? (gi before) (normalize "book"))
    (literal " i "))
   ((equal? (gi before) (normalize "chapter"))
    (literal " i "))
   ((equal? (gi before) (normalize "sect1"))
    (literal " i "))
   (else
    (literal " i "))))

</style-specification-body>
</style-specification>

<external-specification id="docbook" document="docbook.dsl">
</style-sheet>
