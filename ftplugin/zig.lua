-- Buffer-local execution keymaps for Zig
local runner = require("config.runner")

local function has_build_zig()
  return vim.fn.findfile("build.zig", ".;") ~= ""
end

-- \r -> zig build run (or zig run <file>)
vim.keymap.set("n", "<localleader>r", function()
  if has_build_zig() then
    runner.run("zig build run")
  else
    local file = vim.fn.expand("%:.")
    runner.run("zig run " .. vim.fn.shellescape(file))
  end
end, { buffer = true, desc = "Zig: Run (build run or current file)" })

-- \t -> zig build test (or zig test <file>)
vim.keymap.set("n", "<localleader>t", function()
  if has_build_zig() then
    runner.run("zig build test")
  else
    local file = vim.fn.expand("%:.")
    runner.run("zig test " .. vim.fn.shellescape(file))
  end
end, { buffer = true, desc = "Zig: Test (build test or current file)" })

-- \b -> zig build
vim.keymap.set("n", "<localleader>b", function()
  runner.run("zig build")
end, { buffer = true, desc = "Zig: Build (zig build)" })
