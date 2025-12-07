-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Save
vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save file" })

-- Move lines
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")

-- Delete to black hole
vim.keymap.set("n", "D", '"_d$', { noremap = true, silent = true, desc = "Delete to end of line" })

vim.keymap.set("n", "dw", '"_dw', { noremap = true, silent = true, desc = "Delete word without overwriting clipboard" })
vim.keymap.set("n", "dd", '"_dd', { noremap = true, silent = true, desc = "Delete line without overwriting clipboard" })
vim.keymap.set("n", "DD", "dd", { noremap = true, silent = true, desc = "Delete line" })
vim.keymap.set(
  "n",
  "diw",
  '"_diw',
  { noremap = true, silent = true, desc = "Delete in word without overwriting clipboard" }
)
