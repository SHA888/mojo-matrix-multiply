from collections import List

def print_matrix(m: List[List[Int]], name: String):
    print(name)
    for i in range(len(m)):
        row = m[i]
        for j in range(len(row)):
            print(row[j], end=" ")
        print("")

def check_matrix_shape_equal(a: List[List[Int]], b: List[List[Int]]) -> Bool:
    if len(a) != len(b):
        print("Error: Matrices have different number of rows!")
        return False
    for i in range(len(a)):
        row_a = a[i]
        row_b = b[i]
        if len(row_a) != len(row_b):
            print("Error: Row", i, "has different lengths in the two matrices!")
            return False
    return True

def check_matrix_shape_multiplicable(a: List[List[Int]], b: List[List[Int]]) -> Bool:
    if len(a) == 0 or len(b) == 0:
        print("Error: One or both matrices are empty!")
        return False
    for i in range(len(a)):
        row_a = a[i]
        if len(row_a) != len(a[0]):
            print("Error: Matrix A has inconsistent row lengths!")
            return False
    for i in range(len(b)):
        row_b = b[i]
        if len(row_b) != len(b[0]):
            print("Error: Matrix B has inconsistent row lengths!")
            return False
    row_a = a[0]
    if len(row_a) != len(b):
        print("Error: Number of columns of A does not match number of rows of B!")
        return False
    return True

def matrix_add(a: List[List[Int]], b: List[List[Int]]) -> List[List[Int]]:
    if not check_matrix_shape_equal(a, b):
        print("Aborting matrix addition due to shape mismatch.")
        return List[List[Int]]()
    result = List[List[Int]]()
    for i in range(len(a)):
        row_a = a[i]
        row_b = b[i]
        row = List[Int]()
        for j in range(len(row_a)):
            row.append(row_a[j] + row_b[j])
        result.append(row)
    return result

def matrix_multiply(a: List[List[Int]], b: List[List[Int]]) -> List[List[Int]]:
    if not check_matrix_shape_multiplicable(a, b):
        print("Aborting matrix multiplication due to shape mismatch or invalid shapes.")
        return List[List[Int]]()
    result = List[List[Int]]()
    for i in range(len(a)):
        row_a = a[i]
        row = List[Int]()
        for j in range(len(b[0])):
            s = 0
            for k in range(len(row_a)):
                s += row_a[k] * b[k][j]
            row.append(s)
        result.append(row)
    return result

def matrix_transpose(a: List[List[Int]]) -> List[List[Int]]:
    if len(a) == 0:
        print("Error: Cannot transpose an empty matrix!")
        return List[List[Int]]()
    n_cols = len(a[0])
    for i in range(len(a)):
        row_a = a[i]
        if len(row_a) != n_cols:
            print("Error: Matrix has inconsistent row lengths! Cannot transpose.")
            return List[List[Int]]()
    result = List[List[Int]]()
    for j in range(n_cols):
        row = List[Int]()
        for i in range(len(a)):
            row_a = a[i]
            row.append(row_a[j])
        result.append(row)
    return result

def is_square_matrix(a: List[List[Int]]) -> Bool:
    if len(a) == 0:
        return False
    n = len(a)
    for i in range(len(a)):
        row_a = a[i]
        if len(row_a) != n:
            return False
    return True

def matrix_minor(a: List[List[Int]], row: Int, col: Int) -> List[List[Int]]:
    minor = List[List[Int]]()
    for i in range(len(a)):
        if i == row:
            continue
        row_val = a[i]
        minor_row = List[Int]()
        for j in range(len(row_val)):
            if j == col:
                continue
            minor_row.append(row_val[j])
        minor.append(minor_row)
    return minor

def matrix_determinant(a: List[List[Int]]) -> Int:
    n = len(a)
    if not is_square_matrix(a):
        print("Error: Determinant is only defined for non-empty square matrices!")
        return 0
    if n == 1:
        return a[0][0]
    if n == 2:
        row_a = a[0]
        row_b = a[1]
        return row_a[0] * row_b[1] - row_a[1] * row_b[0]
    if n == 3:
        row_a = a[0]
        row_b = a[1]
        row_c = a[2]
        return (
            row_a[0]*row_b[1]*row_c[2] + row_a[1]*row_b[2]*row_c[0] + row_a[2]*row_b[0]*row_c[1]
            - row_a[2]*row_b[1]*row_c[0] - row_a[0]*row_b[2]*row_c[1] - row_a[1]*row_b[0]*row_c[2]
        )
    det = 0
    for j in range(n):
        sign = 1 if j % 2 == 0 else -1
        row_a = a[0]
        det += sign * row_a[j] * matrix_determinant(matrix_minor(a, 0, j))
    return det

def print_det(a: List[List[Int]], name: String):
    print_matrix(a, name)
    print("Determinant:", matrix_determinant(a))
