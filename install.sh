#!/bin/bash
set -e

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
CYAN='\033[0;36m'; BOLD='\033[1m'; DIM='\033[2m'; RESET='\033[0m'

echo -e "${CYAN}${BOLD}"
cat << 'EOF'
  ██████╗ ███████╗██╗   ██╗    ████████╗ ██████╗  ██████╗ ██╗  ██╗██╗████████╗
  ██╔══██╗██╔════╝██║   ██║    ╚══██╔══╝██╔═══██╗██╔═══██╗██║ ██╔╝██║╚══██╔══╝
  ██║  ██║█████╗  ██║   ██║       ██║   ██║   ██║██║   ██║█████╔╝ ██║   ██║
  ██║  ██║██╔══╝  ╚██╗ ██╔╝       ██║   ██║   ██║██║   ██║██╔═██╗ ██║   ██║
  ██████╔╝███████╗ ╚████╔╝        ██║   ╚██████╔╝╚██████╔╝██║  ██╗██║   ██║
  ╚═════╝ ╚══════╝  ╚═══╝         ╚═╝    ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚═╝   ╚═╝
EOF
echo -e "${RESET}"
echo -e "  ${DIM}  The MVP Guy Dev Toolkit — themvpguy.vercel.app${RESET}"
echo ""

if [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "cygwin" ]] || [[ -n "$WINDIR" ]]; then
  OS="windows"
  INSTALL_DIR="$HOME/bin"
  mkdir -p "$INSTALL_DIR"
  echo -e "  ${DIM}  Windows (Git Bash) detected${RESET}"
elif [[ "$OSTYPE" == "darwin"* ]]; then
  OS="macos"
  if [ -w "/usr/local/bin" ]; then
    INSTALL_DIR="/usr/local/bin"
  else
    INSTALL_DIR="$HOME/bin"
    mkdir -p "$INSTALL_DIR"
  fi
  echo -e "  ${DIM}  macOS detected${RESET}"
else
  OS="linux"
  if [ -w "/usr/local/bin" ]; then
    INSTALL_DIR="/usr/local/bin"
  else
    INSTALL_DIR="$HOME/bin"
    mkdir -p "$INSTALL_DIR"
  fi
  echo -e "  ${DIM}  Linux detected${RESET}"
fi

cp dev-toolkit "$INSTALL_DIR/dev-toolkit"
chmod +x "$INSTALL_DIR/dev-toolkit"

if [ "$OS" = "windows" ]; then
  grep -q "$HOME/bin" "$HOME/.bashrc" 2>/dev/null || \
    echo "export PATH=\"\$HOME/bin:\$PATH\"" >> "$HOME/.bashrc"
fi

echo ""
echo -e "  ${GREEN}${BOLD}✓ dev-toolkit installed${RESET}"
echo ""
echo -e "  ${CYAN}  Run: ${BOLD}dev-toolkit${RESET}"
echo ""

# Check if we're interactive before prompting
if [ -t 0 ]; then
  echo -e "  ${YELLOW}  Install other MVP Guy tools?${RESET}"
  echo -e "  ${DIM}  mgit, git-rescue, env-guard, devmon, cursor-reset${RESET}"
  echo ""
  echo -ne "  Install all now? (y/n): "
  read -r INSTALL_ALL
  if [[ "$INSTALL_ALL" =~ ^[yY]$ ]]; then
    echo ""
    for repo in mgit git-rescue env-guard devmon cursor-reset; do
      echo -e "  ${DIM}→ Installing $repo...${RESET}"
      if command -v git &>/dev/null; then
        TMPDIR=$(mktemp -d)
        git clone --quiet "https://github.com/MuhammadTanveerAbbas/$repo.git" "$TMPDIR/$repo" 2>/dev/null
        cd "$TMPDIR/$repo"
        chmod +x install.sh 2>/dev/null
        bash install.sh 2>/dev/null && echo -e "  ${GREEN}✓ $repo installed${RESET}" || echo -e "  ${YELLOW}  $repo — manual install needed${RESET}"
        cd - > /dev/null
        rm -rf "$TMPDIR"
      fi
    done
  fi
fi

echo ""
echo -e "  ${DIM}  Built by The MVP Guy — themvpguy.vercel.app${RESET}"
echo ""
