# Build stage: compile the Spring Boot jar using Maven
FROM maven:3.9.1-eclipse-temurin-17 AS build
WORKDIR /workspace

# Copy only what is needed to leverage Docker layer cache
COPY pom.xml .
COPY src ./src

# Build the executable jar (skip tests for faster builds; remove -DskipTests if you want tests)
RUN mvn -B -DskipTests package

# Runtime stage: minimal distroless Java image for Cloud Run
FROM gcr.io/distroless/java17-debian11
WORKDIR /app

# Copy the built jar from the build stage
COPY --from=build /workspace/target/*.jar app.jar

# Cloud Run provides PORT via env; Spring Boot defaults to 8080, so expose it
ENV PORT=8080
EXPOSE 8080

# Start the Spring Boot app
ENTRYPOINT ["java", "-jar", "/app/app.jar"]