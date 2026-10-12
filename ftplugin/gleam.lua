-- Buffer-local execution keymaps for Gleam
local runner = require("config.runner")

-- \r -> gleam run (project root)
vim.keymap.set("n", "<localleader>r", function()
  runner.run("gleam run")
end, { buffer = true, desc = "Gleam: Run project (gleam run)" })

-- \m -> gleam run -m <module> (current module)
vim.keymap.set("n", "<localleader>m", function()
  local file = vim.fn.expand("%:.")
  local mod = file:match("^src/(.+)%.gleam$")
  if mod then
    runner.run("gleam run -m " .. mod)
  else
    local test_mod = file:match("^test/(.+)%.gleam$")
    if test_mod then
      runner.run("gleam test -- --match " .. test_mod)
    else
      runner.run("gleam run")
    end
  end
end, { buffer = true, desc = "Gleam: Run current module (gleam run -m ...)" })

-- \t -> gleam test
vim.keymap.set("n", "<localleader>t", function()
  runner.run("gleam test")
end, { buffer = true, desc = "Gleam: Run tests (gleam test)" })

-- \c -> gleam check
vim.keymap.set("n", "<localleader>c", function()
  runner.run("gleam check")
end, { buffer = true, desc = "Gleam: Typecheck (gleam check)" })

-- \s -> gleam shell (interactive Erlang/Gleam REPL)
vim.keymap.set("n", "<localleader>s", function()
  runner.run("gleam shell", { interactive = true })
end, { buffer = true, desc = "Gleam: Interactive shell (gleam shell)" })
