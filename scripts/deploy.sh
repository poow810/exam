REPOSITORY=/home/ubuntu/app
cd $REPOSITORY

echo "> Build 파일 복사"
cp $REPOSITORY/zip/*.jar $REPOSITORY/

echo ">현재 구동중인 애플리케이션 pid 확인"

APP_NAME=demo
#JAR_PATH=$REPOSITORY/build/libs/$JAR_NAME

CURRENT_PID=$(pgrep -fl $APP_NAME | grep jar | awk '{print $1}')

echo "현재 구동중인 어플리케이션 pid: $CURRENT_PID"

if [ -z "$CURRENT_PID" ]; then
  echo "> 현재 구동중인 애플리케이션이 없으므로 종료하지 않습니다."
else
  echo "> kill -15 $CURRENT_PID"
  sudo kill -15 $CURRENT_PID
  sleep 5
fi

echo "> $JAR_PATH 배포" #3
# shellcheck disable=SC2012
JAR_NAME=$(ls -tr $REPOSITORY/*.jar | tail -n 1)
echo "> JAR Name: $JAR_NAME"
echo "> $JAR_NAME 에 실행 권한 추가"
chmod +x "$JAR_NAME"
nohup java -jar \
        -Dspring.profiles.active=dev \
        build/libs/"$JAR_NAME" > $REPOSITORY/nohup.out 2>&1 &