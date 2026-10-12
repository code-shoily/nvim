local M = {}

--- Run a command in a dedicated bottom terminal split
---@param cmd string
---@param opts? { win?: table, interactive?: boolean }
function M.run(cmd, opts)
  opts = opts or {}
  local interactive = opts.interactive or false
  local win_config = opts.win or {
    position = "bottom",
    height = 0.35,
  }

  if pcall(require, "snacks") and Snacks and Snacks.terminal then
    local existing = Snacks.terminal.get(cmd, { create = false })
    if existing and existing:valid() then
      existing:close()
    end
    Snacks.terminal.open(cmd, {
      win = win_config,
      interactive = interactive,
      auto_close = interactive,
      start_insert = interactive,
    })
  else
    vim.cmd("botright split | resize 15 | terminal " .. cmd)
  end
end

return M
