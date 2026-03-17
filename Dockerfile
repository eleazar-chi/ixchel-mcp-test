# Build stage
FROM eclipse-temurin:21-jdk-alpine AS builder

# Actualizar paquetes del sistema para corregir vulnerabilidades
RUN apk update && apk upgrade --no-cache

WORKDIR /app
COPY .mvn/ .mvn/
COPY mvnw pom.xml ./
RUN ./mvnw dependency:go-offline
COPY src ./src
RUN ./mvnw package -DskipTests

# Runtime stage
FROM eclipse-temurin:21-jre-alpine

# Actualizar paquetes del sistema para corregir vulnerabilidades
# Esto resuelve CVEs conocidos en librerías del sistema base
RUN apk update && apk upgrade --no-cache

# Crear usuario no-root para mayor seguridad
RUN addgroup -g 1000 appuser && \
    adduser -D -u 1000 -G appuser appuser

WORKDIR /app

# Copiar el JAR desde el build stage
COPY --from=builder /app/target/*.jar app.jar

# Cambiar ownership del archivo al usuario no-root
RUN chown -R appuser:appuser /app

# Cambiar a usuario no-root
USER appuser

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]