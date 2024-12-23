#!/bin/bash

# daily_check.sh 파일 실행하여 결과 가져오기
DAILY_CHECK=$(sh /backup/TMS-Plus/daily_check.sh)
# echo "$DAILY_CHECK"

# Redmine 서버 URL 및 API 키
REDMINE_URL="IP 주소소"
API_KEY="key"

# 수정할 일감 ID
ISSUE_ID="일감 번호호"

# 이스케이핑 함수 정의
escape_json_string() {
  local str="$1"
  printf "%s" "$str" | sed -e 's/\\/\\\\/g' -e 's/"/\\"/g' -e 's/\n/\\n/g'
}

# 추가할 내용
NEW_CONTENT="추가할 내용입니다. 이 내용은 쉘 스크립트를 통해 자동으로 추가되었습니다."

# 기존 내용 불러오기 (예: curl을 사용하거나 Redmine API로 가져옴)
EXISTING_DESCRIPTION=$(curl -s -X GET "$REDMINE_URL/issues/$ISSUE_ID.json" \
                            -H "X-Redmine-API-Key: $API_KEY" | \
                            sed -n 's/.*"description":"\([^,]*\)".*/\1/p' | \
                            sed 's/\\r\\n/\n/g' | sed 's/\\"/\"/g' )

# 기존 내용과 새로운 내용 합치기
NEW_DESCRIPTION=$(echo -e "$EXISTING_DESCRIPTION\n$NEW_CONTENT")

# JSON 문자열 이스케이핑
ESCAPED_DESCRIPTION=$(escape_json_string "$NEW_DESCRIPTION")

# Redmine API 호출
RESPONSE=$(curl -iv -X PUT "$REDMINE_URL/issues/$ISSUE_ID.json" \
     -H "Content-Type: application/json" \
     -H "X-Redmine-API-Key: $API_KEY" \
     -d "{
           \"issue\": {
             \"description\": \"$ESCAPED_DESCRIPTION\"
           }
         }")

# 응답 확인
echo "Response: $RESPONSE"
 
# echo "$EXISTING_DESCRIPTION"
# 새로운 내용 추가
# NEW_DESCRIPTION=$(echo -e "$EXISTING_DESCRIPTION\n$NEW_CONTENT" | sed 's/\n/\\r\\n/g' | sed 's/\"/\\"/g')
# 기존 내용과 새로운 내용 합치기 (줄바꿈을 실제로 처리)

# NEW_DESCRIPTION=$(echo -e "$EXISTING_DESCRIPTION")
# NEW_DESCRIPTION=$(echo -e "$EXISTING_DESCRIPTION\n$NEW_CONTENT" | sed 's/\n/\\r\\n/g' | sed 's/\"/\\"/g')

# echo
# echo
# echo "$NEW_DESCRIPTION"
# Redmine API를 통해 일감 내용 추가
# RESPONSE=$(curl -iv -X PUT "$REDMINE_URL/issues/$ISSUE_ID.json" \
#     -H "Content-Type: application/json" \
#     -H "X-Redmine-API-Key: $API_KEY" \
#     -d '{
#           "issue": {
#             "description": "'"$NEW_DESCRIPTION"'"
#           }
#         }')

# 응답 확인
echo "Response: $RESPONSE"

