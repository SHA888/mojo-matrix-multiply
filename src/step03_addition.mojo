from collections import List
from matrix_utils import print_matrix, matrix_add

def main():
    a = List(
        List(1, 2),
        List(3, 4)
    )
    b = List(
        List(5, 6),
        List(7, 8)
    )
    result = matrix_add(a, b)
    print_matrix(a, "Matrix A:")
    print_matrix(b, "Matrix B:")
    print_matrix(result, "Result (A+B):")

main()
