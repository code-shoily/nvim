# ⚡ My Neovim Setup

A modern, fast, and keyboard-driven Neovim configuration built on [LazyVim](https://lazyvim.org), tailored for **Clojure (REPL-Driven Development)**, **Gleam**, **Elixir / Rust**, and **AI-assisted coding with Antigravity (AGY)**.

---

## 🚀 Quick Setup on a New Machine

### 1. Prerequisites
Ensure you have the following installed on your system:
- **Neovim** (>= 0.10.0)
- **Git**, **curl**, and a C compiler (`build-essential` or `gcc`)
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
*`lazy.nvim` will automatically download and install all 57+ locked plugins in parallel.*

---

## 🛠️ Language Tooling & External Dependencies

For full functionality across languages, install the following language tools:

### Clojure
- **Clojure CLI** (`clj` / `clojure`)
- **zprint** (code formatter): install binary to PATH (e.g. `/usr/bin/zprint` or via brew/aur).
- **Global nREPL alias**: Ensure `~/.config/clojure/deps.edn` has the `:nrepl` alias (see [External Configs Reference](#-external-configs-reference)).

### Gleam
- **Gleam** compiler (`gleam`) — includes built-in `gleam lsp` and formatter.
- **Erlang/OTP** (>= 26)

### Git & Terminal Tools
- **lazygit** (for `<Leader>gg` interactive git interface)
- **agy** (Antigravity CLI) placed on PATH (`~/.local/bin/agy`)

---

## ⌨️ Essential Keybindings Cheat Sheet

### General & Navigation
| Key | Action |
| :--- | :--- |
| `jj` | Exit Insert mode (instant home-row escape) |
| `;` | Enter command mode (`:`) without pressing Shift |
| `<C-h>` / `<C-l>` | Jump between left / right window splits |
| `<C-j>` / `<C-k>` | Jump between lower / upper window splits |
| `<Leader>cf` | **Code Format** (uses `zprint` for Clojure/EDN, `gleam format` for Gleam) |
| `<Leader>e` | Toggle file explorer sidebar |
| `<Leader><Space>` | Find files (Snacks picker) |
| `<Leader>/` | Grep text in project |

---

### 🤖 AI Assistant (Antigravity / AGY)
*Uses your Google subscription with zero per-token API costs.*

| Key | Mode | Action |
| :--- | :--- | :--- |
| **`<Leader>aa`** | Normal / Visual | Opens AGY in a **Right Sidebar** (code on left, AGY on right). Pre-populates prompt with current file and line numbers. |
| **`<Leader>aA`** | Normal / Visual | Opens AGY in a **Floating Window Overlay** (85% centered screen). |
| `<C-/>` | Any | Toggle / hide terminal sidebar |

*Note: Subsequent `<Leader>aa` calls automatically reuse the running persistent session and continue the active project conversation.*

---

### 🪵 Clojure & REPL-Driven Development (RDD)

#### 1. Starting the REPL
In your Clojure project root, run:
```bash
clj -M:nrepl
```
*Neovim (`conjure`) will automatically detect the `.nrepl-port` file and connect.*

#### 2. Evaluation Shortcuts (Conjure)
*(All Conjure mappings start with `<localleader>`, which is `\`)*

| Key | Action | Description |
| :--- | :--- | :--- |
| **`\ee`** | Eval form | Evaluates innermost `(...)` under cursor |
| **`\er`** | Eval root | Evaluates top-level `defn` / `def` form |
| **`\eb`** | Eval buffer | Evaluates the entire file |
| **`\ew`** | Eval word | Evaluates the symbol under cursor |
| **`\lv`** | Log buffer (vsplit) | Opens live REPL log buffer in vertical split |
| **`\ls`** | Log buffer (split) | Opens live REPL log buffer in horizontal split |
| **`\lr`** | Reset log | Clears log buffer |

#### 3. Structural Editing (Paredit)
*Treesitter-powered AST editing. Operates on balanced S-expressions in Normal mode.*

| Key | Action | Example |
| :--- | :--- | :--- |
| **`>)`** | **Slurp forward** | `(a b) c` ➔ `(a b c)` |
| **`<)`** | **Barf forward** | `(a b c)` ➔ `(a b) c` |
| **`<(`** | **Slurp backward** | `a (b c)` ➔ `(a b c)` |
| **`>(`** | **Barf backward** | `(a b c)` ➔ `a (b c)` |
| **`>e`** / **`<e`** | Drag element right / left | Reorders symbols/arguments |
| **`>p`** / **`<p`** | Drag pair right / left | Swaps map key-values or `let` bindings |
| **`\ @`** | Splice / unwrap | `(a (b c) d)` ➔ `(a b c d)` |
| **`\ o`** | Raise form | Replaces parent form with cursor form |
| **`cif`** | Change inside form | Deletes form insides and enters Insert mode |
| **`daf`** | Delete around form | Deletes entire enclosing `(...)` |

---

### 🍊 Gleam Development
- **`gd`**: Go to definition
- **`gr`**: Find references
- **`gD`**: Go to type definition
- **`K`**: Hover to inspect inferred types & docstrings
- **`<Leader>cf`**: Format with `gleam format`
- **`]d`** / **`[d`**: Jump to next / previous compiler error
- **`<Leader>ca`**: Code actions (auto-import, fill case match branches)

---

### 🔀 Multi-Cursor Editing (`vim-visual-multi`)
| Key | Action |
| :--- | :--- |
| **`<C-n>`** | Select word under cursor & find next match (like VS Code `Ctrl+D`) |
| **`q`** | Skip match |
| **`\\A`** | Select all matches across entire buffer |
| **`<C-Down>`** / **`<C-Up>`** | Add cursor below / above |
| **`i`** / **`a`** / **`c`** | Start typing at all cursors simultaneously |
| `<Esc>` | Exit multi-cursor mode |

---

### 🐙 Git Navigation
| Key | Action |
| :--- | :--- |
| **`<Leader>gg`** | Open **LazyGit** full UI in a float |
| **`<Leader>gs`** | Git status picker with diff preview |
| **`<Leader>gc`** | Git commit log picker |
| **`]h`** / **`[h`** | Jump to next / previous changed hunk in file |
| **`<Leader>ghp`** | Preview hunk diff inline |
| **`<Leader>ghs`** | Stage current hunk |
| **`<Leader>ghr`** | Reset / undo current hunk |
| **`<Leader>ghb`** | Blame line |

---

## 📋 External Configs Reference

Copy these two files onto your new machine to complete the environment:

### 1. `~/.config/clojure/deps.edn` (Global `:nrepl` Alias)
```clojure
{:aliases
 {:nrepl
  {:extra-deps {nrepl/nrepl {:mvn/version "1.3.0"}}
   :main-opts  ["-m" "nrepl.cmdline"]}}}
```

### 2. `~/.zprint.edn` (Clojure Formatting Rules)
```clojure
{:style [:community, :justified, :respect-nl]}
```
