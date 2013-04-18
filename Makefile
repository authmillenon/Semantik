CC=pandoc
CFLAGS=--latex-engine=xelatex -T "Semantik von Programmiersprachen - Mitschrift" \
	      -V mainfont="Source Sans Pro" -V geometry="left=2cm,right=2cm,bottom=1.5cm" \
		  --smart -V lang="ngerman" -V monofont="Source Code Pro" -V sansfont="Source Sans Pro" \
		  -V fontsize="12pt" -N --listings --standalone

all: mitschrift.pdf

mitschrift.pdf: *.md
	pandoc -o $@ $(CFLAGS) $+

html: mitschrift.html

mitschrift.html: *.md
	pandoc -o $@ -t html5 -c style.css $(CFLAGS) $+
