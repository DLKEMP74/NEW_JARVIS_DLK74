import os
import datetime
from ollama import Client

# 1. Connect to local Ollama engine running on the micro-PC
client = Client(host='http://localhost:11434')

# 2. Define the path to your persistent Obsidian vault on Drive 3
VAULT_DIR = os.path.expanduser('/mnt/agent_memory/vault')
os.makedirs(VAULT_DIR, exist_ok=True)
DAILY_LOG_FILE = os.path.join(VAULT_DIR, 'task_ledger.md')

def execute_task(task_instruction: str):
    """
    Sends a directive to Hermes 3 and saves the structured result to Obsidian.
    """
    print(f"[+] Task received: {task_instruction}")

    system_prompt = (
        "You are J.A.R.V.I.S. DLK74 Task Orchestrator. "
        "Execute the requested user directive directly. "
        "Return your response cleanly formatted as standard Markdown. "
        "Include a summary of actions taken and any itemized data."
    )

    # Call local Hermes 3 engine
    response = client.chat(
        model='hermes3:8b',
        messages=[
            {'role': 'system', 'content': system_prompt},
            {'role': 'user', 'content': task_instruction}
        ]
    )

    content = response['message']['content']
    timestamp = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")

    # Persist the output directly into your Obsidian Vault as Markdown
    log_entry = f"\n\n## [{timestamp}] Task: {task_instruction}\n\n{content}\n\n---"
    
    with open(DAILY_LOG_FILE, 'a', encoding='utf-8') as f:
        f.write(log_entry)

    print(f"[✓] Task completed and persisted to Obsidian: {DAILY_LOG_FILE}")
    print(content)

if __name__ == "__main__":
    # Test directive for your first run on the server
    directive = "Draft an inventory audit checklist for high-volume reselling items."
    execute_task(directive)
