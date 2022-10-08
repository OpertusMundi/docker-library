# vim: set syntax=dockerfile:

FROM maven:3.8.6-eclipse-temurin-17-alpine

WORKDIR /app

COPY pom.xml /app/
RUN mvn -B dependency:resolve-plugins dependency:resolve
RUN rm pom.xml
