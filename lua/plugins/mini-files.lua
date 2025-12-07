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
        permanent_delete = false,
      },
      mappings = {
        go_in = "l",
        go_in_plus = "<CR>",
        go_out = "H",
        go_out_plus = "h",
        reset = ",",
        reveal_cwd = ".",
        show_help = "g?",
      },
      windows = {
        preview = true,
        width_focus = 30,
        -- width_nofocus = 15,
        width_preview = 50,
      },
    },
    keys = {
      {
        "<leader>e",
        function()
          if not require("mini.files").close() then
            local current_file = vim.api.nvim_buf_get_name(0)
            if current_file ~= "" then
              require("mini.files").open(current_file, true)
            else
              require("mini.files").open(LazyVim.root(), true)
            end
          end
        end,
        desc = "Toggle mini.files (Current File)",
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

      -- Custom delete function that moves files to trash
      local files_trash = function()
        local cur_entry = require("mini.files").get_fs_entry()
        if cur_entry == nil then
          return
        end

        local response = vim.fn.input({
          prompt = "Trash " .. vim.fn.fnamemodify(cur_entry.path, ":t") .. "? (y/n): ",
        })

        if response:lower() == "y" then
          vim.fn.system({ "trash", cur_entry.path })
          require("mini.files").synchronize()
        end
      end

      -- Add keymaps when mini.files buffer is created
      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesBufferCreate",
        callback = function(args)
          local buf_id = args.data.buf_id
          -- Toggle hidden files with 'g.'
          vim.keymap.set("n", "g.", toggle_dotfiles, { buffer = buf_id, desc = "Toggle hidden files" })
          -- Move to trash with 'gd'
          vim.keymap.set("n", "gd", files_trash, { buffer = buf_id, desc = "Move to trash" })
        end,
      })
    end,
  },
}
