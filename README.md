# MD Local Setup

This repository documents how to configure tools used for development and automation. Each setup step is provided via shell scripts so that it can be replicated easily.

## Requirements

The core requirement for all tooling is [Homebrew](https://brew.sh/). All other setup scripts expect `brew` to be available on your system.

### Installing Homebrew

Run the helper script from the `scripts` directory to install Homebrew. On macOS the script also installs the Xcode command line tools if they are missing and updates your `.zprofile` so `brew` is available in new shells. It will perform a check and skip installation if `brew` is already installed.

```bash
bash scripts/install_brew.sh
```

After Homebrew is installed you can add additional setup scripts for other tools in this repository. The repository now includes a helper to configure `zsh` with common plugins and utilities.

### Configuring zsh

Run the zsh setup script to install Oh My Zsh, useful plugins and command line utilities. Besides git, fzf, bat and direnv it also installs Warp, Ollama and Msty, configures the Powerlevel10k theme and adds handy aliases:

```bash
bash scripts/setup_zsh.sh
```

## Repository Structure

- `scripts/` – collection of shell scripts used to install and configure tools. Includes helpers for installing Homebrew and configuring zsh.

Further instructions will be added as additional tools are incorporated.

## Additional Tools

### Grafana

Install and start Grafana using Homebrew:

```bash
brew install grafana
brew services start grafana
```

### DBeaver

```bash
brew install --cask dbeaver-community
```

### PostgreSQL

```bash
brew install postgresql@17
```

### Ngrok

```bash
brew install ngrok
```

After installing, obtain your auth token from Ngrok and configure it before use.

### n8n and Ngrok

Expose port `5678` with Ngrok and store the resulting HTTPS URL in an `.env` file under the `n8n` folder:

```env
WEBHOOK_URL=https://acd.ngrok-free.app
```

#### Local installation

Install n8n globally and start it so that it can access files on your machine:

```bash
npm install -g n8n
n8n start
```

#### Docker (optional)

Create a persistent volume and start the container interactively:

```bash
docker volume create n8n_data
docker run -it --rm \
  --name n8n \
  -p 5678:5678 \
  -v n8n_data:/home/node/.n8n \
  -e WEBHOOK_URL=https://acd.ngrok-free.app \
  docker.n8n.io/n8nio/n8n
```

To run n8n in the background:

```bash
docker run -d \
  --name n8n \
  -p 5678:5678 \
  -v n8n_data:/home/node/.n8n \
  -e WEBHOOK_URL=https://acd.ngrok-free.app \
  docker.n8n.io/n8nio/n8n
```

### npm and uv

Use npm or [uv](https://github.com/astral-sh/uv) for package installation. Both provide fast dependency management for JavaScript and Python environments.

### ttl.sh

[`ttl.sh`](https://ttl.sh) is a lightweight container registry used for local development images.

### Portainer

Portainer offers a graphical dashboard to manage Docker containers and images.

### Sterling PDF

Sterling PDF converts and merges documents. Keep it available for local testing.

### rtrvr.ai

`rtrvr.ai` can run browser automation against your Git repositories.

### btop

Install the modern system monitor with Homebrew:

```bash
brew install btop
```

### GitHub CLI

Use GitHub's `gh` CLI to create pull requests from the terminal:

```bash
brew install gh
```

### PNPM

An alternative JavaScript package manager:

```bash
brew install pnpm
```

### PM2

PM2 keeps local services running in the background:

```bash
npm install -g pm2
```

### Hoppscotch

Hoppscotch provides a simple interface for testing HTTP APIs.

### Tailscale

Tailscale connects locally hosted apps to your phone or other devices:

```bash
brew install --cask tailscale
```

### Docker Compose

Docker Compose works with Docker running under Colima for container orchestration.

### Uptime Kuma

Monitor endpoints and send errors to Telegram:

```bash
brew install uptime-kuma
```

### Homepage

Homepage manages links and includes custom code for triggering jobs.

