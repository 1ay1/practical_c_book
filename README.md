# Practical C Programming: Idioms & Patterns They Don't Teach in Books

A comprehensive book covering real-world C programming patterns and idioms that are rarely taught in traditional textbooks. Written for intermediate to advanced C programmers who want to understand how professionals actually write C code (and why they do things that make beginners nervous).

## 📖 About This Book

Ever wondered how professional C programmers structure their code? This book bridges the gap between "I know C syntax" and "I can write production C code." It's packed with practical patterns used in SQLite, Redis, Linux kernel, Git, and other major C projects.

### What's Inside

- **Opaque Pointers** - Information hiding and API design
- **Function Pointers & Callbacks** - Polymorphism without OOP
- **Macro Magic** - The preprocessor's power (and dangers)
- **String Handling** - Safe operations and string builders
- **Error Handling** - Multiple strategies for robust code
- **Memory Management** - Pool allocators, arenas, and ownership
- **Struct Patterns & Data Structures** - Dynamic arrays, hash tables, trees, intrusive lists
- **Header Organization** - Avoiding circular dependencies
- **State Machines** - Turning spaghetti into structured code
- **Generic Programming** - Type-safe generics with macros
- **Testing & Debugging** - Practical techniques that work
- **Performance Optimization** - Cache-friendly code and profiling
- **Cross-Platform Code** - Writing portable C (Windows, Linux, macOS)
- **Advanced Patterns** - X-Macros, VTables, coroutines, and more

### What Makes This Different

- **60% Code Examples** - Not just theory—complete, working code (that actually compiles!)
- **Real-World Focus** - Patterns from actual production codebases (not toy examples)
- **Detailed Explanations** - Even complex concepts explained clearly (no hand-waving)
- **Conversational Tone** - Technical content without the academic stuffiness
- **No Beginner Hand-Holding** - Assumes you already know C basics (and have debugged at least one segfault)
- **Professional Depth** - Bibliography with 50+ references (for when you want to go deeper)

## 📥 Download the Book

### Latest Release

All formats are automatically built and released via GitHub Actions:

