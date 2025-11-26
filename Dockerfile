# ========================================
# ETAPA 1: BUILD (Compilación)
# ========================================
FROM alpine:latest as build

# Actualizar e instalar OpenJDK 17 y dos2unix
# Se agrega 'dos2unix' para corregir formatos de archivo de Windows
RUN apk update && apk add openjdk17 dos2unix

# Copiar TODO el código fuente
COPY . .

# 1. Corregir saltos de línea (CRLF -> LF) para evitar error "not found"
RUN dos2unix gradlew

# 2. Dar permisos de ejecución
RUN chmod +x ./gradlew

# Ejecutar Gradle
RUN ./gradlew bootJar --no-daemon

# ========================================
# ETAPA 2: RUNTIME (Ejecución)
# ========================================
FROM eclipse-temurin:17-jre-alpine

EXPOSE 8080

# Copiar el JAR generado
COPY --from=build ./build/libs/*.jar ./app.jar

ENTRYPOINT ["java", "-jar", "app.jar"]
