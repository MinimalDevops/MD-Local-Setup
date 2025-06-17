# MD Local Setup

This repository documents how to configure tools used for development and automation. Each setup step is provided via shell scripts so that it can be replicated easily.

## Requirements

The core requirement for all tooling is [Homebrew](https://brew.sh/). All other setup scripts expect `brew` to be available on your system.

### Installing Homebrew

Run the helper script from the `scripts` directory to install Homebrew. It will perform a check and skip installation if `brew` is already installed.

```bash
bash scripts/install_brew.sh
```

After Homebrew is installed you can add additional setup scripts for other tools in this repository.

## Repository Structure

- `scripts/` – collection of shell scripts used to install and configure tools. Currently only the Homebrew installation script is provided.

Further instructions will be added as additional tools are incorporated.
