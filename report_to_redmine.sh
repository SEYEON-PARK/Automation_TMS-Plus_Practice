#!/bin/bash

# Redmine 서버 URL 및 API 키
REDMINE_URL="레드마인 IP 주소"
API_KEY="API 키"

# 수정할 일감 ID
ISSUE_ID="일감 번호"

# 현재 폴더 위치를 구함
CURRENT_DIR=$(pwd)

# 오늘 날짜 가져오기 (YYYY-MM-DD 형식)
TODAY=$(date '+%Y-%m-%d')

# IP 주소와 비밀번호 배열 정의 (각 IP에 대한 비밀번호)
IP_ADDRESSES=("10.0.5.92" "10.0.5.93" "10.0.5.99")  # IP 주소 목록
PASSWORDS=("92번 장비 비밀번호" "93번 장비 비밀번호" "99번 장비 비밀번호")  # 각 IP에 대응하는 비밀번호 목록
PORTS=("222" "222" "22") # 각 IP에 대응하는 포트 번호 목록
USER="root"  # 사용자 이름
FILE_PATH="$CURRENT_DIR/output.txt"  # 파일 경로
NEW_CONTENT="|$TODAY|"
LOCAL_IP=$(hostname -I | awk '{print $1}')
DETAILS=""

# 반복문을 통해 각 IP에 대해 파일 읽기
for i in "${!IP_ADDRESSES[@]}"; do
    IP="${IP_ADDRESSES[$i]}"
    PASSWORD="${PASSWORDS[$i]}"
    PORT="${PORTS[$i]}"
    # NEW_CONTENT+="|"
    
    # echo "Connecting to $IP on port $PORT..."
    
    # 로컬 처리
    if [ "$IP" == "$LOCAL_IP" ]; then
        # 로컬 파일 읽기
        output=$(cat "$FILE_PATH")
    else
        # ssh 명령어 실행
        output=$(sshpass -p "$PASSWORD" ssh -o ConnectTimeout=30 -p "$PORT" "$USER@$IP" "cat $FILE_PATH" 2>&1)
    fi

    # 출력 내용 확인
    echo "$output"

    # 파일이 있는지 확인
    if [ -z "$output" ]; then
        NEW_CONTENT+="*{color:blue}파일 미존재*|"
        continue
    fi
    
    # output.txt의 내용을 줄바꿈 기준으로 세 줄로 분리
    RUN_DATE=$(echo "$output" | sed -n '1p')
    CHECK_CONTENT=$(echo "$output" | sed -n '2p')
    DETAIL=$(echo "$output" | sed -n '3p')
        
    # echo "$RUN_DATE $CHECK_CONTENT $DETAIL" 
  
    # 오늘 검사한 내용인지 확인
    RUN_DATE=$(echo "$RUN_DATE" | awk '{print $1}') 
   
    # 날짜 비교
    if [ "$RUN_DATE" != "$TODAY" ]; then
        NEW_CONTENT+="*{color:blue}오늘 미실행*|"
        continue
    fi

    NEW_CONTENT+="$CHECK_CONTENT|"
    
    if [ -n "$DETAIL" ]; then
        DETAILS+="[ $IP ] $DETAIL\r\n"
    fi
done

# echo "$DETAILS"


NEW_CONTENT+="$DETAILS|"

echo "$NEW_CONTENT"

# 기존 내용 불러오기 (예: curl을 사용하거나 Redmine API로 가져옴)
EXISTING_DESCRIPTION=$(curl -s -X GET "$REDMINE_URL/issues/$ISSUE_ID.json" \
                            -H "X-Redmine-API-Key: $API_KEY" \
                            --max-time 30 | \
                            sed -n 's/.*"description":"\([^,]*\)".*/\1/p')



