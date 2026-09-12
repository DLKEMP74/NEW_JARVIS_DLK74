#!/usr/bin/env bash
set -e

echo "=== Initializing NEW_JARVIS_DLK74 AI Environment ==="

# 1. Create target directories across isolated storage drives
echo "[+] Creating persistent storage directories..."
sudo mkdir -p /mnt/agent_storage/models
sudo mkdir -p /mnt/agent_memory/webui_data

# 2. Assign current user permissions to avoid Docker write locks
echo "[+] Setting folder permissions..."
sudo chown -R $USER:$USER /mnt/agent_storage /mnt/agent_memory
chmod -R 775 /mnt/agent_storage /mnt/agent_memory

# 3. Create local .env from example template if not present
if [ ! -f .env ]; then
  echo "[+] Generating .env configuration file..."
  cp .env.example .env
fi

# 4. Launch Docker Compose stack in the background
echo "[+] Deploying engine and UI containers..."
docker compose up -d

echo "=== Deployment Complete ==="
echo "Access Open WebUI at: http://localhost:3000"
echo "Ollama API running at: http://localhost:11434"
