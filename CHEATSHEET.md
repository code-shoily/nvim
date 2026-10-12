# ⌨️ Neovim Keybindings Cheat Sheet

Quick reference for all custom and core keybindings configured in this setup.

> **Prefix Conventions**:
> - `<Leader>` = `Space`
> - `<localleader>` = `\` (Backslash)

---

## 🧭 Navigation & Core Muscle Memory

*Carried forward and adapted from [code-shoily-vimrc](https://github.com/code-shoily/code-shoily-vimrc).*

| Key | Mode | Action | Description |
| :--- | :--- | :--- | :--- |
| **`jj`** | Insert | **Instant Escape** | Exit insert mode immediately without reaching for `<Esc>` |
| **`;`** | Normal / Visual | **Command Mode** | Enter `:` command-line mode without pressing Shift |
| **`:`** | Normal / Visual | Repeat Search | Repeat previous `f` / `t` character find |
| **`<C-h>`** | Normal | Window Left | Move focus to left split |
| **`<C-l>`** | Normal | Window Right | Move focus to right split |
| **`<C-j>`** | Normal | Window Down | Move focus to lower split |
| **`<C-k>`** | Normal | Window Up | Move focus to upper split |
| **`<Esc>`** | Normal | Clear Highlights | Clear search highlight & close floating popups/notifs |
| **`<C-^>`** | Normal | Alternate Buffer | Flip between the two most recently used buffers |
| **`<Leader>e`** | Normal | Explorer | Toggle file explorer sidebar |
| **`<Leader><Space>`** | Normal | Find Files | Snacks / Telescope file picker |
| **`<Leader>/`** | Normal | Live Grep | Search for text across entire project |

---

## 🧪 Test ⇄ Source File Switching

Seamless switching between implementation files and their corresponding test files:

| Key / Command | Action | Description |
| :--- | :--- | :--- |
| **`<Leader>tf`** or **`:A`** | **Toggle Test/Source** | Switches active buffer between code and test file |
| **`<Leader>tv`** or **`:AV`** | **Split Test/Source** | Opens corresponding test file in a vertical split |

### Supported Mappings:
- **Elixir**: `lib/foo.ex` ⇄ `test/foo_test.exs`
- **Gleam**: `src/foo.gleam` ⇄ `test/foo_test.gleam`
- **Clojure**: `src/foo.clj` ⇄ `test/foo_test.clj`
- **Zig**: `src/foo.zig` ⇄ `test/foo_test.zig`
- **Rust**: `src/foo.rs` ⇄ `tests/foo_test.rs` (or `tests/foo.rs`)
- **Go**: `foo.go` ⇄ `foo_test.go`

---

## 🚀 Unified Language Execution Runners (`\`)

All languages use `<localleader>` (`\`) for 1-key buffer execution:

| Shortcut | Action | Elixir | Gleam | Zig | Rust | Go |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **`\r`** | **Run** | `mix run` / `elixir` | `gleam run` | `zig build run` / `zig run` | `cargo run` | `go run .` / `go run <file>` |
| **`\t`** | **Test** | `mix test` | `gleam test` | `zig build test` / `zig test` | `cargo test` | `go test ./...` |
| **`\b`** | **Build** | — | — | `zig build` | `cargo build` | `go build ./...` |
| **`\c`** | **Check / Vet** | — | `gleam check` | — | `cargo check` | `go vet ./...` |
| **`\s`** | **REPL / Shell** | `iex -S mix` | `gleam shell` | — | — | — |
| **`\m`** | **Run Module** | — | `gleam run -m <mod>` | — | — | — |

---

## ☕ Clojure REPL & Structural Editing

### 1. REPL Evaluation (Conjure)
*(All mappings start with `\`)*

| Key | Action | Description |
| :--- | :--- | :--- |
| **`\ee`** | **Eval Form** | Evaluates innermost `(...)` under cursor |
| **`\er`** | **Eval Root** | Evaluates outermost root definition (`defn`, `def`) |
| **`\eb`** | **Eval Buffer** | Evaluates entire current file |
| **`\ew`** | **Eval Word** | Evaluates symbol/word under cursor |
| **`\lv`** | **Log Split (vsplit)** | Opens live REPL output log in vertical split |
| **`\ls`** | **Log Split (hsplit)** | Opens live REPL output log in horizontal split |
| **`\lr`** | **Reset Log** | Clears REPL log buffer |

### 2. Paredit AST Structural Editing (Normal Mode)

| Key | Operation | Before | After |
| :--- | :--- | :--- | :--- |
| **`>)`** | Slurp forward | `(a b) c` | `(a b c)` |
| **`<)`** | Barf forward | `(a b c)` | `(a b) c` |
| **`<(`** | Slurp backward | `a (b c)` | `(a b c)` |
| **`>(`** | Barf backward | `(a b c)` | `a (b c)` |
| **`>e`** | Drag element right | `(a b c)` | `(b a c)` |
| **`<e`** | Drag element left | `(a b c)` | `(a c b)` |
| **`>p`** / **`<p`** | Drag pair right / left | `{:a 1 :b 2}` | `{:b 2 :a 1}` |
| **`\ @`** | Splice form (unwrap) | `(a (b c) d)` | `(a b c d)` |
| **`\ o`** | Raise form | `(a (b c) d)` | `(b c)` |
| **`cif`** | Change inside form | `(a b c)` | `()` *(enters insert)* |
| **`daf`** | Delete around form | `(a b c)` | *deleted completely* |

---

## 🤖 AI Pair Programming Assistants (`<Leader>a...`)

Integrated access to **Antigravity (AGY)** and **Claude Code** via native terminal splits without per-token API costs:

| Key | Mode | Agent | Layout | Description |
| :--- | :--- | :--- | :--- | :--- |
| **`<Leader>aa`** | Normal / Visual | **Antigravity (AGY)** | Right Split (42%) | Persistent chat sidebar with file/line context |
| **`<Leader>aA`** | Normal / Visual | **Antigravity (AGY)** | Floating Modal (85%) | Centered overlay for deep reasoning & planning |
| **`<Leader>ac`** | Normal / Visual | **Claude Code** | Right Split (42%) | Persistent Claude terminal session (`claude -c`) |
| **`<Leader>aC`** | Normal / Visual | **Claude Code** | Floating Modal (85%) | Centered Claude terminal overlay |
| **`<C-/>`** | Any | Active Terminal | Toggle | Hide or restore active terminal window |

---

## 🔄 Surround Operations (`mini.surround`)

Surround words, lines, or selections with quotes, brackets, and tags:

| Key | Mode | Action | Example |
| :--- | :--- | :--- | :--- |
| **`gsa`** | Normal / Visual | Add surrounding | `gsa iw "` turns `word` ➔ `"word"` |
| **`gsd`** | Normal | Delete surrounding | `gsd "` turns `"word"` ➔ `word` |
| **`gsr`** | Normal | Replace surrounding | `gsr "` `'` turns `"word"` ➔ `'word'` |
| **`gsh`** | Normal | Highlight surrounding | Highlights matching surrounding pairs |
| **`gsf`** / **`gsF`** | Normal | Find surrounding | Jump to next / previous surrounding |

---

## 🔀 Multi-Cursor Editing (`vim-visual-multi`)

| Key | Action |
| :--- | :--- |
| **`<C-n>`** | Select word under cursor & find next occurrence |
| **`q`** | Skip current match and proceed to next |
| **`\\A`** | Select all occurrences across current buffer |
| **`<C-Down>`** / **`<C-Up>`** | Add cursor on line below / above |
| **`i`** / **`a`** / **`c`** | Enter edit mode across all cursors simultaneously |
| **`<Esc>`** | Exit multi-cursor mode |

---

## 🌳 Visual Branching Undo (`undotree`)

| Key | Action | Description |
| :--- | :--- | :--- |
| **`<Leader>uu`** | **Toggle Undotree** | Opens visual branching history timeline with diff preview |

---

## 🐙 Git & Merge Conflicts

### 1. LazyGit & Hunk Operations
| Key | Action |
| :--- | :--- |
| **`<Leader>gg`** | Open **LazyGit** floating UI |
| **`<Leader>gs`** | Git status picker |
| **`<Leader>gc`** | Git commit log picker |
| **`]h`** / **`[h`** | Next / previous changed git hunk |
| **`<Leader>ghp`** | Preview hunk diff inline |
| **`<Leader>ghs`** | Stage current hunk |
| **`<Leader>ghr`** | Reset current hunk |
| **`<Leader>ghb`** | Blame current line |

### 2. Merge Conflict Resolution (`git-conflict.nvim`)
When merge conflict markers are present:
| Key | Action | Description |
| :--- | :--- | :--- |
| **`co`** | Choose **Ours** | Accept current branch change |
| **`ct`** | Choose **Theirs** | Accept incoming branch change |
| **`cb`** | Choose **Both** | Keep both changes |
| **`c0`** | Choose **None** | Remove both conflict blocks |
| **`]x`** / **`[x`** | Jump to Conflict | Jump to next / previous conflict marker |

---

## 💡 Code & LSP Diagnostics

| Key | Action |
| :--- | :--- |
| **`gd`** | Go to definition |
| **`gr`** | Find references across project |
| **`K`** | Hover documentation & type signature |
| **`<Leader>cf`** | **Code Format** (invokes project formatter via Conform/LSP) |
| **`<Leader>ca`** | Code actions |
| **`<Leader>cr`** | Incremental symbol rename |
| **`]d`** / **`[d`** | Jump to next / previous diagnostic / error |
| **`<Leader>xx`** | Diagnostics panel (Trouble) |
| **`<Leader>tt`** | Run test suite (`neotest`) |
| **`<Leader>tr`** | Run nearest test (`neotest`) |
| **`<Leader>ts`** | Toggle test summary panel |
