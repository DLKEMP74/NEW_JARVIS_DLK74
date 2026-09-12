#!/usr/bin/env bash
set -e

echo "=== Pulling Foundational AI Models into Drive 2 ==="

# Wait until Ollama engine container is healthy and responding
echo "[*] Checking Ollama engine status..."
until docker exec jarvis-engine ollama list > /dev/null 2>&1; do
    echo "Waiting for jarvis-engine container to initialize..."
    sleep 3
done

# 1. Primary Reasoning & General Instruction Model (~4.9 GB)
echo "[+] Pulling Llama 3 (8B) instruction model..."
docker exec -it jarvis-engine ollama pull llama3:8b

# 2. Fast Low-Latency / Agent Model (~2.0 GB)
echo "[+] Pulling Llama 3.2 (3B) lightweight model..."
docker exec -it jarvis-engine ollama pull llama3.2:3b

# 3. Vector Embedding Model for Local Memory & RAG (~274 MB)
echo "[+] Pulling Nomic Embed Text model..."
docker exec -it jarvis-engine ollama pull nomic-embed-text

echo "=== All Foundation Models Downloaded Successfully ==="
docker exec jarvis-engine ollama list
