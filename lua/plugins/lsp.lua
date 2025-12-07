return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      -- Ensure biome is set up
      opts.servers = opts.servers or {}
      opts.servers.biome = opts.servers.biome or {}

      -- Override vtsls keys to use biome for organize imports
      if opts.servers.vtsls then
        opts.servers.vtsls.keys = opts.servers.vtsls.keys or {}
        -- Find and replace the organize imports key
        for i, key in ipairs(opts.servers.vtsls.keys) do
          if key[1] == "<leader>co" then
            -- Replace with biome organize imports
            opts.servers.vtsls.keys[i] = {
              "<leader>co",
              function()
                vim.lsp.buf.code_action({
                  context = {
                    only = { "source.organizeImports.biome" },
                    diagnostics = {},
                  },
                  apply = true,
                })
              end,
              desc = "Organize Imports (Biome)",
            }
            break
          end
        end
      end

      return opts
    end,
    inlay_hints = {
      enabled = false,
    },
  },
}
