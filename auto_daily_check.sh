#!/bin/bash

# 스크립트의 경로를 명시적으로 변환
CURRENT_DIR=$(cd "$(dirname "$BASH_SOURCE")" && pwd)

# txt 파일 경로 설정 (현재 폴더 아래에 'output.txt' 파일 생성)
OUTPUT_FILE="$CURRENT_DIR/output.txt"

# daily_check.sh 파일 실행하여 결과 가져오기
DAILY_CHECK=$(sh $CURRENT_DIR/daily_check.sh)
# echo "$DAILY_CHECK"

# 이전 실행 시간 읽기 (첫 번째 줄)
if [ -f "$OUTPUT_FILE" ]; then
    LAST_RUN_TIME=$(head -n 1 "$OUTPUT_FILE")
else
    # 오늘 기준! 이걸 사용해야 함.
    LAST_RUN_TIME=$(date -d "00:00:00" +"%Y-%m-%d %H:%M:%S")
    # LAST_RUN_TIME="2024-12-03 00:00:00"
fi

# echo "$LAST_RUN_TIME"

last_run_timestamp=$(date -d "$LAST_RUN_TIME" +"%s")

# 현재 시간 기록 (첫 번째 줄에 업데이트 예정)
CURRENT_TIME=$(date +"%Y-%m-%d %H:%M:%S")

# 점검 결과 초기화
check="PASS"
problem_number=""

# 1. '1. dmesg error check'부터 한 줄 띄기 전까지의 내용 추출
logs_after_check=$(echo "$DAILY_CHECK" | awk '/\[ 1. dmesg error check \]/{flag=1; next} flag && NF {print} !NF{flag=0}')

# echo "$logs_after_check" | wc -l

# 각 줄마다 첫 번째 [] 안에 있는 내용만 추출
# dmesg_logs_date=$(echo "$logs_after_check" | sed -n 's/^\([^[[]*\[\([^]]*\)\][^]]*\).*$/\2/p' | sed -E 's/([가-힣]+) ([0-9]+)월 ([0-9]+) ([0-9]+:[0-9]+:[0-9]+) ([0-9]+)/\5-\2-\3 \4/')
# dmesg_logs_date=$(echo "$logs_after_check" | sed -n 's/^\([^[[]*\[\([^]]*\)\][^]]*\).*$/\2/p' | sed -E 's/([가-힣]+) ([0-9]{1,2})월 ([0-9]{1,2}) ([0-9]+:[0-9]+:[0-9]+) ([0-9]+)/\5-\2-\3 \4/')
dmesg_logs_date=$(echo "$logs_after_check" | sed -n 's/^\([^[[]*\[\([^]]*\)\][^]]*\).*$/\2/p' | sed -E 's/([가-힣]+)[[:space:]]*([0-9]{1,2})월[[:space:]]*([0-9]{1,2})[[:space:]]*([0-9]+:[0-9]+:[0-9]+)[[:space:]]*([0-9]+)/\5-\2-\3 \4/; s/([0-9]{4})-([0-9]{2})-([0-9]{2}) ([0-9]+:[0-9]+:[0-9]+) /\1-\2-\3 \4/') 


# echo "$dmesg_logs_date" | wc -l

# 각 로그 날짜와 LAST_RUN_TIME 비교
while read -r log_date; do
    log_timestamp=$(date -d "$log_date" +"%s")

    if [ "$log_timestamp" -gt "$last_run_timestamp" ]; then
        # echo "로그 시간 $log_date는 LAST_RUN_TIME 이후입니다."
        check="*{color:red}확인 필요*"
        problem_number="1번"
        break
    fi
done <<< "$dmesg_logs_date"

# 2. '2. core file check'부터 한 줄 띄기 전까지의 내용 추출
logs_after_check=$(echo "$DAILY_CHECK" | awk '/\[ 2. core file check \]/{flag=1; next} flag && NF {print} !NF{flag=0}')
# echo "$logs_after_check"

