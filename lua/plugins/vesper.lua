return {
	"datsfilipe/vesper.nvim",
	config = function()
		local vesper = require("vesper")

		vesper.setup({
			italics = {
				comments = false,
				keywords = false,
				functions = false,
				strings = false,
				variables = false,
			},
			overrides = {},
		})

		-- vim.cmd.colorscheme("vesper")
	end,
}
