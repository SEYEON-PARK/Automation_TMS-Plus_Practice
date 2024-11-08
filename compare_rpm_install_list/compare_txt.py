"""
centOS.txt와 rocky.txt 비교
"""

from collections import Counter

# 두 텍스트 파일 읽기
with open("centOS.txt", "r") as file1:
    list1 = [line.strip() for line in file1]

with open("rocky.txt", "r") as file2:
    list2 = [line.strip() for line in file2]

# 각 리스트에서의 항목 카운팅
counter1 = Counter(list1)
counter2 = Counter(list2)

# 두 리스트의 차이 출력
print("centOS에만 있는 것")
for item in counter1 - counter2:
    print(item)

print("\nrocky에만 있는 것")
for item in counter2 - counter1:
    print(item)
