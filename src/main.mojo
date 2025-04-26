from collections import List

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
    # Matrix addition
    result_add = List(
        List(0, 0),
        List(0, 0)
    )
    for i in range(len(a)):
        for j in range(len(a[i])):
            result_add[i][j] = a[i][j] + b[i][j]

    print("Matrix A:")
    for i in range(len(a)):
        for j in range(len(a[i])):
            print(a[i][j], end=" ")
        print("")
    print("Matrix B:")
    for i in range(len(b)):
        for j in range(len(b[i])):
            print(b[i][j], end=" ")
        print("")
    print("Result (A+B):")
    for i in range(len(result_add)):
        for j in range(len(result_add[i])):
            print(result_add[i][j], end=" ")
        print("")

    # Matrix multiplication
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
    print("Result (A*B):")
    for i in range(len(result_mul)):
        for j in range(len(result_mul[i])):
            print(result_mul[i][j], end=" ")
        print("")