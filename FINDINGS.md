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

## 10. Modularizing Shape Checking

- Extracted shape-checking logic into two dedicated functions:

```python
def check_matrix_shape_equal(a: List[List[Int]], b: List[List[Int]]) -> Bool:
    if len(a) != len(b):
        print("Error: Matrices have different number of rows!")
        return False
    for i in range(len(a)):
        if len(a[i]) != len(b[i]):
            print("Error: Row", i, "has different lengths in the two matrices!")
            return False
    return True

def check_matrix_shape_multiplicable(a: List[List[Int]], b: List[List[Int]]) -> Bool:
    if len(a) == 0 or len(b) == 0:
        print("Error: One or both matrices are empty!")
        return False
    # Check all rows in a have same length
    for i in range(len(a)):
        if len(a[i]) != len(a[0]):
            print("Error: Matrix A has inconsistent row lengths!")
            return False
    # Check all rows in b have same length
    for i in range(len(b)):
        if len(b[i]) != len(b[0]):
            print("Error: Matrix B has inconsistent row lengths!")
            return False
    if len(a[0]) != len(b):
        print("Error: Number of columns of A does not match number of rows of B!")
        return False
    return True
```
- `matrix_add` and `matrix_multiply` now use these helpers for shape validation.
- This reduces code duplication, improves maintainability, and makes it easier to extend shape checks for new operations.
- All error messages and behaviors are preserved and centralized.

---

## 11. Edge Case and Stress Testing

- Added a comprehensive set of new tests in `main()` to cover:
  - **1x1 matrices (scalar):** Confirmed that addition and multiplication work for single-element matrices.
  - **1xN and Nx1 matrices (row/column vectors):** Matrix multiplication produces correct results for row/column vectors.
  - **Matrices with zeros and negatives:** Both operations handle zero and negative values as expected.
  - **Large matrices (3x3):** Addition and multiplication work for larger matrices, and results are correct.
  - **Inconsistent row matrices:** Both addition and multiplication correctly detect and abort on matrices with inconsistent row lengths, with clear error messages.
- All previous tests (empty, non-square, shape mismatch, 2x2) continue to pass and/or trigger appropriate errors.
- **Findings:**
  - Mojo's strict type and shape checking, together with modularized validation, reliably prevents invalid operations.
  - The calculator now robustly handles a wide variety of edge cases.
  - Error messages are clear and centralized.

**Sample Output:**
```
Test 5: 1x1 matrices (scalar)
Matrix A:
42 
Matrix B:
-7 
Result (A+B):
35 
Result (A*B):
-294 

Test 6: 1xN and Nx1 matrices (row/column vectors)
Matrix A:
1 2 3 
Matrix B:
4 
5 
6 
Result (A*B):
32 

Test 7: Matrices with zeros and negatives
Matrix A:
0 -1 
-2 0 
Matrix B:
-3 0 
0 4 
Result (A+B):
-3 -1 
-2 4 
Result (A*B):
0 -4 
6 0 
```

---

## 12. Interactive User Input for Matrices

- Added interactive mode to the matrix calculator:
  - On startup, user is prompted: `Do you want to enter matrices interactively? (y/n):`
  - If `y`, user selects operation (addition or multiplication), then enters two matrices by specifying dimensions and entering each row as space-separated integers.
  - Input is validated for correct shape and integer entries; errors are reported and the operation is aborted if invalid.
  - Results are printed for valid operations, using the same display as automated tests.
- If user enters `n`, all previous automated tests are run as before.
- **Mojo quirks:**
  - Input parsing requires explicit conversion (`int(input())`), and all error handling is manual (no exceptions).
  - Input and print statements use comma-separated arguments (no f-strings).
- This feature demonstrates Mojo's input handling and makes the calculator practical for user-driven scenarios.

---

## 13. Matrix Transpose Operation

- Implemented `matrix_transpose(a: List[List[Int]]) -> List[List[Int]]` to return the transpose of a matrix.
- Handles empty and inconsistent matrices with clear error messages.
- Added automated tests for:
  - Square matrices
  - Non-square matrices
  - Row and column vectors
  - Empty matrices
  - Inconsistent matrices
- **Limitation:**
  - Mojo currently does **not** support interactive user input (`input()`, `int()`) or exception handling. All interactive features have been removed/commented out.
  - Only automated tests are supported at this time.
- **Sample Output:**
```
Test 10: Transpose square matrix
Matrix A:
1 2 
3 4 
Result (A^T):
1 3 
2 4 

Test 11: Transpose non-square matrix
Matrix A:
1 2 3 
4 5 6 
Result (A^T):
1 4 
2 5 
3 6 
```

---

_Last updated: 2025-04-27 03:27 (UTC+8)_
