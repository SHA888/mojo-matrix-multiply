from collections import List
from matrix_utils import matrix_add

def test_addition():
    a = List(List(1, 2), List(3, 4))
    b = List(List(5, 6), List(7, 8))
    expected = List(List(6, 8), List(10, 12))
    result = matrix_add(a, b)
    assert result == expected, "Addition result incorrect!"

test_addition()
print("test_addition.mojo passed.")
