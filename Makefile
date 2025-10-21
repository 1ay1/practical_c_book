# Makefile for Practical C Programming Book

# Main document
MAIN = main
OUTPUT = $(MAIN).pdf

# Kindle-optimized document
KINDLE_MAIN = main_kindle
KINDLE_OUTPUT = $(KINDLE_MAIN).pdf

# LaTeX compiler
LATEX = pdflatex
LATEX_FLAGS = -interaction=nonstopmode -halt-on-error

# Directories
CHAPTERS_DIR = chapters
BUILD_DIR = build

# Chapter files
CHAPTERS = $(wildcard $(CHAPTERS_DIR)/*.tex)

# Phony targets
.PHONY: all clean cleanall view help kindle kindle-view

# Default target
all: $(OUTPUT)

# Build both versions
both: $(OUTPUT) $(KINDLE_OUTPUT)

# Build the PDF
$(OUTPUT): $(MAIN).tex $(CHAPTERS)
	@echo "Building PDF (first pass)..."
	$(LATEX) $(LATEX_FLAGS) $(MAIN).tex
	@echo "Building PDF (second pass for TOC)..."
	$(LATEX) $(LATEX_FLAGS) $(MAIN).tex
	@echo "Build complete! Output: $(OUTPUT)"

# Quick build (single pass)
quick: $(MAIN).tex $(CHAPTERS)
	@echo "Quick build (single pass)..."
	$(LATEX) $(LATEX_FLAGS) $(MAIN).tex

# Full build with all passes for references
full: $(MAIN).tex $(CHAPTERS)
	@echo "Full build with all references..."
	$(LATEX) $(LATEX_FLAGS) $(MAIN).tex
	$(LATEX) $(LATEX_FLAGS) $(MAIN).tex
	$(LATEX) $(LATEX_FLAGS) $(MAIN).tex
	@echo "Full build complete!"

# Build Kindle-optimized PDF
$(KINDLE_OUTPUT): $(KINDLE_MAIN).tex $(CHAPTERS)
	@echo "Building Kindle-optimized PDF (first pass)..."
	$(LATEX) $(LATEX_FLAGS) $(KINDLE_MAIN).tex
	@echo "Building Kindle-optimized PDF (second pass for TOC)..."
	$(LATEX) $(LATEX_FLAGS) $(KINDLE_MAIN).tex
	@echo "Kindle build complete! Output: $(KINDLE_OUTPUT)"

# Kindle build targets
kindle: $(KINDLE_OUTPUT)

kindle-quick: $(KINDLE_MAIN).tex $(CHAPTERS)
	@echo "Quick Kindle build (single pass)..."
	$(LATEX) $(LATEX_FLAGS) $(KINDLE_MAIN).tex

kindle-full: $(KINDLE_MAIN).tex $(CHAPTERS)
	@echo "Full Kindle build with all references..."
	$(LATEX) $(LATEX_FLAGS) $(KINDLE_MAIN).tex
	$(LATEX) $(LATEX_FLAGS) $(KINDLE_MAIN).tex
	$(LATEX) $(LATEX_FLAGS) $(KINDLE_MAIN).tex
	@echo "Full Kindle build complete!"

# Open PDF viewer (macOS)
view: $(OUTPUT)
	@if [ "$(shell uname)" = "Darwin" ]; then \
		open $(OUTPUT); \
	elif [ "$(shell uname)" = "Linux" ]; then \
		xdg-open $(OUTPUT) 2>/dev/null || evince $(OUTPUT) 2>/dev/null || okular $(OUTPUT); \
	else \
		echo "Please open $(OUTPUT) manually"; \
	fi

# Open Kindle PDF viewer
kindle-view: $(KINDLE_OUTPUT)
	@if [ "$(shell uname)" = "Darwin" ]; then \
		open $(KINDLE_OUTPUT); \
	elif [ "$(shell uname)" = "Linux" ]; then \
		xdg-open $(KINDLE_OUTPUT) 2>/dev/null || evince $(KINDLE_OUTPUT) 2>/dev/null || okular $(KINDLE_OUTPUT); \
	else \
		echo "Please open $(KINDLE_OUTPUT) manually"; \
	fi

# Clean auxiliary files
clean:
	@echo "Cleaning auxiliary files..."
	rm -f $(MAIN).aux $(MAIN).log $(MAIN).toc $(MAIN).out
	rm -f $(MAIN).lot $(MAIN).lof $(MAIN).idx $(MAIN).ilg
	rm -f $(MAIN).ind $(MAIN).bbl $(MAIN).blg
	rm -f $(MAIN).synctex.gz $(MAIN).synctex\(busy\)
	rm -f $(KINDLE_MAIN).aux $(KINDLE_MAIN).log $(KINDLE_MAIN).toc $(KINDLE_MAIN).out
	rm -f $(KINDLE_MAIN).lot $(KINDLE_MAIN).lof $(KINDLE_MAIN).idx $(KINDLE_MAIN).ilg
	rm -f $(KINDLE_MAIN).ind $(KINDLE_MAIN).bbl $(KINDLE_MAIN).blg
	rm -f $(KINDLE_MAIN).synctex.gz $(KINDLE_MAIN).synctex\(busy\)
	rm -f $(CHAPTERS_DIR)/*.aux
	@echo "Clean complete!"

# Clean everything including PDF
cleanall: clean
	@echo "Removing PDF output..."
	rm -f $(OUTPUT) $(KINDLE_OUTPUT)
	@echo "Removing latexmk files..."
	rm -f $(MAIN).fdb_latexmk $(MAIN).fls
	rm -f $(KINDLE_MAIN).fdb_latexmk $(KINDLE_MAIN).fls
	@echo "Removing conversion files..."
	rm -f $(MAIN).epub $(MAIN).mobi $(MAIN)_compressed.pdf
	rm -f $(KINDLE_MAIN).epub $(KINDLE_MAIN).mobi $(KINDLE_MAIN)_compressed.pdf
	@echo "All files cleaned!"

# Install required LaTeX packages (requires tlmgr)
install-deps:
	@echo "Installing required LaTeX packages..."
	tlmgr install geometry
	tlmgr install listings
	tlmgr install tcolorbox
	tlmgr install xcolor
	tlmgr install hyperref
	tlmgr install fancyhdr
	tlmgr install titlesec
	tlmgr install enumitem
	tlmgr install amssymb
	tlmgr install microtype
	@echo "Dependencies installed!"

# Check if LaTeX is installed
check:
	@echo "Checking LaTeX installation..."
	@which pdflatex > /dev/null && echo "✓ pdflatex found" || echo "✗ pdflatex not found"
	@which latex > /dev/null && echo "✓ latex found" || echo "✗ latex not found"
	@echo "\nChecking required packages..."
	@kpsewhich geometry.sty > /dev/null && echo "✓ geometry" || echo "✗ geometry (missing)"
	@kpsewhich listings.sty > /dev/null && echo "✓ listings" || echo "✗ listings (missing)"
	@kpsewhich tcolorbox.sty > /dev/null && echo "✓ tcolorbox" || echo "✗ tcolorbox (missing)"
	@kpsewhich xcolor.sty > /dev/null && echo "✓ xcolor" || echo "✗ xcolor (missing)"
	@kpsewhich hyperref.sty > /dev/null && echo "✓ hyperref" || echo "✗ hyperref (missing)"

# Convert to other formats (requires calibre)
epub: $(OUTPUT)
	@echo "Converting to EPUB..."
	ebook-convert $(OUTPUT) $(MAIN).epub
	@echo "EPUB created: $(MAIN).epub"

mobi: epub
	@echo "Converting to MOBI (Kindle)..."
	ebook-convert $(MAIN).epub $(MAIN).mobi
	@echo "MOBI created: $(MAIN).mobi"

# Compress PDF
compress: $(OUTPUT)
	@echo "Compressing PDF..."
	gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook \
	   -dNOPAUSE -dQUIET -dBATCH -sOutputFile=$(MAIN)_compressed.pdf $(OUTPUT)
	@echo "Compressed PDF created: $(MAIN)_compressed.pdf"

# Word count (approximate)
wordcount:
	@echo "Counting words in chapters..."
	@for file in $(CHAPTERS); do \
		echo "$$file:"; \
		texcount -1 -sum $$file 2>/dev/null || echo "  (texcount not available)"; \
	done
	@echo "\nTotal:"
	@texcount -1 -sum -merge $(CHAPTERS) 2>/dev/null || echo "Install texcount for word counting"

# Help target
help:
	@echo "Practical C Programming Book - Makefile Help"
	@echo ""
	@echo "Available targets:"
	@echo "  make             - Build the standard PDF (default)"
	@echo "  make quick       - Quick single-pass build"
	@echo "  make full        - Full build with all reference passes"
	@echo "  make view        - Build and open PDF viewer"
	@echo ""
	@echo "Kindle-optimized targets:"
	@echo "  make kindle      - Build Kindle-optimized PDF (larger text)"
	@echo "  make kindle-quick- Quick Kindle build (single pass)"
	@echo "  make kindle-full - Full Kindle build with all passes"
	@echo "  make kindle-view - Build and open Kindle PDF"
	@echo "  make both        - Build both standard and Kindle versions"
	@echo ""
	@echo "Other targets:"
	@echo "  make clean       - Remove auxiliary files"
	@echo "  make cleanall    - Remove all generated files including PDFs"
	@echo "  make check       - Check LaTeX installation and packages"
	@echo "  make epub        - Convert PDF to EPUB format"
	@echo "  make mobi        - Convert to MOBI format (Kindle)"
	@echo "  make compress    - Create compressed version of PDF"
	@echo "  make wordcount   - Count words in chapters"
	@echo "  make help        - Show this help message"
	@echo ""
	@echo "Examples:"
	@echo "  make              # Build the standard book"
	@echo "  make kindle       # Build Kindle-optimized version"
	@echo "  make both         # Build both versions"
	@echo "  make clean kindle # Clean and rebuild Kindle version"
	@echo "  make kindle-view  # Build and open Kindle PDF"
	@echo ""
