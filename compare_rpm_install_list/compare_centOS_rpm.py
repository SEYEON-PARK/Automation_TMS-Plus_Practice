"""
centOS.txt와 93.txt 비교(개수까지 확인)
"""

# 다른 파일에도 있는데 centOS.txt 파일에만 있다고 나오기도 해서 문제 있다고 생각했으나, 그게 아니라
# 두 개 있어서 해당 항목이 하나 더 있다고 표시해준 거다.
from collections import Counter

# 두 텍스트 파일 읽기
with open("centOS.txt", "r") as file1:
    list1 = [line.strip() for line in file1]

with open("93.txt", "r") as file2:
    list2 = [line.strip() for line in file2]

# 각 리스트에서의 항목 카운팅
counter1 = Counter(list1)
counter2 = Counter(list2)

# 두 리스트의 차이 출력
print("centOS에만 있는 것")
for item in counter1 - counter2:
    print(item)

print("\n93번 장비에만 있는 것")
for item in counter2 - counter1:
    print(item)

'''
"""
centOS.txt와 93.txt 비교(개수는 비교 안 하고, 그냥 있으면 넘어감.)
"""

from collections import Counter

# 두 텍스트 파일 읽기
with open("centOS.txt", "r") as file1:
    list1 = [line.strip() for line in file1]

with open("93.txt", "r") as file2:
    list2 = [line.strip() for line in file2]

# 각 리스트에서의 항목 카운팅
counter1 = Counter(list1)
counter2 = Counter(list2)

# 중복 없이 각 항목만 출력하도록 set 사용
set1 = set(counter1)
set2 = set(counter2)

# 두 리스트의 차이 출력
print("centOS에만 있는 것")
for item in set1 - set2:
    print(item)

print("\n93번 장비에만 있는 것")
for item in set2 - set1:
    print(item)
'''