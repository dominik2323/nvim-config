return {
	"RaafatTurki/hex.nvim",
	config = function()
		local hex = require("hex")
		hex.setup()
		vim.keymap.set("n", "mm", function()
			hex.toggle()
		end, {})
	end,
}
