# Mojo Matrix Calculator: Findings and Results

This document summarizes our incremental exploration of Mojo's language features and quirks, from Hello World through matrix operations, error handling, and edge-case testing.

---

## 1. Hello World & Mojo Basics
- Mojo syntax is similar to Python, but **requires explicit type annotations** for function arguments.
- Printing and basic variable assignment work as expected.

## 2. Mojo Lists vs. Python Lists
- Mojo does **not** support Python-style list literals for indexing or iteration.
- Use `List` from `collections` for arrays and matrices.
- `List` must be explicitly parameterized (e.g., `List[Int]`, `List[List[Int]]`).
- You cannot create an empty `List()` without specifying its type: use `List[Int]()` or `List[List[Int]]()`.

## 3. Matrix Addition & Multiplication
- Implemented element-wise addition and matrix multiplication for 2x2 matrices.
- Encapsulated matrix printing in a `print_matrix` function for code reuse.
- All functions require explicit type annotations (e.g., `m: List[List[Int]], name: String`).

## 4. Error Handling & Type Enforcement
- Added shape checks for matrix addition and multiplication:
  - Addition only allowed if matrices have the same shape (same number of rows and columns).
  - Multiplication only allowed if the number of columns in `a` matches the number of rows in `b`.
- Mojo does **not** support Python f-strings; use comma-separated print arguments instead.
- Error messages are printed and operations are aborted if checks fail.

## 5. Edge Case Testing
### a. Empty Matrices
- Creating empty matrices requires `a = List[List[Int]]()`, `b = List[List[Int]]()`.
- Shape check passes for two empty matrices (may not be mathematically correct, but matches code logic).

### b. Non-Square Matrices
- Addition fails if shapes don't match (e.g., 2x3 vs 3x2).
- Multiplication works if the number of columns in `a` matches the number of rows in `b` (e.g., 2x3 * 3x2 produces a 2x2 result).
- If row lengths are inconsistent, addition fails with a clear error message.

### c. Shape Mismatch
- If a row in one matrix is longer than the corresponding row in the other, addition fails with an error.
- Multiplication may still produce a result if the dimensions for multiplication are valid, but this can be a source of subtle bugs.

---

## 6. Key Mojo Quirks and Gotchas
- **Type annotations are mandatory** for most function arguments.
- **No f-strings**: Use comma-separated arguments in `print`.
- **Explicit List types**: Always specify the type when creating empty lists.
- **No exceptions**: Use manual error checks and print statements for error handling.

---

## 7. Next Steps
- Modularize matrix operations into functions.
- Add more robust shape checking for multiplication.
- Explore user input and interactive features.
- Continue bug-hunting and documenting Mojo's behavior with more complex cases.

---

_Last updated: 2025-04-26 22:11 (UTC+8)_
