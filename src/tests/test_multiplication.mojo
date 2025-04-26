from collections import List
from matrix_utils import matrix_multiply

def test_multiplication():
    a = List(List(1, 2, 3), List(4, 5, 6))
    b = List(List(7, 8), List(9, 10), List(11, 12))
    expected = List(List(58, 64), List(139, 154))
    result = matrix_multiply(a, b)
    assert result == expected, "Multiplication result incorrect!"

test_multiplication()
print("test_multiplication.mojo passed.")
