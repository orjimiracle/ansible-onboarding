<<<<<<< HEAD
This repository contains a **fully-configured Ansible onboarding environment**, including isolated Python environment, Ansible, linters, pre-commit hooks, VS Code workspace, and SSH configuration.
=======
Perfect! Let’s turn the `README.md` instructions into **copy-paste ready commands** using `cat >> filename` so anyone can just run them instead of manually creating files. I’ll keep it **beautiful and structured** for readability.

Here’s the updated version:

---

````markdown
# 🚀 Ansible Onboarding Setup (Copy-Paste Ready)

This repo contains the **full setup for Ansible onboarding**, including isolated Python environment, Ansible, linting tools, pre-commit hooks, and SSH configuration.
>>>>>>> 96b2fef (Second Commit)

It ensures **clean, reproducible, and team-friendly DevOps practices**.

---

## ⚙️ Prerequisites

<<<<<<< HEAD
- Ubuntu 22.04 LTS (WSL on Windows 10/11 optional)
- Admin privileges (for installing packages)
- Internet connection
- VS Code installed

---

## 🐧 Step 0: Update System
=======
- Windows 10/11
- Admin access for installing WSL
- Internet connection
- VS Code installed

---

## 🐧 Step 0: Install WSL & Ubuntu

Open PowerShell as Administrator:

```bash
wsl --install
wsl --install -d Ubuntu-22.04
````

After installation, update Ubuntu:
>>>>>>> 96b2fef (Second Commit)

```bash
sudo apt update && sudo apt upgrade -y
```

---

<<<<<<< HEAD
## 🐍 Step 1: Install Python & Git
=======
## 🖥 Step 1: Install VS Code & Extensions

Install VS Code from [here](https://code.visualstudio.com/).

Then install extensions:

```text
Remote - WSL
Python
YAML
Ansible
```

Open VS Code in WSL:

```text
Ctrl+Shift+P → Remote-WSL: New Window
```

---

## 📊 Step 2: Check Versions

```bash
lsb_release -a       # Ubuntu version
python3 --version    # Python version
pip3 --version       # Pip version
git --version        # Git version
```

---

## 🐍 Step 3: Install Python & Git
>>>>>>> 96b2fef (Second Commit)

```bash
sudo apt install python3 python3-venv python3-pip git -y
```

---

<<<<<<< HEAD
## 📂 Step 2: Create Project Directory

```bash
mkdir ~/ansible-onboarding-clean
cd ~/ansible-onboarding-clean
=======
## 📂 Step 4: Create Project Directory

```bash
mkdir ~/ansible-onboarding
cd ~/ansible-onboarding
>>>>>>> 96b2fef (Second Commit)
```

---

<<<<<<< HEAD
## 🛠 Step 3: Set Up Isolated Python Environment
=======
## 🛠 Step 5: Set Up Isolated Python Environment
>>>>>>> 96b2fef (Second Commit)

```bash
python3 -m venv .venv
source .venv/bin/activate
```

---

<<<<<<< HEAD
## 📦 Step 4: Install Ansible & Tools

```bash
pip install --upgrade pip
pip install ansible ansible-lint yamllint pre-commit
=======
## 📦 Step 6: Install Ansible & Tools

```bash
pip install --upgrade pip
pip install ansible ansible-lint pre-commit
>>>>>>> 96b2fef (Second Commit)
```

---

<<<<<<< HEAD
## 🔧 Step 5: Configure Git
=======
## 🔧 Step 7: Configure Git
>>>>>>> 96b2fef (Second Commit)

```bash
git init
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
<<<<<<< HEAD
git config --global init.defaultBranch main
```

(Optional: enable commit signing using GPG or SSH)

---

## ⚡ Step 6: Configure Ansible (`ansible.cfg`)
=======
```

---

## ⚡ Step 8: Configure Ansible (`ansible.cfg`)
>>>>>>> 96b2fef (Second Commit)

```bash
cat >> ansible.cfg << 'EOF'
[defaults]
<<<<<<< HEAD
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
=======
inventory = ./hosts
host_key_checking = False
retry_files_enabled = False
>>>>>>> 96b2fef (Second Commit)
EOF
```

---

<<<<<<< HEAD
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
=======
## 🔑 Step 9: Configure SSH

Check existing key:

```bash
ls ~/.ssh/id_rsa
```

Generate key if missing:

```bash
ssh-keygen -t rsa -b 4096 -C "your.email@example.com"
```

Start SSH agent and add key:

```bash
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
ssh-add -l  # should display key
>>>>>>> 96b2fef (Second Commit)
```

---

<<<<<<< HEAD
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
=======
## 🧹 Step 10: Set Up Pre-commit Hooks
>>>>>>> 96b2fef (Second Commit)

```bash
cat >> .pre-commit-config.yaml << 'EOF'
repos:
<<<<<<< HEAD
  - repo: https://github.com/adrienverge/yamllint
    rev: v1.35.1
    hooks:
      - id: yamllint
  - repo: https://github.com/ansible/ansible-lint
    rev: v24.6.1
    hooks:
      - id: ansible-lint
EOF

=======
  - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v4.5.0
    hooks:
      - id: trailing-whitespace
      - id: end-of-file-fixer
EOF
```

Install hooks:

```bash
>>>>>>> 96b2fef (Second Commit)
pre-commit install
pre-commit run --all-files
```

---

<<<<<<< HEAD
## 🧪 Step 10: Test Your Setup
=======
## 🖌 Step 11: Configure VS Code Workspace (Optional)

```bash
mkdir -p .vscode
cat >> .vscode/settings.json << 'EOF'
{
  "python.pythonPath": ".venv/bin/python",
  "editor.formatOnSave": true
}
EOF
```

---

## 🧪 Step 12: Test Your Setup
>>>>>>> 96b2fef (Second Commit)

```bash
ansible --version
ansible-lint --version
<<<<<<< HEAD
yamllint --version
=======
>>>>>>> 96b2fef (Second Commit)
pre-commit run --all-files
ssh-add -l
```

<<<<<<< HEAD
> All commands should run **without errors**.

---

## ✅ Step 11: Prepare Repo for Submission
=======
> 🎯 All commands should work without errors.

---

## 📁 Step 13: Prepare Repo for Submission
>>>>>>> 96b2fef (Second Commit)

```bash
tree -a -L 2
pip freeze > requirements.txt
```

Expected structure:

```text
.
<<<<<<< HEAD
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
=======
├── .git
├── .pre-commit-config.yaml
├── .venv
└── requirements.txt
>>>>>>> 96b2fef (Second Commit)
```

---

<<<<<<< HEAD
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
=======
## 📸 Step 14: Take Screenshots

* `ansible --version`
* VS Code extensions panel
* Pre-commit installation output
* `ssh-add -l` output
* Repo tree structure

---

## 💡 Step 15: Notes & Best Practices

* **Team-friendly setup:** isolated `.venv`, pre-commit hooks, VS Code workspace.
* **Pitfalls avoided:** no global pip installs, SSH agent avoids repeated password prompts.
* **Why this matters in DevOps:**

  * Keeps local system clean
  * Ensures reproducibility
  * Makes automation reliable and consistent

---

✅ **With this setup, your machine is ready for Ansible automation, team-friendly collaboration, and submission!**

```
>>>>>>> 96b2fef (Second Commit)

---
