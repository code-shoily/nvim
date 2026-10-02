return {
  -- Configure Dexter LSP for Elixir
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      local configs = require("lspconfig.configs")

      if not configs.dexter then
        configs.dexter = {
          default_config = {
            cmd = { "dexter", "lsp" },
            filetypes = { "elixir", "eelixir", "heex" },
            root_dir = require("lspconfig.util").root_pattern("mix.exs", ".git"),
            settings = {},
          },
        }
      end

      opts.servers = opts.servers or {}
      -- Enable Dexter LSP
      opts.servers.dexter = opts.servers.dexter or {}
      -- Disable elixirls in favor of Dexter
      opts.servers.elixirls = { enabled = false }
    end,
  },
}
