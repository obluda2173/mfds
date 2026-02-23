# MFDS Interactive Lecture Notes

[![Build and Deploy](https://github.com/obluda2173/mfds/actions/workflows/ExportPluto.yaml/badge.svg)](https://github.com/obluda2173/mfds/actions/workflows/ExportPluto.yaml)

**Interactive lecture notes for the Mathematical Foundations of Data Science (MFDS) program at the University of Vienna.**

🌐 **Live Website:** [obluda2173.github.io/mfds](https://obluda2173.github.io/mfds/)

---

## 📚 About

This repository contains interactive lecture notes built with [Pluto.jl](https://plutojl.org/), a reactive notebook environment for Julia. Students can:

- **Read** mathematical content with LaTeX rendering
- **Interact** with visualizations using sliders and controls
- **Experiment** with Julia code in real-time
- **Self-check** understanding with built-in exercises

Inspired by MIT's [Introduction to Computational Thinking](https://computationalthinking.mit.edu/) course.

---

## 📖 Available Lectures

### Analysis I
| Lecture | Topic | Link |
|:--------|:------|:-----|
| 1 | Newton's Method | [View](https://obluda2173.github.io/mfds/lectures/analysis/01_newton_method.html) |

*More lectures coming soon!*

---

## 🖥️ Running Locally

### Prerequisites
- [Julia](https://julialang.org/downloads/) (v1.10 or later)

### Setup
```julia
# Start Julia REPL, then:
using Pkg
Pkg.add("Pluto")

using Pluto
Pluto.run()
```

Then open any `.jl` file from this repository.

---

## 📁 Repository Structure

```
mfds/
├── index.jl                    # Homepage (course overview)
├── README.md                   # This file
│
├── lectures/
│   ├── analysis/               # Analysis I lectures
│   │   └── 01_newton_method.jl
│   ├── linear_algebra/         # Linear Algebra lectures
│   └── programming/            # Julia programming lectures
│
├── exercises/                  # Self-contained exercise notebooks
│
└── .github/
    └── workflows/
        └── ExportPluto.yaml    # Auto-deploys to GitHub Pages
```

---

## 🤝 Contributing

Contributions are welcome! To add a new lecture:

1. Create a new `.jl` Pluto notebook in the appropriate `lectures/` subfolder
2. Follow the existing lecture format (title, sections, exercises)
3. Update `index.jl` to link to the new lecture
4. Push to trigger automatic deployment

---

## 📜 License

This project is released into the public domain under [The Unlicense](https://unlicense.org/).

---

## 👤 Author

**Erik An**  
MFDS Bachelor Student, University of Vienna (2025-2028)

- GitHub: [@obluda2173](https://github.com/obluda2173)
