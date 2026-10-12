-- Buffer-local execution keymaps for Elixir
local runner = require("config.runner")

local function has_mix()
  return vim.fn.findfile("mix.exs", ".;") ~= ""
end

-- \r -> mix run (or elixir <file.exs>)
vim.keymap.set("n", "<localleader>r", function()
  local file = vim.fn.expand("%:.")
  if file:match("%.exs$") and not file:match("_test%.exs$") then
    runner.run("elixir " .. vim.fn.shellescape(file))
  elseif has_mix() then
    runner.run("mix run")
  else
    runner.run("elixir " .. vim.fn.shellescape(file))
  end
end, { buffer = true, desc = "Elixir: Run (mix run or elixir file)" })

-- \t -> mix test (or mix test <file>)
vim.keymap.set("n", "<localleader>t", function()
  local file = vim.fn.expand("%:.")
  if file:match("_test%.exs$") then
    runner.run("mix test " .. vim.fn.shellescape(file))
  elseif has_mix() then
    runner.run("mix test")
  else
    runner.run("elixir " .. vim.fn.shellescape(file))
  end
end, { buffer = true, desc = "Elixir: Run tests (mix test)" })

-- \s -> iex -S mix (interactive IEx session)
vim.keymap.set("n", "<localleader>s", function()
  if has_mix() then
    runner.run("iex -S mix", { interactive = true })
  else
    runner.run("iex", { interactive = true })
  end
end, { buffer = true, desc = "Elixir: Interactive IEx shell" })
