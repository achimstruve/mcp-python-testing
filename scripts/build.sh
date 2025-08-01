#!/bin/bash
# Build Docker image for MCP server

# Set script to exit on error
set -e

# Get the directory of the script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

# Change to project directory
cd "$PROJECT_DIR"

# Clean up old images before building
echo "Cleaning up old Docker images..."
docker rmi mcp-server-web:latest 2>/dev/null || true
docker builder prune -f

# Build the Docker image with no cache
echo "Building MCP server Docker image (no cache)..."
docker build --no-cache -t mcp-server-web:latest .

echo "Build complete! Image tagged as mcp-server-web:latest"

# Clean up intermediate images and build cache
echo "Cleaning up intermediate build layers and cache..."
docker image prune -f
docker builder prune -f

# Show disk usage after cleanup
echo "Docker disk usage after cleanup:"
docker system df