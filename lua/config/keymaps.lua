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

-- Launch Antigravity (AGY) with persistent session and conversation continuation
local function open_agy_with_context(is_visual, layout)
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

  if file == "" then
    if pcall(require, "snacks") and Snacks and Snacks.terminal then
      local term = Snacks.terminal.get("agy -c", { win = win_config, create = true })
      if term then
        term:show()
      end
    else
      vim.cmd("botright vsplit | vertical resize 60 | terminal agy -c")
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

  local mode_label = (layout == "float") and "AGY [Float]" or "AGY [Sidebar]"
  local prompt_label = string.format("%s [%s:%s]: ", mode_label, file, line_info)

  vim.ui.input({ prompt = prompt_label }, function(input)
    local full_prompt = ""
    if input and input ~= "" then
      full_prompt = string.format("Regarding %s at %s: %s", file, line_info, input)
    end

    if pcall(require, "snacks") and Snacks and Snacks.terminal then
      local term, created = Snacks.terminal.get("agy -c", {
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
      local cmd = "agy -c"
      if full_prompt ~= "" then
        cmd = string.format("agy -c -i %s", vim.fn.shellescape(full_prompt))
      end
      vim.cmd("botright vsplit | vertical resize 60 | terminal " .. cmd)
    end
  end)
end

-- <leader>aa -> Right Sidebar (Code on left, AGY on right)
vim.keymap.set("n", "<leader>aa", function()
  open_agy_with_context(false, "sidebar")
end, { desc = "AGY Sidebar (current line/file)" })

vim.keymap.set("v", "<leader>aa", function()
  open_agy_with_context(true, "sidebar")
end, { desc = "AGY Sidebar (selected lines)" })

-- <leader>aA -> Floating Window (Center overlay)
vim.keymap.set("n", "<leader>aA", function()
  open_agy_with_context(false, "float")
end, { desc = "AGY Floating (current line/file)" })

vim.keymap.set("v", "<leader>aA", function()
  open_agy_with_context(true, "float")
end, { desc = "AGY Floating (selected lines)" })

