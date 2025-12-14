return {
  "folke/snacks.nvim",
  opts = {
    -- Disable the Snacks file explorer since we're using mini.files
    explorer = {
      enabled = false,
    },
  },
  keys = {
    {
      "<leader>ff",
      function()
        Snacks.picker.files({ cwd = vim.fn.getcwd() })
      end,
      desc = "Find Files (cwd)",
    },
    {
      "<leader>fF",
      function()
        Snacks.picker.files()
      end,
      desc = "Find Files (Root)",
    },
  },
}
