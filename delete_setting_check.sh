#!/bin/bash

# SQLite 데이터베이스 파일
DB_FILE="/home1/TMS41/www/dbb/tmsplus.dbb"

# 데이터베이스 암호
alias dpw='echo "PRAGMA key='\''$(cat /home1/TMS41/sniper.dat |grep "^[Serial].*\\[" | sha256sum | cut -d " " -f1)'\'';"'
DB_PASSWORD=$(dpw)

# SQL 쿼리
SQL_QUERY="select * from ENV_CONFIG_CODE where SCATEGORY='DB_DELETE';"

# SQLCipher로 데이터 조회
result=$(/home1/TMS41/www/dbb/sqlcipher "$DB_FILE" <<EOF
$DB_PASSWORD;
$SQL_QUERY;
EOF
)

# 1~4번째 행만 저장
filtered_result=$(echo "$result" | head -n 4)

# 연관 배열 선언 (딕셔너리)
declare -A data_dict

# 딕셔너리에 저장될 항목
data_array=("USE_FLAG" "DURATION" "RUN_HOUR" "TYPE")
ko_data_array=("DB 삭제" "기간(일)" "실행시간(시)" "삭제 대상")

# 데이터를 분리해서 딕셔너리에 저장
IFS=$'\n'
for row in $filtered_result; do
    # 각 행을 출력하여 확인 (디버깅)
    # echo "Processing row: $row"

    # 데이터를 |로 나누기
    IFS='|' read -r scategory skey sname <<< "$row"

    # 디버깅: 각 값 확인
    # echo "row split: $scategory | $skey | $sname"

    # 모든 1~4번째 데이터를 연관 배열로 저장 (id를 키로 사용)
    data_dict["$skey"]=$sname
done

# 삭제 대상 배열
delete_array=("탐지 로그" "방화벽 로그" "통계 로그")

echo "[데이터 삭제 설정]"
for i in {0..3}; do
    # 디버깅: 각 값 확인
    # echo "Checking: ${data_array[$i]} -> ${data_dict[${data_array[$i]}]}"
    
    case $i in
        0)
            if [ "${data_dict[${data_array[$i]}]}" = "1" ]; then
                echo "++ ${ko_data_array[$i]} : 사용"
            else
                echo "++ ${ko_data_array[$i]} : 미사용"
            fi
            ;;
        1)
            echo "++ ${ko_data_array[$i]} : ${data_dict[${data_array[$i]}]}"
            ;;
        2)
            echo "++ ${ko_data_array[$i]} : ${data_dict[${data_array[$i]}]}"
            ;;
        3)
            echo -n "++ ${ko_data_array[$i]} : "
            # 비트 연산을 사용하여 각 비트가 1인지 확인
            number=$((${data_dict[${data_array[$i]}]}))
            for j in {0..2}; do
                if (( ($number >> $j) & 1 )); then
                    echo -n  "${delete_array[$j]}  "
                fi
            done
            echo
            echo
            ;;
    esac
done

# 기준 날짜 계산 (오늘부터 '기간(일)' 전)
cutoff_date=$(date -d "-${data_dict["DURATION"]} days" +%Y%m%d)

