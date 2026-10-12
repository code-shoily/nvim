-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- jj exits insert mode
vim.keymap.set("i", "jj", "<Esc>", { desc = "Exit insert mode", silent = true })

-- ; enters command mode (no shift required)
-- : is mapped to ; so you still have the character-search repeat key
vim.keymap.set({ "n", "x" }, ";", ":", { desc = "Enter command mode" })
vim.keymap.set({ "n", "x" }, ":", ";", { desc = "Repeat char search (f/t)" })

-- Close floating windows or dismiss notifications with Esc
vim.keymap.set("n", "<Esc>", function()
  vim.cmd("noh")
  if pcall(require, "snacks") and Snacks and Snacks.notifier then
    Snacks.notifier.hide()
  end
  -- Close any open floating window if focused in one, or find and close any unpinned floating windows
  local cur_win = vim.api.nvim_get_current_win()
  if vim.api.nvim_win_get_config(cur_win).relative ~= "" then
    vim.api.nvim_win_close(cur_win, true)
    return
  end
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    if vim.api.nvim_win_is_valid(win) and vim.api.nvim_win_get_config(win).relative ~= "" then
      vim.api.nvim_win_close(win, true)
    end
  end
end, { desc = "Clear highlights and dismiss popups" })

-- Launch AI CLI (AGY or Claude) with persistent session and conversation continuation
local function open_ai_cli_with_context(cli_name, is_visual, layout)
  local file = vim.fn.expand("%:.") -- Relative path to project root
  local line_info
  local win_config = (layout == "float") and {
    position = "float",
    width = 0.85,
    height = 0.85,
    border = "rounded",
  } or {
    position = "right",
    width = 0.42,
  }

  local base_cmd = (cli_name == "claude") and "claude -c" or "agy -c"

  if file == "" then
    if pcall(require, "snacks") and Snacks and Snacks.terminal then
      local term = Snacks.terminal.get(base_cmd, { win = win_config, create = true })
      if term then
        term:show()
      end
    else
      vim.cmd("botright vsplit | vertical resize 60 | terminal " .. base_cmd)
    end
    return
  end

  if is_visual then
    local start_line = vim.fn.line("v")
    local end_line = vim.fn.line(".")
    if start_line > end_line then
      start_line, end_line = end_line, start_line
    end
    line_info = string.format("lines %d-%d", start_line, end_line)
  else
    local cur_line = vim.fn.line(".")
    line_info = string.format("line %d", cur_line)
  end

  local display_name = (cli_name == "claude") and "Claude" or "AGY"
  local mode_label = (layout == "float") and string.format("%s [Float]", display_name)
    or string.format("%s [Sidebar]", display_name)
  local prompt_label = string.format("%s [%s:%s]: ", mode_label, file, line_info)

  vim.ui.input({ prompt = prompt_label }, function(input)
    local full_prompt = ""
    if input and input ~= "" then
      full_prompt = string.format("Regarding %s at %s: %s", file, line_info, input)
    end

    if pcall(require, "snacks") and Snacks and Snacks.terminal then
      local term, created = Snacks.terminal.get(base_cmd, {
        win = win_config,
        create = true,
      })
      if term then
        term:show()
        if full_prompt ~= "" then
          vim.defer_fn(function()
            if term:buf_valid() then
              vim.api.nvim_chan_send(vim.bo[term.buf].channel, full_prompt .. "\r")
            end
          end, created and 800 or 100)
        end
      end
    else
      local cmd = base_cmd
      if full_prompt ~= "" then
        if cli_name == "claude" then
          cmd = string.format("claude -c %s", vim.fn.shellescape(full_prompt))
        else
          cmd = string.format("agy -c -i %s", vim.fn.shellescape(full_prompt))
        end
      end
      vim.cmd("botright vsplit | vertical resize 60 | terminal " .. cmd)
    end
  end)
end

-- =============================================================================
-- AI Assistant Shortcuts (<leader>a...)
-- =============================================================================

-- <leader>aa -> AGY Right Sidebar
vim.keymap.set("n", "<leader>aa", function()
  open_ai_cli_with_context("agy", false, "sidebar")
end, { desc = "AGY Sidebar (current line/file)" })

vim.keymap.set("v", "<leader>aa", function()
  open_ai_cli_with_context("agy", true, "sidebar")
end, { desc = "AGY Sidebar (selected lines)" })

-- <leader>aA -> AGY Floating Window
vim.keymap.set("n", "<leader>aA", function()
  open_ai_cli_with_context("agy", false, "float")
end, { desc = "AGY Floating (current line/file)" })

vim.keymap.set("v", "<leader>aA", function()
  open_ai_cli_with_context("agy", true, "float")
end, { desc = "AGY Floating (selected lines)" })

-- <leader>ac -> Claude Right Sidebar
vim.keymap.set("n", "<leader>ac", function()
  open_ai_cli_with_context("claude", false, "sidebar")
end, { desc = "Claude Sidebar (current line/file)" })

vim.keymap.set("v", "<leader>ac", function()
  open_ai_cli_with_context("claude", true, "sidebar")
end, { desc = "Claude Sidebar (selected lines)" })

-- <leader>aC -> Claude Floating Window
vim.keymap.set("n", "<leader>aC", function()
  open_ai_cli_with_context("claude", false, "float")
end, { desc = "Claude Floating (current line/file)" })

vim.keymap.set("v", "<leader>aC", function()
  open_ai_cli_with_context("claude", true, "float")
end, { desc = "Claude Floating (selected lines)" })

-- =============================================================================
-- Alternate Test / Source Switching (<leader>tf, <leader>tv, :A, :AV)
-- =============================================================================

vim.keymap.set("n", "<leader>tf", function()
  require("config.alternate").switch(false)
end, { desc = "Toggle test / source file" })

vim.keymap.set("n", "<leader>tv", function()
  require("config.alternate").switch(true)
end, { desc = "Split test / source file vertically" })

vim.api.nvim_create_user_command("A", function()
  require("config.alternate").switch(false)
end, { desc = "Edit alternate test/source file" })

vim.api.nvim_create_user_command("AV", function()
  require("config.alternate").switch(true)
end, { desc = "Open alternate test/source file in vertical split" })

