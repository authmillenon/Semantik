CC=pandoc
CFLAGS=--latex-engine=xelatex -V mainfont="Source Sans Pro" \
	      -V geometry="left=2cm,right=2cm,bottom=1.5cm" \
		  -V lang="ngerman" -V monofont="Source Code Pro" -V sansfont="Source Sans Pro" \
		  --standalone
FILENAME=ue02

all: $(FILENAME).pdf

%.pdf: %.md
	$(CC) -o $@ $(CFLAGS) $<
