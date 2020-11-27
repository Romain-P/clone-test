FROM openjdk:8-jdk-alpine as builder
WORKDIR /srv/builder
COPY ./gradle ./gradle
COPY ./gradlew ./
RUN start gradlew.bat
COPY ./ ./
RUN start gradlew.bat build

FROM openjdk:8-jre-alpine as launcher
ENV DOCKER 1
WORKDIR /srv/launcher
COPY --from=builder /srv/builder/build/libs/*.jar ./template.jar
CMD ["java", "-jar", "template.jar"]