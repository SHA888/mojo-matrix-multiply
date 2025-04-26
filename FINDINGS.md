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

## 8. Modularizing Matrix Addition

- Refactored the element-wise matrix addition logic into a standalone function:

```python
def matrix_add(a: List[List[Int]], b: List[List[Int]]) -> List[List[Int]]:
    if not check_matrix_shape(a, b):
        print("Aborting matrix addition due to shape mismatch.")
        return List[List[Int]]()
    result = List[List[Int]]()
    for i in range(len(a)):
        row = List[Int]()
        for j in range(len(a[i])):
            row.append(a[i][j] + b[i][j])
        result.append(row)
    return result
```
- All addition operations in `main()` now use this function.
- Error handling is preserved: if the shapes don’t match, the function prints an error and returns an empty matrix.
- In `main()`, results are only printed if the returned matrix is non-empty.
- This step improves code clarity, reusability, and maintainability.

---

## 9. Modularizing Matrix Multiplication

- Refactored the matrix multiplication logic into a standalone function:

```python
def matrix_multiply(a: List[List[Int]], b: List[List[Int]]) -> List[List[Int]]:
    if len(a) == 0 or len(b) == 0:
        print("Error: One or both matrices are empty!")
        return List[List[Int]]()
    if len(a[0]) != len(b):
        print("Error: Number of columns of A does not match number of rows of B!")
        return List[List[Int]]()
    # Check all rows in a have same length
    for i in range(len(a)):
        if len(a[i]) != len(a[0]):
            print("Error: Matrix A has inconsistent row lengths!")
            return List[List[Int]]()
    # Check all rows in b have same length
    for i in range(len(b)):
        if len(b[i]) != len(b[0]):
            print("Error: Matrix B has inconsistent row lengths!")
            return List[List[Int]]()
    result = List[List[Int]]()
    for i in range(len(a)):
        row = List[Int]()
        for j in range(len(b[0])):
            s = 0
            for k in range(len(a[0])):
                s += a[i][k] * b[k][j]
            row.append(s)
        result.append(row)
    return result
```
- All multiplication operations in `main()` now use this function.
- Error handling is robust: empty matrices, dimension mismatches, and inconsistent row lengths are all checked and reported.
- Results are only printed if the returned matrix is non-empty.
- This step further improves code clarity, reusability, and maintainability.

---

_Last updated: 2025-04-26 22:30 (UTC+8)_
