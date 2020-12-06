# PYTHON ONLY THIS DAY

numbers = map(int, open("day01.txt", "r").read().strip().split("\n"))


def getNumbers(arr):
    for num in arr:
        for num2 in arr:
            for num3 in arr:
                if (num + num2 + num3) == 2020:
                    return num * num2 * num3


print(getNumbers(numbers))