# 코어파일 반복하며 확인
while read -r line; do
    # 경로 추출
    file_path=$(echo "$line" | awk '{print $NF}')
    # echo "$file_path"

    # 해당 경로의 stat 정보에서 Modify 시간 가져오기
    modify_time=$(stat --format='%y' "$file_path")

    # Modify 시간만 추출하여 비교
    modify_timestamp=$(date -d "$modify_time" +"%s")

    # echo "$last_run_timestamp"
    # echo "$modify_timestamp"

    # Modify 시간이 기준 날짜보다 이후이면 반복 종료
    if [ "$modify_timestamp" -gt "$last_run_timestamp" ]; then
        # echo "파일 '$file_path'의 수정 시간 '$modify_time'은 기준 날짜 이후입니다. 반복 종료."
        check="*{color:red}확인 필요*"
        if [ -z "$problem_number" ]; then
            problem_number="2번"
        else
            problem_number+=", 2번"
        fi
        break
    fi
done <<< "$logs_after_check"


# echo "$logs_after_check" | tac | while read -r line; do
    # 경로 추출
#    file_path=$(echo "$line" | awk '{print $NF}')
#    echo "$file_path"

    # 해당 경로의 stat 정보에서 Modify 시간 가져오기
#    modify_time=$(stat --format='%y' "$file_path")
    
    # Modify 시간만 추출하여 비교
#    modify_timestamp=$(date -d "$modify_time" +"%s")

#    echo "$last_run_timestamp" 
#    echo "$modify_timestamp" 
    
    # Modify 시간이 기준 날짜보다 이후이면 반복 종료
#    if [ "$modify_timestamp" -gt "$last_run_timestamp" ]; then
#        echo "파일 '$file_path'의 수정 시간 '$modify_time'은 기준 날짜 이후입니다. 반복 종료."
#        check="*{color:red}확인 필요*"
#        if [ -z "$problem_number" ]; then
#            problem_number=", 2번"
#        else
#            problem_number+="2번"
#        fi
#        break
#    fi
# done

# 3. '3. zombie process check'부터 한 줄 띄기 전까지의 내용 추출
logs_after_check=$(echo "$DAILY_CHECK" | awk '/\[ 3. zombie process check \]/{flag=1; next} flag && NF {print} !NF{flag=0}')

if [ -n "$logs_after_check" ]; then
    check="*{color:red}확인 필요*"
    if [ -z "$problem_number" ]; then
        problem_number="3번"
    else
        problem_number+=", 3번"
    fi
fi

# 4. '4. process etime check'부터 한 줄 띄기 전까지의 내용 추출
logs_after_check=$(echo "$DAILY_CHECK" | awk '/\[ 4. process etime check \]/{flag=1; next} flag && NF {print} !NF{flag=0}')

# 시간 차이 허용 범위 (10분 = 600초)
time_diff_allowed=600

# 첫 번째 줄을 건너뛰고 두 번째 줄부터 반복문을 시작하도록 처리
first_line_skipped=false

