CC=pandoc
CFLAGS=--latex-engine=xelatex -T "Semantik von Programmiersprachen - Mitschrift" \
	      -V mainfont="Source Sans Pro" -V geometry="left=2cm,right=2cm,bottom=1.5cm" \
		  --smart -V lang="ngerman" -V monofont="Source Code Pro" -V sansfont="Source Sans Pro" \
		  --listings

all: mitschrift.pdf

mitschrift.pdf: *.md
	pandoc -o $@ $(CFLAGS) $<
