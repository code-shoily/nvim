return {
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    keys = {
      { "<leader>uu", "<cmd>UndotreeToggle<cr>", desc = "Toggle Undotree (Visual Undo History)" },
    },
    config = function()
      -- Focus undotree window automatically when opened
      vim.g.undotree_SetFocusWhenToggle = 1
      -- Layout style: tree on left, diff panel below
      vim.g.undotree_WindowLayout = 2
    end,
  },
}
