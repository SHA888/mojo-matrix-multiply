from collections import List
from matrix_utils import matrix_add, matrix_multiply

def test_empty_matrices():
    a = List[List[Int]]()
    b = List[List[Int]]()
    result_add = matrix_add(a, b)
    assert result_add == List[List[Int]](), "Addition of empty matrices should be empty."
    result_mul = matrix_multiply(a, b)
    assert result_mul == List[List[Int]](), "Multiplication of empty matrices should be empty."

test_empty_matrices()
print("test_empty_matrices.mojo passed.")
