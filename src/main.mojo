from collections import List

def print_matrix(m: List[List[Int]], name: String):
    print(name)
    for i in range(len(m)):
        for j in range(len(m[i])):
            print(m[i][j], end=" ")
        print("")

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

def matrix_add(a: List[List[Int]], b: List[List[Int]]) -> List[List[Int]]:
    if not check_matrix_shape_equal(a, b):
        print("Aborting matrix addition due to shape mismatch.")
        return List[List[Int]]()
    result = List[List[Int]]()
    for i in range(len(a)):
        row = List[Int]()
        for j in range(len(a[i])):
            row.append(a[i][j] + b[i][j])
        result.append(row)
    return result

def matrix_multiply(a: List[List[Int]], b: List[List[Int]]) -> List[List[Int]]:
    if not check_matrix_shape_multiplicable(a, b):
        print("Aborting matrix multiplication due to shape mismatch or invalid shapes.")
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

def matrix_transpose(a: List[List[Int]]) -> List[List[Int]]:
    if len(a) == 0:
        print("Error: Cannot transpose an empty matrix!")
        return List[List[Int]]()
    n_cols = len(a[0])
    # Check all rows have the same length
    for i in range(len(a)):
        if len(a[i]) != n_cols:
            print("Error: Matrix has inconsistent row lengths! Cannot transpose.")
            return List[List[Int]]()
    result = List[List[Int]]()
    for j in range(n_cols):
        row = List[Int]()
        for i in range(len(a)):
            row.append(a[i][j])
        result.append(row)
    return result

# Interactive input is not supported in Mojo yet; see FINDINGS.md for details.
# def read_matrix(name: String) -> List[List[Int]]:
#     ...
# def interactive_mode():
#     ...

