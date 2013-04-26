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
	# cd en && pdf2ps $(BOOK_FILE_NAME).pdf - | psbook | psnup -s1 -2x1 | ps2pdf - $(BOOK_FILE_NAME)_booklet.pdf
	cd en && pdfbook --short-edge $(BOOK_FILE_NAME).pdf 
	# cd en && pdf2ps $(BOOK_FILE_NAME).pdf - | psbook | psnup -s1 -2 | ps2pdf - $(BOOK_FILE_NAME)_booklet.pdf

en/redis.epub: en/title.png en/title.txt en/redis.md
	$(EPUB_BUILDER) $(EPUB_BUILDER_FLAGS) $^ -o $@

en/redis.mobi: en/redis.epub
	$(MOBI_BUILDER) $^

clean:
	rm -f */$(BOOK_FILE_NAME).pdf
	rm -f */$(BOOK_FILE_NAME).epub
	rm -f */$(BOOK_FILE_NAME).mobi