# `logs_after_check`를 줄별로 처리
while IFS= read -r line; do
    # 첫 번째 줄(줄 수만 출력된 거) 건너뛰기
    if ! $first_line_skipped; then
        first_line_skipped=true
        continue
    fi

    # `etime` 추출
    etime_str=$(echo "$line" | awk '{print $2}')

    # echo "$etime_str"
    # echo "$line"

    # 예외 처리 (특정 프로세스는 시간 차이 비교에서 제외)
    if [[ "$line" =~ "tpp_sql_interface.py" ]] || [[ "$line" =~ "tps_process_check" ]]; then
        # echo "건너뛰기!!!!!!!!"
        continue
    fi

    # 일, 시, 분, 초로 분리
    days=$(echo "$etime_str" | cut -d'-' -f1)
    time_str=$(echo "$etime_str" | cut -d'-' -f2)
    hours=$(echo "$time_str" | cut -d':' -f1)
    minutes=$(echo "$time_str" | cut -d':' -f2)
    seconds=$(echo "$time_str" | cut -d':' -f3)

    # 숫자 앞의 0을 제거 (만약 09, 08 같은 값이 들어올 경우)
    days=${days#0}
    hours=${hours#0}
    minutes=${minutes#0}
    seconds=${seconds#0}

    # echo "$days"
    # echo "$time_str"
    # echo "$hours"
    # echo "$minutes"
    # echo "$seconds"

    # 시간 단위로 초로 변환
    total_seconds=$(( (days * 86400) + (hours * 3600) + (minutes * 60) + seconds ))

    # echo "Total seconds for $etime_str: $total_seconds"

    # 첫 번째 `etime`을 기준으로 설정하고, 이후 비교
    if [ -z "$prev_etime_timestamp" ]; then
        prev_etime_timestamp=$total_seconds
    else
        time_diff=$(( total_seconds > prev_etime_timestamp ? total_seconds - prev_etime_timestamp : prev_etime_timestamp - total_seconds ))
 
        # echo "$time_diff"

        # 시간 차이가 10분을 초과하면 출력
        if [ "$time_diff" -gt "$time_diff_allowed" ]; then
            # echo "시간 차이가 많이 납니다."
            check="*{color:red}확인 필요*"
            if [ -z "$problem_number" ]; then
                problem_number="4번"
            else
                problem_number+=", 4번"
            fi
            break
        fi
    fi
done <<< "$logs_after_check"



# 루프를 통해 각 줄 처리
# for line in "$logs_after_check"; do
    # `etime` 추출
#    etime_str=$(echo "$line" | awk '{print $2}')
    
#    echo "$etime_str"
#    echo "$line" 
 
    # 예외 처리 (특정 프로세스는 시간 차이 비교에서 제외)
#    if [[ "$line" =~ "tpp_sql_interface.py" ]] || [[ "$line" =~ "tps_process_check" ]]; then
#        continue
#    fi

    # `etime_str`을 "8-15:29:39" 형식에서 날짜로 변환하여 `etime_timestamp` 계산
#    etime_timestamp=$(date -d "$(date +%Y)-$etime_str" +%s)

    # 첫 번째 `etime`을 기준으로 설정하고, 이후 비교
#    if [ -z "$prev_etime_timestamp" ]; then
#        prev_etime_timestamp=$etime_timestamp
#    else
#        time_diff=$((etime_timestamp - prev_etime_timestamp))

        # 시간 차이가 20분을 초과하면 출력
#        if [ "$time_diff" -gt "$time_diff_allowed" ]; then
#            echo "시간 차이가 많이 납니다."
#        else
#            echo "시간 차이가 정상 범위 내입니다."
#        fi

        # 이전 `etime`을 현재로 업데이트
#        prev_etime_timestamp=$etime_timestamp
#    fi
# done

# 5. '5. disk check'부터 한 줄 띄기 전까지의 내용 추출
logs_after_check=$(echo "$DAILY_CHECK" | awk '/\[ 5. disk check \]/{flag=1; next} flag && NF {print} !NF{flag=0}')
# echo "$logs_after_check"
: <<'END_COMMENT' # 주석 처리
logs_after_check="Filesystem      Size  Used Avail Use% Mounted on
devtmpfs         63G     0   63G   0% /dev
tmpfs            63G   20K   63G   1% /dev/shm
/dev/sda1       100G   90G   10G  81% /
devtmpfs         63G     0   63G  80% /dev
tmpfs            63G   20K   63G  79% /dev/shm
/dev/sda1       100G   90G   10G  120% /"
END_COMMENT

# 문자열을 줄 단위로 처리
while IFS= read -r line; do
    # 헤더 줄 건너뛰기
    if [[ "$line" =~ ^Filesystem ]]; then
        continue
    fi

    # 사용률(Use%) 추출
    use_percent=$(echo "$line" | awk '{print $5}' | tr -d '%')

    # 숫자인지 확인하고 처리
    if [[ "$use_percent" =~ ^[0-9]+$ ]]; then
        if [ "$use_percent" -gt 80 ]; then
            check="*{color:red}확인 필요*"
            if [ -z "$problem_number" ]; then
                problem_number="5번"
            else
                problem_number+=", 5번"
            fi
            break
        fi
    fi
done <<< "$logs_after_check"

# echo "check: $check"
# echo "problem_number: $problem_number"

echo "$CURRENT_TIME" > "$OUTPUT_FILE"
echo "$check" >> "$OUTPUT_FILE"
echo "$problem_number" >> "$OUTPUT_FILE"

