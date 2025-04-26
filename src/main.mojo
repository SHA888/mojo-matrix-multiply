from collections import List

def print_matrix(m: List[List[Int]], name: String):
    print(name)
    for i in range(len(m)):
        for j in range(len(m[i])):
            print(m[i][j], end=" ")
        print("")

def check_matrix_shape(a: List[List[Int]], b: List[List[Int]]) -> Bool:
    if len(a) != len(b):
        print("Error: Matrices have different number of rows!")
        return False
    for i in range(len(a)):
        if len(a[i]) != len(b[i]):
            print("Error: Row", i, "has different lengths in the two matrices!")
            return False
    return True

def main():
    l = List(2, 3, 5)
    l.append(7)
    l.append(11)
    print("Popping last item from list: ", l.pop())
    for idx in range(len(l)):
        print(l[idx])

    a = List(
        List(1, 2),
        List(3, 4)
    )
    b = List(
        List(5, 6),
        List(7, 8)
    )
    # Matrix addition with error check
    if not check_matrix_shape(a, b):
        print("Aborting matrix addition due to shape mismatch.")
        return
    result_add = List(
        List(0, 0),
        List(0, 0)
    )
    for i in range(len(a)):
        for j in range(len(a[i])):
            result_add[i][j] = a[i][j] + b[i][j]

    # Matrix multiplication with error check
    if len(a[0]) != len(b):
        print("Error: Number of columns of A does not match number of rows of B!")
        print("Aborting matrix multiplication.")
        return
    result_mul = List(
        List(0, 0),
        List(0, 0)
    )
    for i in range(len(a)):
        for j in range(len(b[0])):
            s = 0
            for k in range(len(a[0])):
                s += a[i][k] * b[k][j]
            result_mul[i][j] = s

    print_matrix(a, "Matrix A:")
    print_matrix(b, "Matrix B:")
    print_matrix(result_add, "Result (A+B):")
    print_matrix(result_mul, "Result (A*B):")