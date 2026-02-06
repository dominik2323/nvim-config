return {
	{
		"smoka7/hop.nvim",
		version = "*",
		opts = {
			keys = "etovxqpdygfblzhckisuran",
		},
		config = function()
			local hop = require("hop")
			hop.setup({})
			vim.keymap.set("n", "s", function()
				hop.hint_char2()
			end, {})
			vim.keymap.set("n", "f", function()
				hop.hint_char1({ current_line_only = true })
			end, {})
		end,
	},
}
