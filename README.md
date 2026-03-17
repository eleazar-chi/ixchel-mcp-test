# ixchel-mcp-test

A Spring Boot application built with Java 21 and Docker.

## Requirements

- Java 21
- Maven 3.9+
- Docker & Docker Compose

## Running Locally

```bash
./mvnw spring-boot:run
```

The application will start on [http://localhost:8080](http://localhost:8080).

## Building

```bash
./mvnw package
```

## Running with Docker

Build and start the container:

```bash
docker compose up --build
```

The application will be available at [http://localhost:8080](http://localhost:8080).

## Endpoints

| Method | Path        | Description             |
|--------|-------------|-------------------------|
| GET    | `/`         | Hello World message     |
| GET    | `/actuator` | Spring Boot Actuator    |
