# Multi-stage Dockerfile for building a Gradle Spring Boot app and running on Google Cloud Run

# Build stage: use official Gradle image with JDK
FROM eclipse-temurin:21-jdk AS builder
WORKDIR /workspace

# Copy wrapper and basic build files first to leverage Docker cache for dependencies
COPY gradlew .
COPY gradle/ gradle/
COPY settings.gradle settings.gradle.kts* build.gradle build.gradle.kts* ./
RUN chmod +x gradlew || true

# Download dependencies (cache)
RUN ./gradlew --no-daemon assemble --no-parallel || true

# Copy the rest of the project and build the bootable jar
COPY . .
RUN ./gradlew --no-daemon bootJar -x test

# Runtime stage: use a small distroless Java runtime suitable for Cloud Run
FROM gcr.io/distroless/java21-debian12:nonroot
ENV PORT 8080
EXPOSE 8080

# Copy the fat jar produced by the build stage (rename to a stable name)
COPY --from=builder /workspace/build/libs/*.jar /app.jar

# Cloud Run uses the PORT env; Spring Boot will honor it via server.port env var automatically
ENTRYPOINT ["java", "-jar", "/app.jar"]