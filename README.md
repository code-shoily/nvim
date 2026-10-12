# ⚡ My Neovim Setup

A bespoke, keyboard-centric Neovim configuration built on the exceptional foundation of [LazyVim](https://lazyvim.org), specifically tuned for my daily workflow across **Elixir**, **Clojure (REPL-Driven Development)**, **Gleam**, and **Zig**, alongside paired AI programming with **Antigravity (AGY)** and **Claude Code**.

This configuration represents a complete modernization and migration from my long-standing Vim setup, [code-shoily-vimrc](https://github.com/code-shoily/code-shoily-vimrc). It preserves the hard-earned muscle memory and ergonomic principles from that setup (instant home-row escape with `jj`, shift-free command mode with `;`, fast window split navigation) while embracing the speed of Lua, Treesitter AST awareness, native LSP integrations, and native AI terminal pairing.

---

## 🧭 Philosophy & Influences

1. **Rooted in [code-shoily-vimrc](https://github.com/code-shoily/code-shoily-vimrc)**:
   - Muscle memory comes first. Core ergonomics such as `jj` to exit insert mode, `;` mapped to `:`, and frictionless window navigation (`<C-h>`, `<C-j>`, `<C-k>`, `<C-l>`) carry forward seamlessly.
2. **Powered by [LazyVim](https://lazyvim.org)**:
   - Due credit to [folke](https://github.com/folke) and the LazyVim community. Rather than reinventing plugin management, this configuration leverages LazyVim's lightning-fast startup, modular plugin architecture, and sensible defaults as its base.
3. **Language-First Polyglot Environment**:
   - **Elixir**: Optimized with [Dexter](https://github.com/...) — a lightning-fast LSP alternative to ElixirLS.
   - **Clojure**: Rich REPL-Driven Development (RDD) via [Conjure](https://github.com/Olical/conjure) and AST-aware structural editing via Paredit.
   - **Gleam**: First-class type inspection, compiler errors, code actions, and formatting.
4. **Subscription-Backed AI Terminal Pair Programming**:
   - Direct Neovim access to both **Antigravity (AGY)** and **Claude Code** without metered API fees, maintaining active conversation sessions and passing live cursor/selection context.

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
*`lazy.nvim` will automatically download and install all locked plugins in parallel.*

---

## 🛠️ Language Tooling & External Dependencies

For full functionality across languages, install the following language tools:

### 💧 Elixir
- **Elixir & Erlang/OTP** (managed via `mise`, `asdf`, or system package manager).
- **Dexter** (`dexter`): Lightning-fast Elixir LSP server. Installed on PATH (e.g. via `mise install dexter` or binary release).
- **mix format**: Built into Elixir, invoked via `<Leader>cf`.

### ☕ Clojure
- **Clojure CLI** (`clj` / `clojure`).
- **zprint** (code formatter): Install binary to PATH (e.g. `/usr/bin/zprint`, via brew, or direct download).
- **Global nREPL alias**: Ensure `~/.config/clojure/deps.edn` has the `:nrepl` alias (see [External Configs Reference](#-external-configs-reference)).

### ⭐ Gleam
- **Gleam** compiler (`gleam`) — includes built-in `gleam lsp` and formatter.
- **Erlang/OTP** (>= 26).

### ⚡ Zig
- **Zig** compiler (`zig`): Installed via `mise` (or system package manager).
- **zls** (Zig Language Server): Installed on PATH (e.g. via `mise install zls`).
- **zig fmt**: Built into the Zig toolchain, auto-invoked via `<Leader>cf`.

### 🤖 AI CLI & Terminal Tools
- **agy** (Antigravity CLI): Placed on PATH (`~/.local/bin/agy`). Uses Google subscription.
- **claude** (Claude Code CLI): Placed on PATH (`~/.local/bin/claude`). Uses Anthropic subscription.
- **lazygit**: For `<Leader>gg` interactive git interface.

---

## ⌨️ Essential Keybindings Cheat Sheet

### General Navigation & Muscle Memory (from `code-shoily-vimrc`)
| Key | Mode | Action |
| :--- | :--- | :--- |
| `jj` | Insert | **Instant Escape**: Exit insert mode without reaching for `<Esc>` |
| `;` | Normal / Visual | **Command Mode**: Enter `:` without pressing Shift |
| `:` | Normal / Visual | Repeat character search (`f` / `t`) |
| `<C-h>` / `<C-l>` | Normal | Jump between left / right window splits |
| `<C-j>` / `<C-k>` | Normal | Jump between lower / upper window splits |
| `<Esc>` | Normal | Clear search highlights and dismiss floating popups/notifications |
| `<Leader>cf` | Normal | **Code Format** (Mix format for Elixir, zprint for Clojure, Gleam format for Gleam, zig fmt for Zig) |
| `<Leader>e` | Normal | Toggle file explorer sidebar |
| `<Leader><Space>` | Normal | Find files (Snacks picker) |
| `<Leader>/` | Normal | Live grep text in project |

---

## 🤖 AI Assistants (`<Leader>a...`)

Both **Antigravity (AGY)** and **Claude Code** are wired directly into Neovim under the unified `<Leader>a` (**A**I) namespace. Both run directly through your existing developer subscriptions (zero per-token API costs), maintain persistent terminal sessions, and support contextual prompting.

### Keymaps Matrix

| Key | Mode | Agent | Layout | Description |
| :--- | :--- | :--- | :--- | :--- |
| **`<Leader>aa`** | Normal / Visual | **Antigravity (AGY)** | **Right Sidebar** | Code left, AGY right (42% width). Auto-injects file & line context. |
| **`<Leader>aA`** | Normal / Visual | **Antigravity (AGY)** | **Floating Overlay** | Centered 85% popover window for deep reasoning or planning. |
| **`<Leader>ac`** | Normal / Visual | **Claude Code** | **Right Sidebar** | Code left, Claude right (42% width) running `claude -c`. |
| **`<Leader>aC`** | Normal / Visual | **Claude Code** | **Floating Overlay** | Centered 85% popover window running `claude -c`. |
| `<C-/>` | Any | Active Terminal | Toggle | Instantly hide or show the active terminal split. |

### How Context & Persistence Work

1. **Context-Aware Prompting**:
   - In **Normal Mode**: Triggers a prompt dialog pre-filled with `[file:line]`. Typing your question submits:  
     `Regarding src/file.ex at line 42: <your prompt>`
   - In **Visual Mode**: Highlight a block of code and press `<Leader>aa` or `<Leader>ac`. The prompt pre-fills `[file:lines M-N]`:  
     `Regarding src/file.ex at lines 15-28: <your prompt>`
2. **Persistent Sessions & Conversation Continuity**:
   - AGY is invoked with `agy -c` and Claude with `claude -c`.
   - Repeatedly invoking `<Leader>aa` or `<Leader>ac` reuses the running terminal process, bringing it into focus and sending the prompt via Neovim channels without starting a new process or dropping conversational memory.
3. **Split Window Navigation**:
   - Jump between your code and the AI sidebar using `<C-w>h` (left to code) and `<C-w>l` (right to agent).
   - In terminal insert mode, press `<C-\><C-n>` first or use `<C-w>h`.

---

## 💧 Elixir Development

Elixir is a cornerstone language in my daily workflow. This setup replaces traditional, heavy LSP setups with **Dexter** for near-instant responsiveness.

### 1. Dexter LSP (`dexter lsp`)
- **Lightning-Fast Indexing**: Dexter indexes Phoenix and umbrella projects in seconds, avoiding the CPU spikes and memory bloat of older LSP servers.
- **Configured Filetypes**: Full support for `.ex`, `.exs`, and `.heex` templates (defined in `lua/plugins/dexter.lua`).
- **ElixirLS Disabled**: `elixirls` is cleanly disabled to prevent conflicting diagnostics or background processes.

### 2. Navigation & Inspection
- **`gd`**: Go to definition (functions, modules, schemas)
- **`gr`**: Find references across project
- **`K`**: Hover to inspect documentation and `@spec` type contracts
- **`[d` / `]d`**: Jump to previous / next compiler diagnostic or warning
- **`<Leader>cr`**: Rename symbol (with live incremental rename)

### 3. Execution & Testing
- **`\r`**: Run project (`mix run` or `elixir <file.exs>`)
- **`\t`**: Run tests (`mix test` or `mix test <test_file>`)
- **`\s`**: Launch interactive `iex -S mix` session
- **`<Leader>cf`**: Formats current buffer with `mix format` via Conform
- **`<Leader>tt`**: Run test suite via `neotest-elixir`
- **`<Leader>tr`**: Run nearest test under cursor
- **`<Leader>ts`**: View test summary and debug output

---

## ☕ Clojure & REPL-Driven Development (RDD)

Clojure development revolves around an active, long-lived nREPL session connected via [Conjure](https://github.com/Olical/conjure).

### 1. Starting the REPL
In your Clojure project root:
```bash
clj -M:nrepl
```
*Neovim detects the generated `.nrepl-port` file on save/open and connects automatically.*

### 2. Evaluation Shortcuts (Conjure)
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

### 3. Structural Editing (Paredit)
*Treesitter-powered AST editing. Operates on balanced S-expressions in Normal mode.*

| Key | Action | Example |
| :--- | :--- | :--- |
| **`>)`** | **Slurp forward** | `(a b) c` ➔ `(a b c)` |
| **`<)`** | **Barf forward** | `(a b c)` ➔ `(a b) c` |
| **`<(`** | **Slurp backward** | `a (b c)` ➔ `(a b c)` |
| **`>(`** | **Barf backward** | `(a b c)` ➔ `a (b c)` |
| **`>e`** / **`<e`** | Drag element right / left | Reorders symbols / arguments |
| **`>p`** / **`<p`** | Drag pair right / left | Swaps map key-values or `let` bindings |
| **`\ @`** | Splice / unwrap | `(a (b c) d)` ➔ `(a b c d)` |
| **`\ o`** | Raise form | Replaces parent form with cursor form |
| **`cif`** | Change inside form | Deletes form insides and enters Insert mode |
| **`daf`** | Delete around form | Deletes entire enclosing `(...)` |

---

## ⭐ Gleam Development

Full language support for Gleam and the BEAM runtime:
- **`gd`**: Go to definition
- **`gr`**: Find references
- **`gD`**: Go to type definition
- **`K`**: Hover to inspect inferred types & docstrings
- **`<Leader>cf`**: Format with `gleam format`
- **`]d`** / **`[d`**: Jump to next / previous compiler error
- **`<Leader>ca`**: Code actions (auto-import modules, generate missing case match patterns)

### Execution Shortcuts (`\`)
- **`\r`**: Run project root (`gleam run`)
- **`\m`**: **Run current module** (`gleam run -m <module>` — auto-detects `src/...` path)
- **`\t`**: Run tests (`gleam test`)
- **`\c`**: Fast compiler check (`gleam check`)
- **`\s`**: Launch interactive Erlang/Gleam shell (`gleam shell`)

---

## ⚡ Zig Development

Full language support for Zig via `lazyvim.plugins.extras.lang.zig`, `zls`, and `neotest-zig`:
- **`gd`**: Go to definition
- **`gr`**: Find references
- **`K`**: Hover documentation & type signatures
- **`<Leader>cf`**: Auto-format buffer with `zig fmt`
- **`]d`** / **`[d`**: Jump to next / previous compiler error or diagnostic
- **`<Leader>tt`**: Run `zig test` suite via `neotest-zig`
- **`<Leader>tr`**: Run nearest test under cursor

### Execution Shortcuts (`\`)
- **`\r`**: Run (`zig build run` if `build.zig` exists, or `zig run <file.zig>`)
- **`\t`**: Run tests (`zig build test` or `zig test <file.zig>`)
- **`\b`**: Build project (`zig build`)

---

## 🔀 Multi-Cursor Editing (`vim-visual-multi`)

| Key | Action |
| :--- | :--- |
| **`<C-n>`** | Select word under cursor & find next match (like VS Code `Ctrl+D`) |
| **`q`** | Skip match |
| **`\\A`** | Select all matches across entire buffer |
| **`<C-Down>`** / **`<C-Up>`** | Add cursor below / above |
| **`i`** / **`a`** / **`c`** | Start typing at all cursors simultaneously |
| `<Esc>` | Exit multi-cursor mode |

---

## 🐙 Git Navigation

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

---

## 👏 Acknowledgments & Credits

- [LazyVim](https://lazyvim.org) by [folke](https://github.com/folke) — for providing the most elegant, modular Neovim baseline in the ecosystem.
- [code-shoily-vimrc](https://github.com/code-shoily/code-shoily-vimrc) — my original Vim setup that shaped my muscle memory and daily editing habits for years.
- [Dexter](https://github.com/...) — for lightning-fast Elixir language server performance.
- [Conjure](https://github.com/Olical/conjure) by Oliver Caldwell — the gold standard for Clojure REPL-driven development in Neovim.
- [Snacks.nvim](https://github.com/folke/snacks.nvim) — powering the terminal toggles, floating modals, and pickers.
