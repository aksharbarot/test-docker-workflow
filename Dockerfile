FROM eclipse-temurin:17-jdk AS build
VOLUME /tmp

COPY gradlew .
COPY gradle gradle
COPY settings.gradle .
COPY build.gradle .
COPY gradle.properties .
COPY src src

RUN chmod +x gradlew
RUN ./gradlew clean build -x test --no-daemon

FROM eclipse-temurin:17-jdk
VOLUME /tmp
WORKDIR /app

COPY --from=build build/libs/testapp.jar testapp.jar
COPY ./startup.sh startup.sh
RUN chmod +x startup.sh
RUN wget -O /app/dd-java-agent.jar https://dtdg.co/latest-java-tracer

EXPOSE 8080

CMD ["./startup.sh"]
