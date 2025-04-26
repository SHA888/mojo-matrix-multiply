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

def main():
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

    # Original test: 2x2 matrices
    a = List(
        List(1, 2),
        List(3, 4)
    )
    b = List(
        List(5, 6),
        List(7, 8)
    )
    print("\nOriginal test: 2x2 matrices")
    result_add = matrix_add(a, b)
    if len(result_add) > 0:
        print_matrix(a, "Matrix A:")
        print_matrix(b, "Matrix B:")
        print_matrix(result_add, "Result (A+B):")
    result_mul = matrix_multiply(a, b)
    if len(result_mul) > 0:
        print_matrix(result_mul, "Result (A*B):")

    # Original test with shape mismatch
    a = List(
        List(1, 2),
        List(3, 4)
    )
    b = List(
        List(5, 6, 9),  # Different length row!
        List(7, 8)
    )
    print("\nOriginal test: shape mismatch")
    result_add = matrix_add(a, b)
    if len(result_add) > 0:
        print_matrix(a, "Matrix A:")
        print_matrix(b, "Matrix B:")
        print_matrix(result_add, "Result (A+B):")
    result_mul = matrix_multiply(a, b)
    if len(result_mul) > 0:
        print_matrix(result_mul, "Result (A*B):")