-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Ensure mise shims and cargo bin are in PATH for Neovim and LSP servers
local mise_shims = vim.fn.expand("~/.local/share/mise/shims")
local cargo_bin = vim.fn.expand("~/.cargo/bin")
vim.env.PATH = mise_shims .. ":" .. cargo_bin .. ":" .. vim.env.PATH

-- GUI Font (Caskaydia Cove Nerd Font)
vim.opt.guifont = "CaskaydiaCove Nerd Font:h13"

-- Fast keycode & mapping timeout
vim.opt.timeoutlen = 300

-- Ensure auto pairs is always enabled by default
vim.g.minipairs_disable = false
