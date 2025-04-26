from collections import List
from matrix_utils import print_matrix, matrix_add, matrix_multiply

def main():
    a = List[List[Int]]()
    b = List[List[Int]]()
    print("\nTest 1: Empty matrices")
    result_add = matrix_add(a, b)
    if len(result_add) > 0:
        print_matrix(result_add, "Result (A+B):")
    result_mul = matrix_multiply(a, b)
    if len(result_mul) > 0:
        print_matrix(result_mul, "Result (A*B):")

main()
