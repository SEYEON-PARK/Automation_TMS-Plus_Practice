"""
rocky.txt와 150.txt 비교(개수까지 확인)
"""

# 다른 파일에도 있는데 rocky.txt 파일에만 있다고 나오기도 해서 문제 있다고 생각했으나, 그게 아니라
# 두 개 있어서 해당 항목이 하나 더 있다고 표시해준 거다.
from collections import Counter

# 두 텍스트 파일 읽기
with open("rocky.txt", "r") as file1:
    list1 = [line.strip() for line in file1]

with open("150.txt", "r", encoding="utf-8") as file2: # rocky는 encoding 지정 안 해주면 에러가 났다.
    # 150번 장비의 rpm 패키지 이름이 레드마인 표랑 다른 경우가 있어서 첫 번째 '.' 이전 값만 읽어서 같은 형식으로 맞춰주기!
    list2 = [line.split('.')[0].strip() for line in file2]
 
after_dot = set()  # 중복을 없애기 위해 set 사용   
with open("150.txt", "r", encoding="utf-8") as file2:
    for line in file2:
        line = line.strip()  # 양쪽 공백 제거
        # print(f"처리 중: {line}")  # 읽은 줄을 출력해서 확인
        
        if '.' in line:
            split_line = line.split('.', 1)  # 첫 번째 마침표 기준으로 분리
            # print(f"분리 결과: {split_line}")  # 분리된 결과 확인
            
            if len(split_line) > 1:  # 마침표 뒤에 내용이 있을 때만 처리
                after_dot.add(split_line[1].strip())  # '.' 뒤의 내용을 set에 추가
            else:
                print("마침표 뒤에 내용이 없음")  # 마침표 뒤에 내용이 없을 때 출력
        else:
            print("마침표 없음")  # 마침표가 없을 때 출력


# 각 리스트에서의 항목 카운팅
counter1 = Counter(list1)
counter2 = Counter(list2)

# 두 리스트의 차이 출력
print("rocky에만 있는 것")
for item in counter1 - counter2:
    print(item)

print("\n150번 장비에만 있는 것")
for item in counter2 - counter1:
    print(item)

print(after_dot)

'''
"""
rocky.txt와 150.txt 비교(개수는 비교 안 하고, 그냥 있으면 넘어감.)
"""
# 다른 파일에도 있는데 rocky.txt 파일에만 있다고 나오기도 해서 문제 있다고 생각했으나, 그게 아니라
# 두 개 있어서 해당 항목이 하나 더 있다고 표시해준 거다.
from collections import Counter

# 두 텍스트 파일 읽기
with open("rocky.txt", "r") as file1:
    list1 = [line.strip() for line in file1]

with open("150.txt", "r", encoding="utf-8") as file2: # rocky는 encoding 지정 안 해주면 에러가 났다.
    # 150번 장비의 rpm 패키지 이름이 레드마인 표랑 다른 경우가 있어서 첫 번째 '.' 이전 값만 읽어서 같은 형식으로 맞춰주기!
    list2 = [line.split('.')[0].strip() for line in file2]
 
after_dot = set()  # 중복을 없애기 위해 set 사용   
with open("150.txt", "r", encoding="utf-8") as file2:
    for line in file2:
        line = line.strip()  # 양쪽 공백 제거
        # print(f"처리 중: {line}")  # 읽은 줄을 출력해서 확인
        
        if '.' in line:
            split_line = line.split('.', 1)  # 첫 번째 마침표 기준으로 분리
            # print(f"분리 결과: {split_line}")  # 분리된 결과 확인
            
            if len(split_line) > 1:  # 마침표 뒤에 내용이 있을 때만 처리
                after_dot.add(split_line[1].strip())  # . 뒤의 내용을 set에 추가
            else:
                print("마침표 뒤에 내용이 없음")  # 마침표 뒤에 내용이 없을 때 출력
        else:
            print("마침표 없음")  # 마침표가 없을 때 출력


# 각 리스트에서의 항목 카운팅
counter1 = Counter(list1)
counter2 = Counter(list2)

# 중복 없이 각 항목만 출력하도록 set 사용
set1 = set(counter1)
set2 = set(counter2)

# 두 리스트의 차이 출력
print("rocky에만 있는 것")
for item in set1 - set2:
    print(item)

print("\n150번 장비에만 있는 것")
for item in set2 - set1:
    print(item)

print(after_dot)
'''