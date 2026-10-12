local M = {}

--- Find the alternate path for a given filepath across Elixir, Gleam, Clojure, and Zig
---@param filepath string
---@return string?
function M.find_alternate(filepath)
  local path = filepath
  if vim.startswith(path, "./") then
    path = path:sub(3)
  end

  -- 1. Elixir: lib/...ex <-> test/..._test.exs (handles root and umbrella apps)
  if path:match("_test%.exs$") then
    local src = path:gsub("^test/", "lib/"):gsub("/test/", "/lib/"):gsub("_test%.exs$", ".ex")
    if src ~= path then return src end
  elseif path:match("%.ex$") then
    local test = path:gsub("^lib/", "test/"):gsub("/lib/", "/test/"):gsub("%.ex$", "_test.exs")
    if test ~= path then return test end
  end

  -- 2. Gleam: src/...gleam <-> test/..._test.gleam
  if path:match("_test%.gleam$") then
    local target = path:gsub("^test/", "src/"):gsub("/test/", "/src/"):gsub("_test%.gleam$", ".gleam")
    if vim.fn.filereadable(target) == 1 then
      return target
    end
    -- Fallback check for flat test directories
    local flat_target = "src/" .. vim.fn.fnamemodify(path, ":t"):gsub("_test%.gleam$", ".gleam")
    if vim.fn.filereadable(flat_target) == 1 then
      return flat_target
    end
    return target
  elseif path:match("%.gleam$") then
    local target = path:gsub("^src/", "test/"):gsub("/src/", "/test/"):gsub("%.gleam$", "_test.gleam")
    if vim.fn.filereadable(target) == 1 then
      return target
    end
    local flat_test = "test/" .. vim.fn.fnamemodify(path, ":t"):gsub("%.gleam$", "_test.gleam")
    if vim.fn.filereadable(flat_test) == 1 then
      return flat_test
    end
    return target
  end

  -- 3. Clojure: src/...clj <-> test/..._test.clj
  if path:match("_test%.clj$") then
    local src = path:gsub("^test/", "src/"):gsub("/test/", "/src/"):gsub("_test%.clj$", ".clj")
    if src ~= path then return src end
  elseif path:match("%.clj$") then
    local test = path:gsub("^src/", "test/"):gsub("/src/", "/test/"):gsub("%.clj$", "_test.clj")
    if test ~= path then return test end
  end

  -- 4. Zig: src/...zig <-> test/..._test.zig
  if path:match("_test%.zig$") then
    local src = path:gsub("^test/", "src/"):gsub("/test/", "/src/"):gsub("_test%.zig$", ".zig")
    if src ~= path then return src end
  elseif path:match("%.zig$") then
    local test = path:gsub("^src/", "test/"):gsub("/src/", "/test/"):gsub("%.zig$", "_test.zig")
    if test ~= path then return test end
  end

  return nil
end

--- Switch to the alternate file
---@param split? boolean If true, opens in a vertical split
function M.switch(split)
  local current_file = vim.fn.expand("%:.")
  if current_file == "" then
    vim.notify("No file currently open", vim.log.levels.WARN)
    return
  end

  local alt_file = M.find_alternate(current_file)
  if not alt_file then
    vim.notify("No alternate test/source file mapping found for: " .. current_file, vim.log.levels.INFO)
    return
  end

  -- Ensure parent directory exists so user can save (:w) without directory errors
  local dir = vim.fn.fnamemodify(alt_file, ":h")
  if dir ~= "." and vim.fn.isdirectory(dir) == 0 then
    vim.fn.mkdir(dir, "p")
  end

  local is_new = vim.fn.filereadable(alt_file) == 0

  if split then
    vim.cmd("vsplit " .. vim.fn.fnameescape(alt_file))
  else
    vim.cmd("edit " .. vim.fn.fnameescape(alt_file))
  end

  if is_new then
    vim.notify("Opened new file: " .. alt_file .. " (save with :w)", vim.log.levels.INFO)
  end
end

return M
