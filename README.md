# Конвертер 

### Некоммерческое мобильное приложение для конвертации даты в день недели. 

Документация (чек-лист, тест-кейсы, баг-репорты, вопросы/предложения)
https://docs.google.com/spreadsheets/d/1mxyG0KNBWwFeX0Mi5S51KunRH2EJhOPkpMJUFGdTlg8/edit?usp=sharing  


#### Сборка apk-файла через docker
##### \# Клонировать репозиторий 
git clone https://github.com/VoFkAAA/Converter-Project-Mobile-App
cd Converter-Project-Mobile-App
##### \# Задаем имя для контейнера
DOCKER_APP_NAME=mobile_converter 
##### \# Собираем докер образ из директории, где располагается Dockerfile (из корня репозитория)
##### \# --network host нужен для того, чтобы докер не создавал отдельную сеть, а пользовался интерфейсом хоста - скачивание проиходит быстрее, если docker запускается через wsl
docker build -t $DOCKER_APP_NAME . --network host 
##### \# Запускаем сборку приложения внутри контейнера, дожидаемся BUILD SUCCESSFULL
docker run $DOCKER_APP_NAME 
##### \# После сборки приложения контейнер вышел, он не активен, но мы можем найти его и скачать файл, пока контейнер не удален
DOCKER_APP_ID=$(docker ps -a | grep $DOCKER_APP_NAME | awk '{print $1}' | head -n 1)
##### \# Скачиваем apk-файл из контейнера
docker cp $DOCKER_APP_ID:/app/mobile/android/app/build/outputs/apk/debug/app-debug.apk .


