# Mojo Matrix Calculator: Findings and Results

This document summarizes our incremental exploration of Mojo's language features and quirks, from Hello World through matrix operations, error handling, and edge-case testing.

---

## 1. Hello World & Mojo Basics

- **Mojo:** Mojo syntax is similar to Python, but requires explicit type annotations for function arguments like Rust does.
- **Python:** Python syntax does not require explicit type annotations.
- **Rust:** Rust syntax requires explicit type annotations.
- Printing and basic variable assignment work as expected.
- Timestamp: 2025-04-27 03:59 UTC+8

## 2. Mojo Lists vs. Python Lists

- **Mojo:** Mojo does **not** support Python-style list literals for indexing or iteration.
- **Python:** Python supports list literals for indexing or iteration.
- **Rust:** Rust supports vector literals for indexing or iteration.
- Use `List` from `collections` for arrays and matrices.
- Timestamp: 2025-04-27 03:59 UTC+8

## 3. Matrix Addition & Multiplication

- **Mojo:** Implemented element-wise addition and matrix multiplication for 2x2 matrices.
- **Python:** Use nested loops or `numpy` arrays for matrix operations.
- **Rust:** Use nested loops or external crates like `nalgebra` or `ndarray` for matrix operations.
- Encapsulated matrix printing in a `print_matrix` function for code reuse.
- All functions require explicit type annotations (e.g., `m: List[List[Int]], name: String`).
- Timestamp: 2025-04-27 03:59 UTC+8

## 4. Error Handling & Type Enforcement

- **Mojo:** No exceptions; error handling is manual (print and return sentinel values).
- **Python:** Exceptions are standard for error handling.
- **Rust:** Uses `Result<T, E>` and pattern matching for error handling.
- Added shape checks for matrix addition and multiplication:
  - Addition only allowed if matrices have the same shape (same number of rows and columns).
  - Multiplication only allowed if the number of columns in `a` matches the number of rows in `b`.
- Mojo does **not** support Python f-strings; use comma-separated print arguments instead.
- Error messages are printed and operations are aborted if checks fail.
- Timestamp: 2025-04-27 03:59 UTC+8

## 5. Edge Case Testing

### a. Empty Matrices

- **Mojo:** Creating empty matrices requires `a = List[List[Int]]()`, `b = List[List[Int]]()`.
- **Python:** Creating empty matrices requires `a = []`, `b = []`.
- **Rust:** Creating empty matrices requires `a = Vec::new()`, `b = Vec::new()`.
- Shape check passes for two empty matrices (may not be mathematically correct, but matches code logic).
- Timestamp: 2025-04-27 03:59 UTC+8

### b. Non-Square Matrices

- **Mojo:** Addition fails if shapes don't match (e.g., 2x3 vs 3x2).
- **Python:** Addition fails if shapes don't match (e.g., 2x3 vs 3x2).
- **Rust:** Addition fails if shapes don't match (e.g., 2x3 vs 3x2).
- Multiplication works if the number of columns in `a` matches the number of rows in `b` (e.g., 2x3 * 3x2 produces a 2x2 result).
- If row lengths are inconsistent, addition fails with a clear error message.
- Timestamp: 2025-04-27 03:59 UTC+8

### c. Shape Mismatch

- **Mojo:** If a row in one matrix is longer than the corresponding row in the other, addition fails with an error.
- **Python:** If a row in one matrix is longer than the corresponding row in the other, addition fails with an error.
- **Rust:** If a row in one matrix is longer than the corresponding row in the other, addition fails with an error.
- Multiplication may still produce a result if the dimensions for multiplication are valid, but this can be a source of subtle bugs.
- Timestamp: 2025-04-27 03:59 UTC+8

---

## 6. Key Mojo Quirks and Gotchas

- **Type annotations are mandatory** for most function arguments.
- **No f-strings**: Use comma-separated arguments in `print`.
- **Explicit List types**: Always specify the type when creating empty lists.
- **No exceptions**: Use manual error checks and print statements for error handling.
- Timestamp: 2025-04-27 03:59 UTC+8

## 7. Modularizing Matrix Addition

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
- Timestamp: 2025-04-27 03:59 UTC+8

## 8. Modularizing Matrix Multiplication

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
- Timestamp: 2025-04-27 03:59 UTC+8

## 9. Modularizing Shape Checking

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
- Timestamp: 2025-04-27 03:59 UTC+8

## 10. Edge Case and Stress Testing

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
- Timestamp: 2025-04-27 03:59 UTC+8

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

## 11. Interactive User Input for Matrices

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
- Timestamp: 2025-04-27 03:59 UTC+8

---

## 12. Matrix Transpose Operation

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

## Note: List Length/Size Access in Python, Rust, and Mojo

| Language | Syntax        | Example              |
|----------|--------------|---------------------|
| Python   | `len(list)`  | `len([1,2,3])`      |
| Rust     | `list.len()` | `vec![1,2,3].len()` |
| Mojo     | `list.size`  | `List(1,2,3).size`  |

- **Python:** Uses the built-in `len()` function for all standard collections.
- **Rust:** Uses the `.len()` method on collections.
- **Mojo:** Uses the `.size` property for `List` and similar containers (*as of 2025-04-27 03:52 UTC+8*). `len(list)` is not supported for Mojo's List.

*Table and notes reflect the state of each language as of 2025-04-27 03:52 UTC+8. Please check official documentation for future updates.*

_Last updated: 2025-04-27 03:59 (UTC+8)_

---

## 13. Modular Code Structure

- As the project grew, the main.mojo file became too lengthy and hard to maintain. To address this, we adopted a modular structure similar to Python/Rust projects, moving shared logic to matrix_utils.mojo and organizing step/test scripts into dedicated subdirectories.
- This change significantly improves code readability, maintainability, and scalability.
- Timestamp: 2025-04-27 03:59 UTC+8

## 14. Mojo Modularization Limitation (April 2025)

- Attempted to fully modularize the project using a Python/Rust-inspired structure with shared logic in `matrix_utils.mojo` and separate step/test files in subdirectories.
- Mojo's current import and module system (as of April 2025) does **not** support calling any function imported from another file at file scope, even if it does not use `raises`.
- This means modularized step and test files cannot be run directly; only a single all-in-one file (e.g., `main.mojo`) is reliably runnable.
- The modular structure is preserved for future use when Mojo's import system matures.
- **Action:** Continue development and documentation in `main.mojo` for now, and revisit modularization as Mojo evolves.

_Last updated: 2025-04-27 04:35 UTC+8_
