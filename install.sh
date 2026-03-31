#!/usr/bin/env bash
set -euo pipefail

# ─── Colors ───────────────────────────────────────────────────────────────────
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; NC='\033[0m'
info()    { echo -e "${CYAN}[open-claude]${NC} $*"; }
success() { echo -e "${GREEN}[✓]${NC} $*"; }
warn()    { echo -e "${YELLOW}[!]${NC} $*"; }
die()     { echo -e "${RED}[✗]${NC} $*" >&2; exit 1; }

# ─── Config ───────────────────────────────────────────────────────────────────
REPO="https://github.com/THtianhao/open-claude.git"
INSTALL_DIR="${OPEN_CLAUDE_INSTALL_DIR:-$HOME/.open-claude-app}"
BIN_DIR="$HOME/.local/bin"
BIN_LINK="$BIN_DIR/open-claude"

echo ""
echo "  ██████╗ ██████╗ ███████╗███╗   ██╗       ██████╗██╗      █████╗ ██╗   ██╗██████╗ ███████╗"
echo " ██╔═══██╗██╔══██╗██╔════╝████╗  ██║      ██╔════╝██║     ██╔══██╗██║   ██║██╔══██╗██╔════╝"
echo " ██║   ██║██████╔╝█████╗  ██╔██╗ ██║█████╗██║     ██║     ███████║██║   ██║██║  ██║█████╗  "
echo " ██║   ██║██╔═══╝ ██╔══╝  ██║╚██╗██║╚════╝██║     ██║     ██╔══██║██║   ██║██║  ██║██╔══╝  "
echo " ╚██████╔╝██║     ███████╗██║ ╚████║      ╚██████╗███████╗██║  ██║╚██████╔╝██████╔╝███████╗"
echo "  ╚═════╝ ╚═╝     ╚══════╝╚═╝  ╚═══╝       ╚═════╝╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚═════╝ ╚══════╝"
echo ""
info "Installing open-claude..."
echo ""

# ─── 1. Check / install Bun ───────────────────────────────────────────────────
BUN_BIN="${BUN_BIN:-$HOME/.bun/bin/bun}"
if [ ! -x "$BUN_BIN" ]; then
  warn "Bun not found, installing..."
  curl -fsSL https://bun.sh/install | bash
  export PATH="$HOME/.bun/bin:$PATH"
  BUN_BIN="$HOME/.bun/bin/bun"
fi
success "Bun: $("$BUN_BIN" --version)"

# ─── 2. Clone or update repo ──────────────────────────────────────────────────
if [ -d "$INSTALL_DIR/.git" ]; then
  info "Updating existing installation at $INSTALL_DIR ..."
  git -C "$INSTALL_DIR" pull --ff-only
else
  info "Cloning into $INSTALL_DIR ..."
  git clone "$REPO" "$INSTALL_DIR"
fi
success "Source ready at $INSTALL_DIR"

# ─── 3. Install dependencies ──────────────────────────────────────────────────
info "Installing dependencies..."
"$BUN_BIN" install --cwd "$INSTALL_DIR"
success "Dependencies installed"

# ─── 4. Create ~/.local/bin symlink ───────────────────────────────────────────
mkdir -p "$BIN_DIR"
chmod +x "$INSTALL_DIR/bin/open-claude"
ln -sf "$INSTALL_DIR/bin/open-claude" "$BIN_LINK"
success "Symlink created: $BIN_LINK → $INSTALL_DIR/bin/open-claude"

# ─── 5. Ensure ~/.local/bin is in PATH ────────────────────────────────────────
PATH_LINE='export PATH="$HOME/.local/bin:$PATH"'
ADDED_TO_SHELL=false

if [[ ":$PATH:" != *":$BIN_DIR:"* ]]; then
  # Detect shell rc file
  if [ -n "${ZSH_VERSION:-}" ] || [ "$(basename "${SHELL:-}")" = "zsh" ]; then
    RC_FILE="$HOME/.zshrc"
  else
    RC_FILE="$HOME/.bashrc"
  fi

  if ! grep -qF "$PATH_LINE" "$RC_FILE" 2>/dev/null; then
    echo "" >> "$RC_FILE"
    echo "# Added by open-claude installer" >> "$RC_FILE"
    echo "$PATH_LINE" >> "$RC_FILE"
    ADDED_TO_SHELL=true
    success "Added PATH to $RC_FILE"
  fi

  # Also export for the current session
  export PATH="$BIN_DIR:$PATH"
fi

# ─── Done ─────────────────────────────────────────────────────────────────────
echo ""
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
success "open-claude installed successfully!"
echo ""
echo "  Run:  open-claude"
echo ""
echo "  First launch will guide you through model & API key setup."
echo "  Switch model later:  /model openai gpt-4o"
if [ "$ADDED_TO_SHELL" = true ]; then
  echo ""
  warn "Restart your terminal (or run: source $RC_FILE) to use 'open-claude'"
fi
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
