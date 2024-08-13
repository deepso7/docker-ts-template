# Docker Typescript Template

This is a template for a Dockerized Typescript project.

Provides reliable and reproducible development and deployment environments.

## Stack

- Typescript
- Node.js
- Pnpm
- Tsx for development

## Usage

## Development

run:

```bash
docker compose -f docker-compose.dev.yml up
```

^ This will start the container and run the development server, it will also watch for changes in the source code.

if there are any changes in package.json, run:

```bash
docker compose -f docker-compose.dev.yml up --build
```

## Production

To build image, run:

```bash
docker compose build
```

To run the container, run:

```bash
docker-compose up
```

To stop the container, run:

```bash
docker-compose down
```
