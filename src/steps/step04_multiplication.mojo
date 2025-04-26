from collections import List
from matrix_utils import print_matrix, matrix_multiply

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
    result = matrix_multiply(a, b)
    print_matrix(a, "Matrix A:")
    print_matrix(b, "Matrix B:")
    print_matrix(result, "Result (A*B):")

def run() raises:
    main()

run()
main()
