-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- jj exits insert mode
vim.keymap.set("i", "jj", "<Esc>", { desc = "Exit insert mode", silent = true })

-- ; enters command mode (no shift required)
-- : is mapped to ; so you still have the character-search repeat key
vim.keymap.set({ "n", "x" }, ";", ":", { desc = "Enter command mode" })
vim.keymap.set({ "n", "x" }, ":", ";", { desc = "Repeat char search (f/t)" })
