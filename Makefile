.PHONY: docker run stop logs clean help

# Variables
IMAGE_NAME := bastos-edi
CONTAINER_NAME := bastos-edi
COMPOSE_FILE := docker compose.yml

help:
	@echo "BASTOS-EDI Makefile Targets"
	@echo "==========================="
	@echo ""
	@echo "  docker       Build the Docker image"
	@echo "  run          Start the container with docker compose"
	@echo "  stop         Stop the running container"
	@echo "  logs         View container logs"
	@echo "  logs-f       Follow container logs (real-time)"
	@echo "  clean        Stop container and remove volumes"
	@echo "  rebuild      Build image and run container"
	@echo "  help         Show this help message"
	@echo ""

# Build the Docker image
docker:
	@echo "Building Docker image: $(IMAGE_NAME)"
	docker build -t $(IMAGE_NAME) .
	@echo "✓ Docker image built successfully"

# Run the container with docker compose
run:
	@echo "Starting container with docker compose..."
	@docker compose up -d
	@sleep 1
	@docker compose logs
# 	@echo "✓ Container started successfully"
# 	@echo ""
# 	@echo "Access the BASTOS-EDI SPA at: http://localhost:9000"
# 	@echo "FTP access: ftp://localhost:2121 (anonymous login)"

# Stop the container
stop:
	@echo "Stopping container..."
	@docker compose down -t1 --remove-orphans
	@echo "✓ Container stopped"

# View logs
logs:
	docker compose logs

# Follow logs (real-time)
logs-f:
	docker compose logs -f

# Clean up (stop and remove volumes)
clean:
	@echo "Cleaning up containers and volumes..."
	docker compose down -v
	@echo "✓ Cleanup complete"

# Build and run
rebuild: docker run
	@echo ""
	@echo "✓ Build and run complete!"
