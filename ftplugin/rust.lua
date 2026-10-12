-- Buffer-local execution keymaps for Rust
local runner = require("config.runner")

-- \r -> cargo run
vim.keymap.set("n", "<localleader>r", function()
  runner.run("cargo run")
end, { buffer = true, desc = "Rust: Run (cargo run)" })

-- \t -> cargo test
vim.keymap.set("n", "<localleader>t", function()
  runner.run("cargo test")
end, { buffer = true, desc = "Rust: Test (cargo test)" })

-- \b -> cargo build
vim.keymap.set("n", "<localleader>b", function()
  runner.run("cargo build")
end, { buffer = true, desc = "Rust: Build (cargo build)" })

-- \c -> cargo check
vim.keymap.set("n", "<localleader>c", function()
  runner.run("cargo check")
end, { buffer = true, desc = "Rust: Check (cargo check)" })
