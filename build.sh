#!/bin/bash
# Build script for Practical C Programming Book
# Usage: ./build.sh [quick|full|clean|view]

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
MAIN_FILE="main.tex"
OUTPUT_FILE="main.pdf"

# Print colored message
print_status() {
    echo -e "${BLUE}[BUILD]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

# Check if LaTeX is installed
check_latex() {
    if ! command -v pdflatex &> /dev/null; then
        print_error "pdflatex not found!"
        echo ""
        echo "Install LaTeX:"
        echo "  macOS:   brew install --cask mactex"
        echo "  Linux:   sudo apt-get install texlive-full"
        echo "  Windows: Download MiKTeX from miktex.org"
        exit 1
    fi
}

# Standard build (2 passes)
build_standard() {
    print_status "Building PDF (standard - 2 passes)..."

    print_status "Pass 1/2..."
    pdflatex -interaction=nonstopmode -halt-on-error "$MAIN_FILE" > /dev/null 2>&1 || {
        print_error "Compilation failed! Check main.log for details"
        tail -n 20 main.log
        exit 1
    }

    print_status "Pass 2/2 (generating TOC)..."
    pdflatex -interaction=nonstopmode -halt-on-error "$MAIN_FILE" > /dev/null 2>&1 || {
        print_error "Second pass failed!"
        exit 1
    }

    print_success "Build complete! Output: $OUTPUT_FILE"
}

# Quick build (1 pass)
build_quick() {
    print_status "Building PDF (quick - single pass)..."

    pdflatex -interaction=nonstopmode -halt-on-error "$MAIN_FILE" > /dev/null 2>&1 || {
        print_error "Compilation failed! Check main.log for details"
        tail -n 20 main.log
        exit 1
    }

    print_success "Quick build complete! Output: $OUTPUT_FILE"
    print_warning "Note: TOC may be incomplete. Run standard build for full TOC."
}

# Full build (3 passes)
build_full() {
    print_status "Building PDF (full - 3 passes)..."

    for i in 1 2 3; do
        print_status "Pass $i/3..."
        pdflatex -interaction=nonstopmode -halt-on-error "$MAIN_FILE" > /dev/null 2>&1 || {
            print_error "Pass $i failed!"
            exit 1
        }
    done

    print_success "Full build complete! All references resolved."
}

# Clean auxiliary files
clean() {
    print_status "Cleaning auxiliary files..."

    rm -f *.aux *.log *.toc *.out *.lot *.lof *.idx *.ilg *.ind *.bbl *.blg
    rm -f chapters/*.aux

    print_success "Cleaned auxiliary files"
}

# Clean everything including PDF
clean_all() {
    clean
    print_status "Removing PDF output..."
    rm -f "$OUTPUT_FILE"
    print_success "All files cleaned"
}

# View PDF
view_pdf() {
    if [ ! -f "$OUTPUT_FILE" ]; then
        print_warning "PDF not found. Building first..."
        build_standard
    fi

    print_status "Opening PDF..."

    case "$(uname)" in
        Darwin*)
            open "$OUTPUT_FILE"
            ;;
        Linux*)
            if command -v xdg-open &> /dev/null; then
                xdg-open "$OUTPUT_FILE"
            elif command -v evince &> /dev/null; then
                evince "$OUTPUT_FILE" &
            elif command -v okular &> /dev/null; then
                okular "$OUTPUT_FILE" &
            else
                print_error "No PDF viewer found"
                exit 1
            fi
            ;;
        *)
            print_warning "Unknown OS. Please open $OUTPUT_FILE manually"
            ;;
    esac

    print_success "PDF opened in viewer"
}

# Show help
show_help() {
    cat << EOF
Practical C Programming Book - Build Script

Usage: $0 [command]

Commands:
    (none)      Standard build (2 passes for TOC)
    quick       Quick single-pass build
    full        Full 3-pass build (all references)
    clean       Remove auxiliary files
    cleanall    Remove all generated files including PDF
    view        Build (if needed) and open PDF viewer
    check       Check LaTeX installation
    help        Show this help message

Examples:
    $0              # Standard build
    $0 quick        # Fast build
    $0 view         # Build and view
    $0 clean quick  # Clean and quick rebuild

EOF
}

# Check installation
check_installation() {
    print_status "Checking LaTeX installation..."

    echo ""
    echo "Checking commands:"

    if command -v pdflatex &> /dev/null; then
        echo -e "  ${GREEN}✓${NC} pdflatex found"
        pdflatex --version | head -n 1
    else
        echo -e "  ${RED}✗${NC} pdflatex not found"
    fi

    if command -v latex &> /dev/null; then
        echo -e "  ${GREEN}✓${NC} latex found"
    else
        echo -e "  ${RED}✗${NC} latex not found"
    fi

    echo ""
    echo "Checking required packages:"

    packages=("geometry" "listings" "tcolorbox" "xcolor" "hyperref" "fancyhdr" "titlesec")

    for pkg in "${packages[@]}"; do
        if kpsewhich ${pkg}.sty &> /dev/null; then
            echo -e "  ${GREEN}✓${NC} $pkg"
        else
            echo -e "  ${RED}✗${NC} $pkg (missing)"
        fi
    done

    echo ""
    print_success "Installation check complete"
}

# Main script
main() {
    check_latex

    case "${1:-standard}" in
        quick)
            build_quick
            ;;
        full)
            build_full
            ;;
        clean)
            clean
            ;;
        cleanall)
            clean_all
            ;;
        view)
            view_pdf
            ;;
        check)
            check_installation
            ;;
        help|-h|--help)
            show_help
            ;;
        standard|"")
            build_standard
            ;;
        *)
            print_error "Unknown command: $1"
            echo ""
            show_help
            exit 1
            ;;
    esac
}

# Run main with all arguments
main "$@"
