SOURCE_FILE_NAME = chrisandemmy.md
BOOK_FILE_NAME = chrisandemmy

PDF_BUILDER = pandoc
PDF_BUILDER_FLAGS = \
	--latex-engine xelatex \
	--template ../common/pdf-template.tex \
	--listings

EPUB_BUILDER = pandoc
EPUB_BUILDER_FLAGS = \
	--epub-cover-image

MOBI_BUILDER = kindlegen

title:
	rp5 run common/title.rb

pdf:
	cd en && $(PDF_BUILDER) $(PDF_BUILDER_FLAGS) $(SOURCE_FILE_NAME) -o $(BOOK_FILE_NAME).pdf

nup:
	cd en && pdfnup --frame false  --nup 2x1 $(BOOK_FILE_NAME).pdf

booklet:
	# attempts and failures:
	# cd en && pdf2ps $(BOOK_FILE_NAME).pdf - | psbook | psnup -s1 -2x1 | ps2pdf - $(BOOK_FILE_NAME)_booklet.pdf
	# cd en && pdfbook --short-edge --signature '2' $(BOOK_FILE_NAME).pdf 
	# cd en && pdfbook --short-edge --signature '2' $(BOOK_FILE_NAME).pdf 
	# cd en && pdf2ps $(BOOK_FILE_NAME).pdf - | psbook -s8 | psnup -2 -PA5 | ps2pdf - $(BOOK_FILE_NAME)_booklet.pdf
	#
	# This one appears to work:
	# post processing needs: if printing on both sides, rotate every odd page of booklet output
	# from: http://catdevblog.nickbair.net/2010/06/08/printing-in-booklet-format-from-the-linux-command-line/
	cd en && pdf2ps $(BOOK_FILE_NAME).pdf - |  psbook | psnup -2 -W5.5in -H8.5in | ps2pdf - $(BOOK_FILE_NAME)-booklet.pdf

en/redis.epub: en/title.png en/title.txt en/redis.md
	$(EPUB_BUILDER) $(EPUB_BUILDER_FLAGS) $^ -o $@

en/redis.mobi: en/redis.epub
	$(MOBI_BUILDER) $^

clean:
	rm -f */$(BOOK_FILE_NAME).pdf
	rm -f */$(BOOK_FILE_NAME).epub
	rm -f */$(BOOK_FILE_NAME).mobi