def main():
    # Interactive input is not supported in Mojo yet.
    # print("Do you want to enter matrices interactively? (y/n):", end=" ")
    # ans = input().strip().lower()
    # if ans == "y":
    #     interactive_mode()
    #     return
    # Automated tests below...

    l = List(2, 3, 5)
    l.append(7)
    l.append(11)
    print("Popping last item from list: ", l.pop())
    for idx in range(len(l)):
        print(l[idx])

    # Test 1: Empty matrices
    a = List[List[Int]]()
    b = List[List[Int]]()
    print("\nTest 1: Empty matrices")
    result_add = matrix_add(a, b)
    if len(result_add) > 0:
        print_matrix(result_add, "Result (A+B):")
    result_mul = matrix_multiply(a, b)
    if len(result_mul) > 0:
        print_matrix(result_mul, "Result (A*B):")

    # Test 2: Non-square matrices
    a = List(
        List(1, 2, 3),
        List(4, 5, 6)
    )
    b = List(
        List(7, 8),
        List(9, 10),
        List(11, 12)
    )
    print("\nTest 2: Non-square matrices")
    result_add = matrix_add(a, b)
    if len(result_add) > 0:
        print_matrix(a, "Matrix A:")
        print_matrix(b, "Matrix B:")
        print_matrix(result_add, "Result (A+B):")
    result_mul = matrix_multiply(a, b)
    if len(result_mul) > 0:
        print_matrix(result_mul, "Result (A*B):")

    # Test 3: 2x2 matrices
    a = List(
        List(1, 2),
        List(3, 4)
    )
    b = List(
        List(5, 6),
        List(7, 8)
    )
    print("\nTest 3: 2x2 matrices")
    result_add = matrix_add(a, b)
    if len(result_add) > 0:
        print_matrix(a, "Matrix A:")
        print_matrix(b, "Matrix B:")
        print_matrix(result_add, "Result (A+B):")
    result_mul = matrix_multiply(a, b)
    if len(result_mul) > 0:
        print_matrix(result_mul, "Result (A*B):")

    # Test 4: Shape mismatch
    a = List(
        List(1, 2),
        List(3, 4)
    )
    b = List(
        List(5, 6, 9),  # Different length row!
        List(7, 8)
    )
    print("\nTest 4: shape mismatch")
    result_add = matrix_add(a, b)
    if len(result_add) > 0:
        print_matrix(a, "Matrix A:")
        print_matrix(b, "Matrix B:")
        print_matrix(result_add, "Result (A+B):")
    result_mul = matrix_multiply(a, b)
    if len(result_mul) > 0:
        print_matrix(result_mul, "Result (A*B):")

    # Test 5: 1x1 matrices (scalar)
    a = List(
        List(42)
    )
    b = List(
        List(-7)
    )
    print("\nTest 5: 1x1 matrices (scalar)")
    result_add = matrix_add(a, b)
    if len(result_add) > 0:
        print_matrix(a, "Matrix A:")
        print_matrix(b, "Matrix B:")
        print_matrix(result_add, "Result (A+B):")
    result_mul = matrix_multiply(a, b)
    if len(result_mul) > 0:
        print_matrix(result_mul, "Result (A*B):")

    # Test 6: 1xN and Nx1 matrices (row/column vectors)
    a = List(
        List(1, 2, 3)
    )
    b = List(
        List(4),
        List(5),
        List(6)
    )
    print("\nTest 6: 1xN and Nx1 matrices (row/column vectors)")
    result_mul = matrix_multiply(a, b)
    if len(result_mul) > 0:
        print_matrix(a, "Matrix A:")
        print_matrix(b, "Matrix B:")
        print_matrix(result_mul, "Result (A*B):")

    # Test 7: Matrices with zeros and negatives
    a = List(
        List(0, -1),
        List(-2, 0)
    )
    b = List(
        List(-3, 0),
        List(0, 4)
    )
    print("\nTest 7: Matrices with zeros and negatives")
    result_add = matrix_add(a, b)
    if len(result_add) > 0:
        print_matrix(a, "Matrix A:")
        print_matrix(b, "Matrix B:")
        print_matrix(result_add, "Result (A+B):")
    result_mul = matrix_multiply(a, b)
    if len(result_mul) > 0:
        print_matrix(result_mul, "Result (A*B):")

    # Test 8: Large matrices (3x3)
    a = List(
        List(1, 2, 3),
        List(4, 5, 6),
        List(7, 8, 9)
    )
    b = List(
        List(9, 8, 7),
        List(6, 5, 4),
        List(3, 2, 1)
    )
    print("\nTest 8: Large 3x3 matrices")
    result_add = matrix_add(a, b)
    if len(result_add) > 0:
        print_matrix(a, "Matrix A:")
        print_matrix(b, "Matrix B:")
        print_matrix(result_add, "Result (A+B):")
    result_mul = matrix_multiply(a, b)
    if len(result_mul) > 0:
        print_matrix(result_mul, "Result (A*B):")

    # Test 9: Inconsistent row matrices
    a = List(
        List(1, 2),
        List(3, 4, 5)
    )
    b = List(
        List(6, 7),
        List(8, 9)
    )
    print("\nTest 9: Inconsistent row matrices")
    result_add = matrix_add(a, b)
    if len(result_add) > 0:
        print_matrix(a, "Matrix A:")
        print_matrix(b, "Matrix B:")
        print_matrix(result_add, "Result (A+B):")
    result_mul = matrix_multiply(a, b)
    if len(result_mul) > 0:
        print_matrix(result_mul, "Result (A*B):")

    # Test 10: Transpose square matrix
    a = List(
        List(1, 2),
        List(3, 4)
    )
    print("\nTest 10: Transpose square matrix")
    result = matrix_transpose(a)
    if len(result) > 0:
        print_matrix(a, "Matrix A:")
        print_matrix(result, "Result (A^T):")

    # Test 11: Transpose non-square matrix
    a = List(
        List(1, 2, 3),
        List(4, 5, 6)
    )
    print("\nTest 11: Transpose non-square matrix")
    result = matrix_transpose(a)
    if len(result) > 0:
        print_matrix(a, "Matrix A:")
        print_matrix(result, "Result (A^T):")

    # Test 12: Transpose row vector
    a = List(
        List(7, 8, 9)
    )
    print("\nTest 12: Transpose row vector")
    result = matrix_transpose(a)
    if len(result) > 0:
        print_matrix(a, "Matrix A:")
        print_matrix(result, "Result (A^T):")

    # Test 13: Transpose column vector
    a = List(
        List(10),
        List(11),
        List(12)
    )
    print("\nTest 13: Transpose column vector")
    result = matrix_transpose(a)
    if len(result) > 0:
        print_matrix(a, "Matrix A:")
        print_matrix(result, "Result (A^T):")

    # Test 14: Transpose empty matrix
    a = List[List[Int]]()
    print("\nTest 14: Transpose empty matrix")
    result = matrix_transpose(a)
    if len(result) > 0:
        print_matrix(a, "Matrix A:")
        print_matrix(result, "Result (A^T):")

    # Test 15: Transpose inconsistent matrix
    a = List(
        List(1, 2),
        List(3)
    )
    print("\nTest 15: Transpose inconsistent matrix")
    result = matrix_transpose(a)
    if len(result) > 0:
        print_matrix(a, "Matrix A:")
        print_matrix(result, "Result (A^T):")

main()