#!/bin/bash
set -e

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
CYAN='\033[0;36m'; BOLD='\033[1m'; DIM='\033[2m'; RESET='\033[0m'

echo ""
echo -e "  ${RED}${BOLD}  Uninstall dev-toolkit${RESET}"
echo ""

if [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "cygwin" ]] || [[ -n "$WINDIR" ]]; then
  INSTALL_DIR="$HOME/bin"
else
  INSTALL_DIR="/usr/local/bin"
fi

if [ -f "$INSTALL_DIR/dev-toolkit" ]; then
  rm -f "$INSTALL_DIR/dev-toolkit"
  echo -e "  ${GREEN}✓ Removed $INSTALL_DIR/dev-toolkit${RESET}"
else
  echo -e "  ${YELLOW}  dev-toolkit not found in $INSTALL_DIR${RESET}"
fi

echo -ne "\n  ${YELLOW}  Remove data directory (~/.dev-toolkit-data)? (y/n): ${RESET}"
read -r REMOVE_DATA
if [[ "$REMOVE_DATA" =~ ^[yY]$ ]]; then
  rm -rf "$HOME/.dev-toolkit-data" 2>/dev/null
  echo -e "  ${GREEN}✓ Data directory removed${RESET}"
else
  echo -e "  ${CYAN}  Data directory kept at $HOME/.dev-toolkit-data${RESET}"
fi

echo ""
echo -e "  ${DIM}  Built by The MVP Guy — themvpguy.vercel.app${RESET}"
echo ""
