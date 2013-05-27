CC=pandoc
CFLAGS=--latex-engine=xelatex -V mainfont="Source Sans Pro" \
	      -V geometry="left=2cm,right=2cm,bottom=2cm" \
		  -V lang="ngerman" -V monofont="Source Code Pro" -V sansfont="Source Sans Pro" \
		  -V fontsize="12pt" --standalone
FILENAME=ue06

all: $(FILENAME).pdf

%.pdf: %.md
	$(CC) -o $@ $(CFLAGS) $<
