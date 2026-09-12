# NEW_JARVIS_DLK74 Engine Architecture

Autonomous self-hosted AI engine with isolated 3-drive storage persistence.

---

## Hardware Storage Layout

* **Drive 1 (M.2 NVMe 256GB - `/`):** Ubuntu Server 24.04 OS & Base System
* **Drive 2 (M.2 NVMe 1TB - `/mnt/agent_storage`):** Ollama LLM Binaries & Engine Cache
* **Drive 3 (2.5" SATA SSD 1TB - `/mnt/agent_memory`):** Vector Memory & SQLite Datasets

---

## Day 1 Deployment Commands

Run these four commands on the headless server to initialize the entire platform:

```bash
# 1. Clone repository
git clone [https://github.com/DLKEMP74/NEW_JARVIS_DLK74.git](https://github.com/DLKEMP74/NEW_JARVIS_DLK74.git)
cd NEW_JARVIS_DLK74

# 2. Build directories, set permissions, and launch Docker
bash setup.sh

# 3. Pull foundational models into Drive 2
bash pull_models.sh
