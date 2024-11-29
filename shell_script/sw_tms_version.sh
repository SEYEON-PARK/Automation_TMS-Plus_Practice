# 이 코드는 3rd party 버전을 확인하는 쉘 스크립트입니다.

#!/bin/bash

#절대경로
g_path=$( cd "$(dirname "$0")" ; pwd )
source ${TMS_INSTALL_PATH}/APP/CONFIG/.py-env.sh
#TMS version 출력, 쉘 스크립트

RMS_APACHE_PATH=/home1/apache

function main()
{

    # TMS 버전, 최종 출력이면 INSTALL_PATH 밑에 버전이 있어야 한다. 출력 포맷 변경 (개행 추가)
    #CURRENT_VERSION=$(cat ${INSTALL_PATH}/.version|grep Build|cut -d ":" -f2|sed -e "s/ //g")
    # TMS_VERSION=$(cat ${TMS_INSTALL_PATH}/.version | awk 'BEGIN{ RS = "" ; FS = "\n" } {printf "\t%s\\n\t\t%s\\n\t\t%s", $1, $2, $3}')
    TMS_VERSION=$(cat ${TMS_INSTALL_PATH}/.version)
   
    ## 추가_OpenSSL (ELAS)
    ELAS_SSL_VER=$(${TMS_INSTALL_PATH}/ELAS/bin/elas -O 2>&1)
 
    ## 추가_ OpenSSH 버전
    SSH_VER=$(ssh -V 2>&1)

    ## 추가_SNMP 버전
    SNMP_VER=$(snmpd -v | awk 'NR == 2 {print $3}')

    ## 추가_PHP 버전
    PHP_FILE_PATH="/home1/www/htdocs/versioninfo.php"
    echo "<?php phpinfo(); ?>" > $PHP_FILE_PATH
    sudo chmod 644 $PHP_FILE_PATH
    # sudo systemctl start httpd
    PHP_VER=$(curl -sk https://127.0.0.1:8500/versioninfo.php | awk '/<h1/,/<\/h1>/' | grep -oP '\d+\.\d+\.\d+')
      
    # 시스템 openssl 버전
    SYS_SSL_VER=`openssl version`
    
    # 아파치 openssl 버전
    APACH_SSL_VER=$(${RMS_APACHE_PATH}/bin/openssl version)

    ## 추가_ 아파치 openssl 버전  curl 명령어    
    CURL_RESULT=$(curl -vk https://127.0.0.1:8500 --stderr - | grep -i apache |  sed 's/<//')

    # TMS 데몬 openssl 버전
    #TMS_DAEMON_SSL_VER=`strings ${INSTALL_PATH}/APP/tp_guard | grep "OpenSSL [0-9].[0-9]" | head -1`
    TMS_DAEMON_SSL_VER=${SYS_SSL_VER}
    
    # snmp 라이브러리 버전 (Snmp++ 3.3.11 고정값)
    SNMPPLUS_VER="Snmp++ 3.3.11" 
    
    # crypto 버전 (Sniper Crypto V1.6 4.1 업그레이드)
    CRYPTO_VER="v1.6" 
    
    # SqlCipher 버전
    echo "PRAGMA cipher_version;" > ${g_path}/.cipherver
    echo "" >> ${g_path}/.cipherver
    CIPHER_VER=$($TMS_INSTALL_PATH/www/dbb/sqlcipher < ${g_path}/.cipherver)
    
    # sqlite 버전
    SQLITE3_VER=$(sqlite3 --version | awk '{print $1}' 2>&1)
    
    # node 버전
    NODE_VER=$(node -v)

    # apache 버전 
    APACHE_VER=$(${RMS_APACHE_PATH}/bin/httpd -v | head -1 |awk '{print $3,$4}')

    ## 수정_ python 버전
    python='/usr/bin/python'
    PYTHON_VER=$(python --version 2>&1)  

    ## 수정_ python3 버전 (지금은 3.9)
    #python39=$(which python3.9)
    PYTHON3_VER=$(python3.9 --version 2>&1)

    # mongo 버전
    MONGO_VER=$(mongo --version|awk 'NR==1 {print $4}')

    # elas 버전
    TEMP_ELAS=$(${TMS_INSTALL_PATH}/ELAS/bin/elas -r 2>&1)
    ELAS_VER=$(echo "${TEMP_ELAS}" | sed 's/Last/\t\t\tLast/g')
    # os path
    OS_PATH=$(echo "${PATH}" | sed 's/:/\n\t\t\t/g')

    #파일에 기록
    out_file_name=$1

    touch $out_file_name

    
    echo "OS" >  $out_file_name
    echo "++ Centos             : $(cat /etc/redhat-release)" >>  $out_file_name
    echo "++ Kernel             : $(uname -r)" >>  $out_file_name
    echo >>  $out_file_name
    echo >>  $out_file_name

    echo "Server" >>  $out_file_name 
    echo "++ System OpenSSL     : ${SYS_SSL_VER}" >>  $out_file_name    
    echo "++ TMS Daemon OpenSSL : ${TMS_DAEMON_SSL_VER}" >>  $out_file_name
    echo "++ ELAS OpenSSL       : ${ELAS_SSL_VER}" >> $out_file_name 
    echo "++ OpenSSH Version    : ${SSH_VER}" >> $out_file_name
    echo "++ ELAS Version       : ${ELAS_VER}" >>  $out_file_name 
    echo "++ Rsyslog            : $(rsyslogd -v | head -1 | awk '{print $2}')" >>  $out_file_name
    echo "++ Mongodb            : ${MONGO_VER}" >>  $out_file_name
    echo "++ Sqlite3            : ${SQLITE3_VER}" >>  $out_file_name
    echo "++ SNMP               : ${SNMP_VER}" >>  $out_file_name
    echo "++ Sniper Crypto      : ${CRYPTO_VER}, (fixed)" >>  $out_file_name
    echo "++ SNMP++ Version     : ${SNMPPLUS_VER}, (fixed)" >>  $out_file_name
    echo "++ Python             : ${PYTHON_VER} / ${PYTHON3_VER}" >>  $out_file_name
    echo "++ SQLCipher          : ${CIPHER_VER}" >>  $out_file_name
    echo >>  $out_file_name
    echo >>  $out_file_name


    echo "Web" >>  $out_file_name 
    echo "++ Node.js            : ${NODE_VER}" >>  $out_file_name
    # echo "++ PHP Version        : https:/$(hostname -I | awk '{print $1}'):8500/versioninfo.php" >>  $out_file_name
    echo "++ PHP Version        : ${PHP_VER}" >>  $out_file_name
    echo "++ Apache             : ${APACHE_VER}" >>  $out_file_name
    echo "++ Apache OpenSSL     : ${APACH_SSL_VER}" >>  $out_file_name   
    echo "                       ${CURL_RESULT}" >> $out_file_name
    echo >>  $out_file_name
}

main $@

exit 0
