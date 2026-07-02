# ocaml-red-black-tree-set
OCaml/Dune implementation of a red-black tree set with insertion, membership checks, OUnit tests, and runtime performance validation.

# OCaml Red-Black Tree Set

This project implements a set data structure in OCaml using a red-black tree.

The set supports checking whether it is empty, inserting values, checking membership, and building red-black tree nodes for testing. The project also includes unit tests and a performance validation report analyzing insertion runtime.

## Features

- Implements a reusable set module in OCaml
- Uses a red-black tree structure
- Supports insertion while maintaining tree balance
- Supports membership checks
- Includes an interface file with documentation
- Includes OUnit tests for empty sets, membership, insertion, and balancing cases
- Includes a performance validation report comparing runtime against `n log n`

## Tech Stack

- OCaml
- Dune
- OUnit2
- Unix timing functions

## Project Structure

```text
ocaml-red-black-tree-set/
├── README.md
├── .gitignore
├── .ocamlformat
├── A6.opam
├── dune-project
├── bin/
│   ├── dune
│   └── main.ml
├── lib/
│   ├── dune
│   ├── sets.ml
│   └── sets.mli
├── test/
│   ├── dune
│   └── test_A6.ml
├── docs/
│   └── A6 Report.pdf
└── gitlog.txt
```

## How to Run

Make sure you have OCaml and Dune installed.

First, build the project:

```bash
dune build
```

To run the performance timing program:

```bash
dune exec bin/main.exe
```

The program prints timing data in CSV format:

```text
n,nlogn,Time
```

Each row shows:

- `n`: number of inserted elements
- `nlogn`: calculated `n log n` value
- `Time`: measured insertion runtime

## How to Run Tests

To run the test suite:

```bash
dune runtest
```

The tests cover:

- checking whether a set is empty
- checking membership in a set
- inserting into an empty set
- inserting duplicate values
- red-black tree balancing cases

## Implementation Notes

The main set implementation is in:

```text
lib/sets.ml
```

The module defines a red-black tree with two colors:

```ocaml
Red | Black
```

An empty set is represented by `Leaf`, and non-empty sets are represented by nodes containing:

```ocaml
color * value * left subtree * right subtree
```

Insertion preserves the binary search tree property and uses a balancing function to maintain red-black tree invariants.

## Performance Report

The included report analyzes the relationship between input size and runtime. It compares measured insertion time against `n log n` and uses linear regression to validate the expected time complexity.

The report is located at:

```text
docs/A6 Report.pdf
```
Refer to Performance Report.pdf for performance validation.
