return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = false, -- Disable default explorer
  },
  {
    "nvim-mini/mini.files",
    opts = {
      content = {
        filter = nil, -- Show all files including hidden ones by default
      },
      options = {
        use_as_default_explorer = true,
      },
      windows = {
        preview = true,
        width_focus = 30,
        width_nofocus = 15,
        width_preview = 50,
      },
    },
    keys = {
      {
        "<leader>e",
        function()
          if not require("mini.files").close() then
            require("mini.files").open(LazyVim.root(), true)
          end
        end,
        desc = "Toggle mini.files (Root Dir)",
      },
      {
        "<leader>E",
        function()
          if not require("mini.files").close() then
            require("mini.files").open(vim.uv.cwd(), true)
          end
        end,
        desc = "Toggle mini.files (cwd)",
      },
    },
    config = function(_, opts)
      require("mini.files").setup(opts)

      -- Custom function to toggle hidden files visibility
      local show_dotfiles = true

      local filter_show = function()
        return true
      end

      local filter_hide = function(fs_entry)
        return not vim.startswith(fs_entry.name, ".")
      end

      local toggle_dotfiles = function()
        show_dotfiles = not show_dotfiles
        local new_filter = show_dotfiles and filter_show or filter_hide
        require("mini.files").refresh({ content = { filter = new_filter } })
      end

      -- Add keymap to toggle hidden files with 'g.'
      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesBufferCreate",
        callback = function(args)
          local buf_id = args.data.buf_id
          vim.keymap.set("n", "g.", toggle_dotfiles, { buffer = buf_id, desc = "Toggle hidden files" })
        end,
      })
    end,
  },
}
