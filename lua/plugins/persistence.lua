return {
  "folke/persistence.nvim",
  event = "BufReadPre", -- this will only start session saving when an actual file was opened
  opts = {},
  config = function()
    vim.keymap.set("n", "<leader>qs", function()
      require("persistence").load()
    end)
  end,
}
