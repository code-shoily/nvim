return {
  {
    "Olical/conjure",
    opts = {},
    config = function(_, _)
      require("conjure.main").main()

      -- Hook into Conjure's close-hud event to force a redraw when the HUD closes
      local hook = require("conjure.hook")
      local log = require("conjure.log")
      hook.override("close-hud", function()
        if log.state.hud.id then
          pcall(vim.api.nvim_win_close, log.state.hud.id, true)
          log.state.hud.id = nil
          vim.schedule(function()
            vim.cmd("redraw!")
            vim.cmd("mode")
          end)
        end
      end)
    end,
  },
}
