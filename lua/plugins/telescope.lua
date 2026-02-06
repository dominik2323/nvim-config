return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"https://git.myzel394.app/Myzel394/jsonfly.nvim",
		"nvim-telescope/telescope-file-browser.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
	},
	config = function()
		vim.keymap.set("n", "ff", ":Telescope find_files<CR>")
		vim.keymap.set("n", "fs", ":Telescope live_grep<CR>")
		vim.keymap.set("n", "fb", ":Telescope buffers<CR>")
		vim.keymap.set("n", "fj", ":Telescope jsonfly<CR>")
		vim.keymap.set("n", "fl", ":Telescope file_browser<CR>")
		vim.keymap.set("n", "fq", "<cmd>Telescope quickfix<cr>", { desc = "Telescope Quickfix" })

		local actions = require("telescope.actions")
		local telescope = require("telescope")

		telescope.setup({
			extensions = {
				fzf = {
					fuzzy = true, -- false will only do exact matching
					override_generic_sorter = true, -- override the generic sorter
					override_file_sorter = true, -- override the file sorter
					case_mode = "smart_case", -- or "ignore_case" or "respect_case"
				},
			},
			defaults = {
				mappings = {
					i = {
						["<leader>l"] = actions.send_to_qflist,
					},
					n = {
						["<leader>l"] = actions.send_to_qflist,
					},
				},
			},
		})

		telescope.load_extension("fzf")
		telescope.load_extension("jsonfly")
		telescope.load_extension("file_browser")
	end,
}
