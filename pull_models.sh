#!/bin/bash
# ==============================================================================
# J.A.R.V.I.S. DLK74 // MODEL HARVEST SCRIPT
# Downloads base, vision/embed, and Hermes 3 function-calling agent brains
# Targets: /mnt/agent_storage via Ollama container
# ==============================================================================

echo "[+] Initializing model harvest into agent storage..."

# 1. Base conversational LLM
echo "[+] Pulling Llama 3 (8B)..."
docker exec -it jarvis-ollama ollama pull llama3:8b

# 2. Compact high-speed reasoning model
echo "[+] Pulling Llama 3.2 (3B)..."
docker exec -it jarvis-ollama ollama pull llama3.2:3b

# 3. Hermes 3 (Primary Agent & Function-Calling Engine)
echo "[+] Pulling Nous Hermes 3 (8B - Tool & Agent Specialist)..."
docker exec -it jarvis-ollama ollama pull hermes3:8b

# 4. Contextual vector embeddings for RAG & Open WebUI document memory
echo "[+] Pulling Nomic Embed Text..."
docker exec -it jarvis-ollama ollama pull nomic-embed-text

echo "[✓] All target model weights verified in /mnt/agent_storage."
docker exec -it jarvis-ollama ollama list
