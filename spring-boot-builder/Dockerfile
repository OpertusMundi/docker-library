# vim: set syntax=dockerfile:

FROM maven:3.6.3-openjdk-8

WORKDIR /app

COPY pom.xml /app/
RUN mvn -B dependency:resolve-plugins dependency:resolve
