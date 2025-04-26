from collections import List
from matrix_utils import matrix_add, matrix_multiply

def test_non_square_matrices():
    a = List(List(1, 2, 3), List(4, 5, 6))
    b = List(List(7, 8), List(9, 10), List(11, 12))
    result_add = matrix_add(a, b)
    # Should fail shape check, so expect empty result
    assert result_add == List[List[Int]](), "Addition with non-square matrices should fail."
    result_mul = matrix_multiply(a, b)
    expected = List(List(58, 64), List(139, 154))
    assert result_mul == expected, "Multiplication result for non-square matrices is incorrect."

test_non_square_matrices()
print("test_non_square_matrices.mojo passed.")
