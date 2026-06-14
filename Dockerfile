# На первом этапе собираем приложение через образ node
FROM node:22 AS node_builder
# Мотнируем папку с кодом в контейнер в папку /app
ADD . /app
# Заходим в контейнере в папку /app/mobile и запускаем команды оттуда
WORKDIR /app/mobile
RUN npm install
RUN npm install @capacitor/core @capacitor/cli @capacitor/android
RUN npx cap init "Конвертер даты" "com.qa.dateconverter" --web-dir=/app/mobile/www
RUN npx cap add android
RUN npx cap copy android
RUN npx cap sync android

# На втором этапе собираем apk-файл через образ docker gradle
FROM mobiledevops/android-sdk-image:34.0.0
# Копируем кодовую базу из первого этапа (node:22)
COPY --from=node_builder /app /app
# Меняем пользователя на root
USER root
# Идем в директорию, откуда будем собирать apk-файл
WORKDIR /app/mobile/android
CMD ["./gradlew", "clean", "assembleDebug"]