**[📦 Download from GitHub Releases](https://github.com/1ay1/practical_c_book/releases)**

Available formats:
- **PDF (Standard)** - `practical-c-book.pdf` - Optimized for screen reading and printing
- **PDF (Kindle)** - `practical-c-book-kindle.pdf` - Larger text, optimized for Kindle devices
- **Source Code** - `practical-c-book-source.tar.gz` - Full LaTeX source

### File Information

- **Format**: PDF
- **Size**: ~3-4 MB (varies by version)
- **Optimized for**: Kindle, tablets, desktop reading
- **Updates**: Automatically built on every release tag

## ⚠️ Important: This Is NOT a Beginner Book

**Before you download, read this:**

This book assumes you already know:
- What pointers are and how to use them
- How `malloc()` and `free()` work
- Basic data structures (arrays, structs, linked lists)
- How to compile C programs
- What a segmentation fault is

If you're still learning C basics, start with *The C Programming Language* by Kernighan & Ritchie first. Come back when you've written a few thousand lines of C, debugged at least one memory leak at 3 AM, and understand why `char *s = "hello"; s[0] = 'H';` is a bad idea.

## 🏗️ Building from Source

Want to compile the book yourself or make modifications?

### Prerequisites

- **LaTeX Distribution**:
  - macOS: MacTeX (`brew install --cask mactex`)
  - Linux: TeX Live (`sudo apt-get install texlive-full`)
  - Windows: MiKTeX or TeX Live

### Quick Build

```bash
# Clone the repository
git clone git@github.com:1ay1/practical_c_book.git
cd practical_c_book

# Build standard PDF
make

# Build Kindle-optimized PDF
make kindle

# Build both PDFs
make both

# Or use the build script
./build.sh
```

### Project Structure

```
c_custom_book/
├── main.tex                    # Main document with front/back matter
├── chapters/                   # 18 chapter files
│   ├── 01_opaque_pointers.tex
│   ├── 02_function_pointers.tex
│   ├── 03_macros.tex
│   ├── 04_strings.tex
│   ├── 05_error_handling.tex
│   ├── 06_memory_management.tex
│   ├── 07_structs.tex          # Includes data structures
│   ├── 08_headers.tex
│   ├── 09_preprocessor.tex
│   ├── 10_initialization.tex
│   ├── 11_state_machines.tex
│   ├── 12_generic_programming.tex
│   ├── 13_linked_structures.tex
│   ├── 14_testing.tex
│   ├── 15_build_patterns.tex
│   ├── 16_performance.tex
│   ├── 17_platform_specific.tex  # Windows/Linux/macOS
│   └── 18_advanced_patterns.tex
├── README.md                   # This file
├── Makefile                    # Build automation
└── build.sh                    # Build script
```

## 📚 What's Included

### Main Content

- **18 Core Chapters** covering essential C patterns
- **How to Use This Book** - 4 different reading strategies
- **Comprehensive Preface** - What to expect (with humor)
- **Detailed Conclusion** - Next steps and wisdom from the masters

### Reference Materials

- **Appendix A: Quick Reference** - Common idioms at a glance
- **Appendix B: Resources** - 50+ books, papers, and online references
- **Bibliography** - Foundational books, systems programming, algorithms
- **Glossary** - 60+ C terms defined
- **Errata** - How to report issues

### Front Matter

- Copyright page
- Dedication (to 3 AM debuggers everywhere)
- Acknowledgments (with gratitude and caffeine-fueled humor)
- About the Author
- Table of Contents (fully hyperlinked for easy navigation)

## 🎯 Who This Book Is For

**You'll love this book if:**
- You can write a linked list in C without Google
- You've debugged a use-after-free bug
- You want to understand professional C codebases
- You like reading code (seriously, 60% of this book is code)
- You're preparing for a job using C in production

**Skip this book if:**
- You're still learning what pointers do (we use them liberally)
- You think "undefined behavior" is a myth (it's very real and very angry)
- You prefer videos to reading dense technical content (this is old-school text)
- You want gentle, hand-holding explanations (we assume you're a grown-up programmer)

## 🐛 Found an Error?

Report issues at: https://github.com/1ay1/practical_c_book/issues

Include:
- Page number
- Section title
- Description of the issue
- Suggested correction (if you have one)

## 🤝 Contributing

Want to improve the book?

1. Fork the repository
2. Make your changes
3. Submit a pull request
4. Include clear commit messages

Contributions welcome:
- Corrections and clarifications
- Additional code examples
- Better explanations
- New patterns or sections

## 📜 License

This book is open source and available for educational use. See LICENSE file for details.

## 🙏 Acknowledgments

This book compiles patterns from:
- **SQLite** - Best-written C code in existence (fight me)
- **Redis** - Clean, readable systems programming
- **Linux Kernel** - Advanced patterns and practices (and occasional chaos)
- **Git** - Real-world C project structure
- **Dennis Ritchie & Brian Kernighan** - For creating C and K&R (the bible)
- **Stack Overflow** - For answering 47,000 segfault questions (and counting)
- **Coffee** - So. Much. Coffee. ☕
- **The community** - Every programmer who's shared their hard-won C knowledge

## 💬 Feedback

Questions? Suggestions? Found this helpful?

Open an issue or discussion on GitHub: https://github.com/1ay1/practical_c_book/issues

## 🎓 Learning Path

After this book, check out:
- **SQLite Source Code** - Study the masters
- **Linux Kernel** - Advanced systems programming
- **Redis Source** - Clean C architecture
- **APUE** (Advanced Programming in the UNIX Environment) - Systems programming bible

## ⭐ Star This Repository

If you found this book useful, give it a star on GitHub!

## 🤖 Automated Builds

This repository uses GitHub Actions to automatically build and release the book in multiple formats:
- Every push to `main` creates build artifacts
- Every tagged release (e.g., `v1.0`) creates a GitHub Release with all formats
- All builds include: Standard PDF, Kindle PDF, and source code archive

---

**Happy C Programming! May your pointers be valid, your memory be freed, and your buffers never overflow.**

```c
// See you on the other side
return 0;
```

---

*Last Updated: 2025 | Version 1.0*

*P.S. - If you find a bug, that's a "feature" until proven otherwise. Then it's a bug. Please report it.* 🐛