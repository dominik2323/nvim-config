local opts = { noremap = true, silent = true }

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.keymap.set("n", "<leader>w", ":w<CR>", opts)
vim.keymap.set("n", "<leader>q", ":q<CR>", opts)
-- vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", opts)
vim.keymap.set("n", "<leader>j", ":bprev<CR>", opts)
vim.keymap.set("n", "<leader>k", ":bnext<CR>", opts)
vim.keymap.set("n", "<leader>s", ":update<CR> :source<CR>", opts)

-- buffers
vim.keymap.set("n", "<C-w>b", ":update<CR> :source<CR>", opts)
vim.keymap.set("n", "<leader-c>q", ":update<CR> :source<CR>", opts)

-- splits
vim.keymap.set("n", "<C-w>v", ":vsplit<CR>", opts)
vim.keymap.set("n", "<C-w>g", ":vertical resize +10<CR>", opts)
vim.keymap.set("n", "<C-w>s", ":vertical resize -10<CR>", opts)

-- centered scrolling
vim.keymap.set("n", "<C-y>", "kzz", opts)
vim.keymap.set("n", "<C-e>", "jzz", opts)
