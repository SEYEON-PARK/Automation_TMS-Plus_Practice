"""
centOS.txt와 93.txt 비교(개수까지 확인)

- 코드 사용 방법
1. 레드마인에서 rpm 설치 리스트 txt 파일로 다운로드한다. ⇒ txt 파일 안에 있는 딕셔너리 이용
2. txt 파일 안에 있는 딕셔너리로 rpm 항목 이름만 정리하여 다른 txt 파일로 만든다.(예시 - centOS.txt)
3. 각 운영체제 장비로 접속해서 실제 설치되어 있는 rpm 항목 이름 txt 파일로 저장한다.
4. scp로 내 윈도우 컴퓨터에 해당 파일을 보낸다.
5. 윈도우에서 파이썬 코드로 비교한다.(상황에 따라 조금 바꿔야 할 수도 있다.)
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