: <<'END_COMMENT' # 주석 처리
# EXISTING_DESCRIPTION="h3. 요약 \r\n\r\n* [TMS-Plus] 일일장비 점검 자동화 스크립트 제작 \r\n\r\nh3. 상세 내용 \r\n\r\n* 일일장비 점검 스크립트 자동 실행 및 결과 업로드 \r\n* 참고 TC : \"[TMS-Plus V4-76291:일일 장비점검]\":http://10.0.55.3/testlink/linkto.php?tprojectPrefix=TMS-Plus+V4\u0026item=testcase\u0026id=TMS-Plus+V4-76291\r\n추가할 내용입니다. 이 내용은 쉘 스크립트를 통해 자동으로 추가되었습니다.\r\n추가할 내용입니다. 이 내용은 쉘 스크립트를 통해 자동으로 추가되었습니다.\r\n\r\n---\r\n\r\nh3. 점검 결과 \r\n\r\n|. 수행일자|\\6={background:#d9d9d9;}. 결과|/2={background:#d9d9d9;}. 비고|\r\n|10.0.5.92| 10.0.5.93|10.0.5.99|10.0.5.146|10.0.5.150|10.0.5.151|\r\n|2024-09-30|PASS|SKIP|SKIP|SKIP|SKIP|SKIP|dmesg : power on/off 로 인한 하드웨어/os 에러 메세지 조회됨 (오류 X)|\r\n|2024-10-02|PASS|PASS|SKIP|SKIP|SKIP|SKIP|dmesg : power on/off 로 인한 하드웨어/os 에러 메세지 조회됨 (오류 X)|\r\n|2024-10-04|*{color:red;}중단*|PASS|SKIP|SKIP|PASS|SKIP|[10.0.5.92] #135830 segfault 확인 요청 (tp_event_agent) --\u003e 코어 파일 남지 않아 수정 보류 |\r\n|2024-10-07|PASS|PASS|SKIP|SKIP|PASS|PASS||"

echo "$EXISTING_DESCRIPTION"
echo

# '|'가 시작되는 부분을 기준으로 줄을 처리
# 첫 번째 '|'가 있는 위치 이후부터 데이터를 추출하고, 그 다음 줄을 확인
# lines_after_pipe=$(echo "$EXISTING_DESCRIPTION" | sed -n 's/^[^|]*|\(.*\)\r\n/\1/p')
# awk를 사용하여 패턴에 맞는 부분만 추출하고 원하는 형태로 변환
# awk -F'|' '{for(i=2;i<=NF;i++) if($i ~ /^=[^|]+\.[0-9.]+$/) print "|" substr($i,2)}' <<< "$EXISTING_DESCRIPTION"
awk -F'|' 'NR==2 {print $0}' <<< "$EXISTING_DESCRIPTION"


echo "$lines_after_pipe"

# \r\n 이전까지의 IP 주소 추출
second_line_before_newline=$(echo "$second_line" | sed 's/\r//')  # \r을 제거

echo "$second_line_before_newline"

# IP 주소 추출 (정규 표현식 사용)
ip_addresses=($(echo "$second_line_before_newline" | grep -oE '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+'))

# IP 주소 배열 출력
echo "추출된 IP 주소들: ${ip_addresses[@]}"
END_COMMENT

# 추가할 내용
# NEW_CONTENT="추가할 내용입니다. 이 내용은 쉘 스크립트를 통해 자동으로 추가되었습니다."


# 기존 내용과 새로운 내용 합치기 (줄바꿈을 실제로 처리)
NEW_DESCRIPTION="$EXISTING_DESCRIPTION\r\n$NEW_CONTENT"


# echo "$EXISTING_DESCRIPTION"
# echo
# echo

# echo "$NEW_DESCRIPTION"

# echo
# echo

# JSON 포맷 생성 (줄바꿈 및 따옴표 이스케이프 처리)
JSON_PAYLOAD=$(printf '{"issue": {"description": "%s"}}' "$NEW_DESCRIPTION")
# echo "$JSON_PAYLOAD"


# Redmine API를 통해 일감 내용 추가
curl -s -X PUT "$REDMINE_URL/issues/$ISSUE_ID.json" \
        -H "Content-Type: application/json" \
        -H "X-Redmine-API-Key: $API_KEY" \
        -d "$JSON_PAYLOAD"

# Redmine API를 통해 일감 내용 추가
# RESPONSE=$(curl -iv -X PUT "$REDMINE_URL/issues/$ISSUE_ID.json" \
#                    -H "Content-Type: application/json" \
#                    -H "X-Redmine-API-Key: $API_KEY" \
#                    -d "$JSON_PAYLOAD")

# 응답 확인
# echo "Response: $RESPONSE"

