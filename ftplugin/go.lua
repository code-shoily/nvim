-- Buffer-local execution keymaps for Go
local runner = require("config.runner")

local function has_go_mod()
  return vim.fn.findfile("go.mod", ".;") ~= ""
end

-- \r -> go run
vim.keymap.set("n", "<localleader>r", function()
  if has_go_mod() then
    runner.run("go run .")
  else
    local file = vim.fn.expand("%:.")
    runner.run("go run " .. vim.fn.shellescape(file))
  end
end, { buffer = true, desc = "Go: Run (go run . or current file)" })

-- \t -> go test
vim.keymap.set("n", "<localleader>t", function()
  if has_go_mod() then
    runner.run("go test ./...")
  else
    local file = vim.fn.expand("%:.")
    runner.run("go test " .. vim.fn.shellescape(file))
  end
end, { buffer = true, desc = "Go: Test (go test ./...)" })

-- \b -> go build
vim.keymap.set("n", "<localleader>b", function()
  if has_go_mod() then
    runner.run("go build ./...")
  else
    local file = vim.fn.expand("%:.")
    runner.run("go build " .. vim.fn.shellescape(file))
  end
end, { buffer = true, desc = "Go: Build (go build ./...)" })

-- \c -> go vet
vim.keymap.set("n", "<localleader>c", function()
  if has_go_mod() then
    runner.run("go vet ./...")
  else
    local file = vim.fn.expand("%:.")
    runner.run("go vet " .. vim.fn.shellescape(file))
  end
end, { buffer = true, desc = "Go: Vet (go vet ./...)" })
