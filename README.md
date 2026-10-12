# ⚡ My Neovim Setup

A bespoke, keyboard-centric Neovim configuration built on the exceptional foundation of [LazyVim](https://lazyvim.org), specifically tuned for daily polyglot engineering across **Elixir**, **Clojure (REPL-Driven Development)**, **Gleam**, **Zig**, **Rust**, and **Go**, alongside paired AI programming with **Antigravity (AGY)** and **Claude Code**.

This setup represents a complete modernization and migration from my long-standing Vim setup, [code-shoily-vimrc](https://github.com/code-shoily/code-shoily-vimrc). It preserves the hard-earned muscle memory and ergonomic principles from that setup (instant home-row escape with `jj`, shift-free command mode with `;`, fast window split navigation) while embracing the speed of Lua, Treesitter AST awareness, native LSP integrations, and native AI terminal pairing.

---

## 📚 Documentation & Guides

- 🛠️ [**Polyglot Language Guides (LANGUAGES.md)**](LANGUAGES.md) — Toolchain prerequisites, LSP configurations, formatters, and RDD/compiler workflows for **Elixir**, **Clojure**, **Gleam**, **Zig**, **Rust**, and **Go**.
- ⌨️ [**Keybindings Cheat Sheet (CHEATSHEET.md)**](CHEATSHEET.md) — Complete keyboard cheat sheet covering navigation, AI pair programming, unified `\` language runners, Clojure Paredit, multi-cursor, surround, undotree, and git conflict resolution.

---

## ✨ Features at a Glance

1. **Muscle-Memory Core (from `code-shoily-vimrc`)**:
   - `jj` for instant escape from insert mode without reaching for `<Esc>`.
   - `;` enters command mode `:` without holding Shift.
   - `<C-h>`, `<C-j>`, `<C-k>`, `<C-l>` for seamless window split navigation.
2. **Polyglot Developer Experience**:
   - **Unified One-Key Runners**: `<localleader>` (`\`) runs (`\r`), tests (`\t`), builds (`\b`), or checks (`\c`) across all languages.
   - **Test ⇄ Source Switching**: `<Leader>tf` / `:A` toggles between source and tests; `<Leader>tv` / `:AV` opens them in a vertical split.
   - **Unified Formatting**: `<Leader>cf` auto-formats with project-native formatters (`mix format`, `zprint`, `gleam format`, `zig fmt`, `rustfmt`, `goimports`/`gofumpt`).
3. **AI Pair Programming (AGY & Claude Code)**:
   - Native split terminals (`<Leader>aa`, `<Leader>ac`) and centered modal overlays (`<Leader>aA`, `<Leader>aC`).
   - Subscription-backed (zero per-token API costs), with persistent sessions and automatic buffer/line context injection.
4. **Modern Editing & Navigation Power**:
   - **Multi-cursor editing**: `vim-visual-multi` (`<C-n>`, `\\A`).
   - **Surround manipulation**: `mini.surround` (`gsa`, `gsd`, `gsr`).
   - **Visual branching undo**: `undotree` (`<Leader>uu`).
   - **Git integration**: LazyGit (`<Leader>gg`), inline hunk actions, and 1-key merge conflict resolution (`git-conflict.nvim`).

---

## 🚀 Quick Setup on a New Machine

### 1. Prerequisites
Ensure the following tools are installed on your system:
- **Neovim** (>= 0.10.0)
- **Git**, **curl**, and a C compiler (`gcc` or `clang` / `build-essential`)
- **Ripgrep** (`rg`) and **fd** (`fd-find`)
- A [Nerd Font](https://www.nerdfonts.com/) (recommended: *CaskaydiaCove Nerd Font*)

### 2. Clone the Config
```bash
# Backup existing config if any
[ -d ~/.config/nvim ] && mv ~/.config/nvim ~/.config/nvim.bak

# Clone this repository
git clone <YOUR_GIT_REPO_URL> ~/.config/nvim
```

### 3. Launch Neovim
```bash
nvim
```
*`lazy.nvim` will automatically download, compile, and configure all plugins in parallel.*

### 4. Language Toolchains & External Configs
For compiler, LSP, and formatter dependencies across Elixir, Clojure, Gleam, Zig, Rust, and Go, refer to [**LANGUAGES.md**](LANGUAGES.md).

For quick setup of Clojure formatting and nREPL:
- **Global nREPL alias** (`~/.config/clojure/deps.edn`):
  ```clojure
  {:aliases
   {:nrepl
    {:extra-deps {nrepl/nrepl {:mvn/version "1.3.0"}}
     :main-opts  ["-m" "nrepl.cmdline"]}}}
  ```
- **Global zprint rules** (`~/.zprint.edn`):
  ```clojure
  {:style [:community, :justified, :respect-nl]}
  ```

---

## 👏 Acknowledgments & Credits

- [LazyVim](https://lazyvim.org) by [folke](https://github.com/folke) — for providing the cleanest, most modular Neovim foundation in the ecosystem.
- [code-shoily-vimrc](https://github.com/code-shoily/code-shoily-vimrc) — my original Vim setup that shaped my muscle memory and daily workflow for years.
- [Dexter](https://github.com/...) — for lightning-fast Elixir language server performance.
- [Conjure](https://github.com/Olical/conjure) by Oliver Caldwell — the gold standard for Clojure REPL-driven development in Neovim.
- [Snacks.nvim](https://github.com/folke/snacks.nvim) — powering the terminal toggles, floating modals, and pickers.
