from collections import List
from matrix_utils import print_matrix, matrix_add, matrix_multiply

def main():
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

main()