# MongoDB에 연결
mongo --quiet --host localhost --port 23011 --eval "
    var dbNames = db.getMongo().getDBNames();
    var cutoffDate = '$cutoff_date'; 
    var detectionFound = false;  // 탐지 관련 컬렉션이 발견되었는지 여부
    var firewallFound = false;   // 방화벽 관련 컬렉션이 발견되었는지 여부

    // print(typeof cutoffDate);

    dbNames.forEach(function(db_name) {
        // db_yyyymmdd 형식인지 확인
        if (db_name.match(/^db_([0-9]{8})$/)) {
            var db_date = db_name.match(/^db_([0-9]{8})$/)[1];

            // 기준 날짜보다 작은 경우만 확인
            if (db_date < cutoffDate) {
                //  print('Checking database: ' + db_name + ' (Date: ' + db_date + ')');
                
                // 해당 날짜의 데이터베이스로 전환
                var targetDB = db.getSiblingDB(db_name);  // db_name 데이터베이스로 접근 
                         
                // 컬렉션 목록
                var collections = targetDB.getCollectionNames();
 
                // 제대로 조회되었는지 확인(디버깅)
                // printjson(collections);  // collections 배열을 출력해 봄
            
                // 탐지 관련 컬렉션 목록
                var detectionCollections = [
                    'alarm_ca_detect_log', 'alarm_ca_detect_log_abbrev', 'alarm_resource_threshold', 
                    'log_aptx_analysis', 'log_aptx_detect', 'log_aptx_download', 'log_aptx_mrfile_analysis', 
                    'log_aptx_status_sensor', 'log_detect_block', 'log_detect_event', 'log_traffic_total', 
                    'log_traffic_protocol', 'log_traffic_service', 'log_traffic_frame', 'log_traffic_lev_total', 
                    'log_traffic_lev_protocol', 'log_traffic_lev_service_v2', 'log_traffic_lev_frame', 
                    'log_traffic_lev_hack', 'log_resource_sensor', 'log_resource_server', 'log_status_sensor', 
                    'log_mr_event', 'log_mr_reputation', 'log_mr_analysis', 'stat_ar', 'stat_block_method', 
                    'stat_block_period', 'stat_block_reason', 'stat_block_signature', 'stat_block_src', 'stat_detect_dst', 
                    'stat_detect_signature', 'stat_detect_src', 'stat_ipr', 'stat_mr_period', 'stat_trf_frame', 
                    'stat_trf_mpls', 'stat_trf_protocol', 'stat_trf_service', 'stat_trf_total', 'stat_ur'
                ];
                
                // 방화벽 관련 컬렉션 목록
                var firewallCollections = [
                    'log_utm_session', 'log_utm_ips', 'log_utm_ddos', 'log_utm_app', 'log_utm_ipsec', 
                    'log_utm_ipsdump', 'log_utm_userauth', 'log_utm_sslvpn', 'log_utm_audit', 
                    'log_utm_system', 'log_utm_resource_sensor', 'log_utm_traffic_total', 'log_utm_antivirus', 
                    'log_ngfw_alg', 'log_ngfw_as', 'log_ngfw_av', 'log_ngfw_ddos', 'log_ngfw_fw', 
                    'log_ngfw_ips', 'log_ngfw_ipsec', 'log_ngfw_network', 'log_ngfw_ssl', 'log_ngfw_stat_sensor', 
                    'log_ngfw_system', 'log_ngfw_traffic_total'
                ];

                // 탐지 관련 컬렉션을 찾았는지 확인
                detectionFound = detectionCollections.some(function(collection) {
                    return collections.indexOf(collection) !== -1;
                });

                // 방화벽 관련 컬렉션을 찾았는지 확인
                firewallFound = firewallCollections.some(function(collection) {
                    return collections.indexOf(collection) !== -1;
                });

                /* 각 데이터베이스별로 확인해보기(디버깅)
                // 탐지 관련 컬렉션이 하나라도 발견되었으면
                if (detectionFound) {
                    print('True: One or more detection collections found in ' + db_name);
                }
                
                // 방화벽 관련 컬렉션이 하나라도 발견되었으면
                if (firewallFound) {
                    print('True: One or more firewall collections found in ' + db_name);
                }
                */
            }
        }
    });

    // db_stat 데이터베이스로 전환
    var targetDB = db.getSiblingDB('db_stat');  // db_stat 데이터베이스로 접근
 
    // 통계 로그 확인 
    var statisticsFound = ['stat_tuple_detect_min', 'stat_tuple_detect_hour', 'stat_tuple_utm_ips_min', 
                          'stat_tuple_utm_ddos_min', 'stat_tuple_utm_app_min', 'stat_tuple_utm_ips_hour', 
                          'stat_tuple_utm_ddos_hour', 'stat_tuple_utm_app_hour'].some(collection => targetDB.getCollectionNames()
                          .some(c => c.startsWith(collection) && c.match(/_\d{8}$/) && parseInt(c.match(/_(\d{8})$/)[1]) < parseInt(cutoffDate)))

    print('[\'' + cutoffDate + '\'보다 이전 날짜 데이터베이스 확인 결과]')
    // 모든 데이터베이스를 확인한 후, 결과를 한 번만 출력
    if (detectionFound) {
        print('++ 탐지로그 : True(존재)');
    } else {
        print('++ 탐지로그 : False(미존재)');
    }

    if (firewallFound) {
        print('++ 방화벽로그 : True(존재)');
    } else {
        print('++ 방화벽로그 : False(미존재)');
    }

    if (statisticsFound) {
        print('++ 통계로그 : True(존재)');
    } else {
        print('++ 통계로그 : False(미존재)');
    }
"

