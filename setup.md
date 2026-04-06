This repository contains a **fully-configured Ansible onboarding environment**, including isolated Python environment, Ansible, linters, pre-commit hooks, VS Code workspace, and SSH configuration.  

It ensures **clean, reproducible, and team-friendly DevOps practices**.

---

## ⚙️ Prerequisites

- Ubuntu 22.04 LTS (WSL on Windows 10/11 optional)  
- Admin privileges (for installing packages)  
- Internet connection  
- VS Code installed  

---

## 🐧 Step 0: Update System

```bash
sudo apt update && sudo apt upgrade -y
```

---

## 🐍 Step 1: Install Python & Git

```bash
sudo apt install python3 python3-venv python3-pip git -y
```

---

## 📂 Step 2: Create Project Directory

```bash
mkdir ~/ansible-onboarding-clean
cd ~/ansible-onboarding-clean
```

---

## 🛠 Step 3: Set Up Isolated Python Environment

```bash
python3 -m venv .venv
source .venv/bin/activate
```

---

## 📦 Step 4: Install Ansible & Tools

```bash
pip install --upgrade pip
pip install ansible ansible-lint yamllint pre-commit
```

---

## 🔧 Step 5: Configure Git

```bash
git init
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
git config --global init.defaultBranch main
```

(Optional: enable commit signing using GPG or SSH)

---

## ⚡ Step 6: Configure Ansible (`ansible.cfg`)

```bash
cat >> ansible.cfg << 'EOF'
[defaults]
inventory            = inventories/
roles_path           = roles:./.ansible/roles
host_key_checking    = True
retry_files_enabled  = False
interpreter_python   = auto_silent
forks                = 10
timeout              = 30
stdout_callback      = yaml
bin_ansible_callbacks = True

[ssh_connection]
pipelining = True
ssh_args   = -o ControlMaster=auto -o ControlPersist=60s
EOF
```

---

## 🔑 Step 7: Configure SSH

Generate key (if missing):

```bash
ssh-keygen -t ed25519 -C "you@company" -N "" -f ~/.ssh/id_ed25519
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
ssh-add -l
```

Create SSH config:

```bash
cat >> ~/.ssh/config << 'EOF'
Host *
  ServerAliveInterval 30
  ServerAliveCountMax 4
  AddKeysToAgent yes
  IdentityFile ~/.ssh/id_ed25519
  StrictHostKeyChecking ask
EOF
```

---

## 🖌 Step 8: VS Code Workspace & EditorConfig

Create VS Code settings:

```bash
mkdir -p .vscode
cat >> .vscode/settings.json << 'EOF'
{
  "python.defaultInterpreterPath": "${workspaceFolder}/.venv/bin/python",
  "ansible.python.interpreterPath": "${workspaceFolder}/.venv/bin/python",
  "ansibleLint.enabled": true,
  "yaml.validate": true,
  "files.trimTrailingWhitespace": true,
  "editor.formatOnSave": true
}
EOF
```

Create EditorConfig:

```bash
cat >> .editorconfig << 'EOF'
root = true
[*]
charset = utf-8
end_of_line = lf
indent_style = space
indent_size = 2
insert_final_newline = true
trim_trailing_whitespace = true
EOF
```

---

## 🧹 Step 9: Set Up Pre-commit Hooks

```bash
cat >> .pre-commit-config.yaml << 'EOF'
repos:
  - repo: https://github.com/adrienverge/yamllint
    rev: v1.35.1
    hooks:
      - id: yamllint
  - repo: https://github.com/ansible/ansible-lint
    rev: v24.6.1
    hooks:
      - id: ansible-lint
EOF

pre-commit install
pre-commit run --all-files
```

---

## 🧪 Step 10: Test Your Setup

```bash
ansible --version
ansible-lint --version
yamllint --version
pre-commit run --all-files
ssh-add -l
```

> All commands should run **without errors**.

---

## ✅ Step 11: Prepare Repo for Submission

```bash
tree -a -L 2
pip freeze > requirements.txt
```

Expected structure:

```text
.
├── .editorconfig
├── .git
├── .gitignore
├── .pre-commit-config.yaml
├── .vscode/settings.json
├── README.md
├── ansible.cfg
├── inventory.ini
├── requirements.txt
├── terraform-azure-vms/
└── .venv/  (local, excluded from Git)
```

---

## 📝 Notes

- Keep **.venv/** local, do not commit to Git.  
- SSH private keys should **never** be pushed to the repository.  
- This setup matches **enterprise team standards** for Ansible development.  
- The pre-commit hooks will ensure **clean YAML and Ansible playbooks** once you add them.  

---

## 📌 “New Machine? Do This” Checklist

1. Install Ubuntu / WSL & update system  
2. Install Python 3.10+, Git, VS Code  
3. Clone this repository  
4. Create & activate `.venv`  
5. Install dependencies (`pip install -r requirements.txt`)  
6. Configure Git (name, email, default branch)  
7. Set up SSH keys & agent  
8. Create `.vscode/settings.json` & `.editorconfig`  
9. Install pre-commit & run hooks  
10. Test Ansible, linters, and SSH agent  
11. Verify repo structure with `tree`  
12. Start developing playbooks in `inventories/` and `roles/`  

---
