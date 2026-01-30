# Dockerfile for a Spring Boot app (Maven) to deploy on Google Cloud Run
# Multistage build: compile with Maven, run with a small JRE image.
FROM maven:3.8.8-openjdk-17 AS build
WORKDIR /workspace

# Cache dependencies
COPY pom.xml .
RUN mvn -B dependency:go-offline

# Build application
COPY src ./src
RUN mvn -B package -DskipTests

# Runtime image
FROM eclipse-temurin:17-jre
WORKDIR /app

ARG JAR_FILE=target/*.jar
COPY --from=build /workspace/${JAR_FILE} /app/app.jar

# Cloud Run provides PORT environment variable. Default to 8080 if not set.
EXPOSE 8080
ENV PORT 8080

# Use shell form to expand ${PORT} at runtime so Spring Boot binds to the Cloud Run port.
ENTRYPOINT ["sh","-c","java -jar /app/app.jar --server.port=${PORT}"]