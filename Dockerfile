FROM maven:3.8.5-openjdk-17 AS build
COPY /src /src
COPY pom.xml /
RUN mvn -f /pom.xml clean package

FROM openjdk:17-jdk-slim
COPY --from=build /target/*.jar app.jar
COPY /.env /
EXPOSE 8083
ENTRYPOINT ["java", "-jar", "app.jar"]
