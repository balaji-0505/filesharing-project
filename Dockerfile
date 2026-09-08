FROM maven:3.9-eclipse-temurin-21 AS build
WORKDIR /app
COPY filesharing-be/filesystem-be/pom.xml ./pom.xml
COPY filesharing-be/filesystem-be/src ./src
RUN mvn clean package -DskipTests

FROM eclipse-temurin:21-jre
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
RUN mkdir -p /app/storage
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
