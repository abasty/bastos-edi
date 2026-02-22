.PHONY: docker run stop logs clean help

# Variables
IMAGE_NAME := bastos-edi
CONTAINER_NAME := bastos-edi

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
	docker build -t abasty/$(IMAGE_NAME) .
	@echo "✓ Docker image built successfully"

# Run the container with docker compose
start:
	@echo "Starting BASTOS-EDI backend"
	@export USER_ID=$$(id -u) && \
	export GROUP_ID=$$(id -g) && \
	docker compose up -d
	@sleep 1
	@docker compose logs
	@echo "✓ Container started"

# Stop the container
stop:
	@echo "Stopping BASTOS-EDI backend"
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
restart: stop docker start
	@echo ""
	@echo "✓ Build and run complete!"
