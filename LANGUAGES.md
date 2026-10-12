# 🛠️ Polyglot Language Guides & Tooling

This document provides a comprehensive guide to the language setups, external toolchain requirements, LSP servers, formatters, and project runners configured in this Neovim environment.

---

## 🧭 Polyglot Architecture & Conventions

All supported languages follow consistent ergonomics:
- **LSP Defaults**: `gd` (Go to definition), `gr` (Find references), `K` (Hover docs/types), `<Leader>ca` (Code actions), `<Leader>cr` (Rename).
- **Code Formatting (`<Leader>cf`)**: Hooked into [Conform](https://github.com/stevearc/conform.nvim) or native LSPs with format-on-save enabled.
- **One-Key Runners (`<localleader>` = `\`)**:
  - `\r` ➔ Run main / root project
  - `\t` ➔ Run test suite
  - `\b` ➔ Build project
  - `\c` ➔ Check / lint / vet
- **Test ⇄ Source Switching**:
  - `<Leader>tf` or `:A` flips between source and its corresponding test file.
  - `<Leader>tv` or `:AV` opens the test file side-by-side in a vertical split.

---

## 📊 Language Tooling Matrix

| Language | LSP Server | Formatter (`<Leader>cf`) | Test Runner (`neotest`) | Key Runners (`\`) | Alternate File Mapping |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **💧 Elixir** | [Dexter](https://github.com/...) | `mix format` | `neotest-elixir` | `\r`, `\t`, `\s` | `lib/**/*.ex` ⇄ `test/**/*_test.exs` |
| **☕ Clojure** | `clojure-lsp` + [Conjure](https://github.com/Olical/conjure) | `zprint` | Conjure / `neotest` | `\ee`, `\er`, `\eb` | `src/**/*.clj` ⇄ `test/**/*_test.clj` |
| **⭐ Gleam** | `gleam lsp` | `gleam format` | Terminal | `\r`, `\m`, `\t`, `\c`, `\s` | `src/**/*.gleam` ⇄ `test/**/*_test.gleam` |
| **⚡ Zig** | `zls` | `zig fmt` | `neotest-zig` | `\r`, `\t`, `\b` | `src/**/*.zig` ⇄ `test/**/*_test.zig` |
| **🦀 Rust** | `rust-analyzer` ([rustaceanvim](https://github.com/mrcjkb/rustaceanvim)) | `rustfmt` | `neotest-rust` | `\r`, `\t`, `\b`, `\c` | `src/**/*.rs` ⇄ `tests/**/_test.rs` |
| **🐹 Go** | `gopls` | `goimports` + `gofumpt` | `neotest-golang` | `\r`, `\t`, `\b`, `\c` | `foo.go` ⇄ `foo_test.go` |

---

## 💧 Elixir Development

Elixir is optimized for blazing responsiveness by using **Dexter** instead of heavier alternatives.

### 1. Toolchain & Prerequisites
- **Erlang/OTP & Elixir** (managed via `mise`, `asdf`, or system package manager).
- **Dexter LSP** (`dexter`): Installed on PATH (e.g. via `mise install dexter` or binary release).
- **mix format**: Included with Elixir.

### 2. Configuration Highlights
- **Dexter LSP (`lua/plugins/dexter.lua`)**: Indexes large Phoenix and umbrella codebases in seconds without CPU spikes. Handles `.ex`, `.exs`, and `.heex` templates.
- **ElixirLS cleanly disabled**: Avoids redundant background compilation and conflicting diagnostics.

### 3. Execution & Testing Shortcuts (`\`)
- **`\r`**: Run project (`mix run` or `elixir <file.exs>`)
- **`\t`**: Run tests (`mix test` or `mix test <test_file>`)
- **`\s`**: Launch interactive `iex -S mix` terminal session
- **`<Leader>cf`**: Auto-format buffer with `mix format`
- **`<Leader>tt`**: Run test suite via `neotest-elixir`
- **`<Leader>tr`**: Run nearest test under cursor
- **`<Leader>ts`**: View test summary & output

---

## ☕ Clojure & REPL-Driven Development (RDD)

Clojure workflow is powered by an active, long-lived nREPL session connected via [Conjure](https://github.com/Olical/conjure) with AST-aware structural editing via Paredit.

### 1. Toolchain & Prerequisites
- **Clojure CLI** (`clj` / `clojure`).
- **zprint**: Binary installed to PATH (`/usr/bin/zprint` or via brew/download).
- **Global nREPL alias**: Ensure `~/.config/clojure/deps.edn` defines `:nrepl` (see [External Configs](#-external-configs-for-clojure)).

### 2. Starting the REPL
In your Clojure project root:
```bash
clj -M:nrepl
```
Neovim detects the `.nrepl-port` file on open/save and connects automatically.

### 3. Evaluation Shortcuts (Conjure)
*(All Conjure mappings start with `<localleader>` = `\`)*

| Key | Action | Description |
| :--- | :--- | :--- |
| **`\ee`** | Eval form | Evaluates innermost `(...)` under cursor |
| **`\er`** | Eval root | Evaluates top-level `defn` / `def` form |
| **`\eb`** | Eval buffer | Evaluates the entire file |
| **`\ew`** | Eval word | Evaluates the symbol under cursor |
| **`\lv`** | Log buffer (vsplit) | Opens live REPL log buffer in vertical split |
| **`\ls`** | Log buffer (split) | Opens live REPL log buffer in horizontal split |
| **`\lr`** | Reset log | Clears log buffer |

### 4. Structural Editing (Paredit)
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

### 5. External Configs for Clojure

**`~/.config/clojure/deps.edn`**:
```clojure
{:aliases
 {:nrepl
  {:extra-deps {nrepl/nrepl {:mvn/version "1.3.0"}}
   :main-opts  ["-m" "nrepl.cmdline"]}}}
```

**`~/.zprint.edn`**:
```clojure
{:style [:community, :justified, :respect-nl]}
```

---

## ⭐ Gleam Development

First-class support for Gleam and the BEAM runtime via `gleam lsp`.

### 1. Toolchain & Prerequisites
- **Gleam compiler** (`gleam`): Includes built-in language server and formatter.
- **Erlang/OTP** (>= 26).

### 2. Execution Shortcuts (`\`)
- **`\r`**: Run project root (`gleam run`)
- **`\m`**: **Run current module** (`gleam run -m <module>` — auto-detects `src/...` path)
- **`\t`**: Run tests (`gleam test`)
- **`\c`**: Fast compiler check (`gleam check`)
- **`\s`**: Launch interactive Erlang/Gleam shell (`gleam shell`)
- **`<Leader>cf`**: Auto-format buffer with `gleam format`
- **`<Leader>ca`**: Code actions (auto-import modules, generate missing case match patterns)

---

## ⚡ Zig Development

Full language support for Zig via `lazyvim.plugins.extras.lang.zig`, `zls`, and `neotest-zig`.

### 1. Toolchain & Prerequisites
- **Zig compiler** (`zig`): Installed via `mise` or system package manager.
- **zls** (Zig Language Server): Installed on PATH (`mise install zls`).

### 2. Execution Shortcuts (`\`)
- **`\r`**: Run (`zig build run` if `build.zig` exists, or `zig run <file.zig>`)
- **`\t`**: Run tests (`zig build test` or `zig test <file.zig>`)
- **`\b`**: Build project (`zig build`)
- **`<Leader>cf`**: Auto-format buffer with `zig fmt`
- **`<Leader>tt`**: Run `zig test` suite via `neotest-zig`
- **`<Leader>tr`**: Run nearest test under cursor

---

## 🦀 Rust Development

Comprehensive IDE support powered by `rustaceanvim` and `crates.nvim`.

### 1. Toolchain & Prerequisites
- **Rust toolchain** (`rustc`, `cargo`, `rust-analyzer`): Managed via `rustup` (`rustup component add rust-analyzer`).
- **rustfmt**: Included with Rust toolchain.

### 2. Features & Execution Shortcuts (`\`)
- **`\r`**: Run (`cargo run`)
- **`\t`**: Run tests (`cargo test`)
- **`\b`**: Build project (`cargo build`)
- **`\c`**: Fast typecheck (`cargo check`)
- **`<Leader>cf`**: Auto-format buffer with `rustfmt`
- **`<Leader>ca`**: Code actions (fill struct fields, implement traits, extract function)
- **Macro Expansion**: Inspect macro expansions with `:RustLsp expandMacro`
- **`Cargo.toml` Intelligence (`crates.nvim`)**: Live crate version checks, feature flags, and update notifications

---

## 🐹 Go Development

Full IDE support powered by `lazyvim.plugins.extras.lang.go`, `gopls`, `nvim-dap-go`, and `neotest-golang`.

### 1. Toolchain & Prerequisites
- **Go toolchain** (`go` >= 1.22): Installed at `/usr/local/go/bin` or system path.
- **gopls**: Official Go language server (`go install golang.org/x/tools/gopls@latest`).
- **gofumpt** & **goimports**: Auto-managed via Conform or gopls.

### 2. Features & Execution Shortcuts (`\`)
- **`\r`**: Run (`go run .` if `go.mod` exists, or `go run <file.go>`)
- **`\t`**: Run tests (`go test ./...` or `go test <file.go>`)
- **`\b`**: Build project (`go build ./...` or `go build <file.go>`)
- **`\c`**: Static analysis & vet (`go vet ./...` or `go vet <file.go>`)
- **`<Leader>cf`**: Auto-format buffer (`goimports` + `gofumpt`)
- **`<Leader>ca`**: Code actions (organize imports, fill struct fields)
- **`<Leader>tt`**: Run Go test suite via `neotest-golang`
- **`<Leader>tr`**: Run nearest test under cursor
- **`<Leader>tf`** / **`:A`**: Flip between `foo.go` ⇄ `foo_test.go`
- **`<Leader>tv`** / **`:AV`**: Open `foo_test.go` in vertical split
