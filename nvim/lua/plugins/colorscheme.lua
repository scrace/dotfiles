return {
	"olivercederborg/poimandres.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		local p = require("poimandres.palette")
		require("poimandres").setup({
			disable_background = true,
			disable_float_background = true,
			dim_nc_background = true,
			disable_italics = false,
			bold_vert_split = false,
			highlight_groups = {
				LspReferenceText = { bg = p.blue4, fg = p.white },
				LspReferenceRead = { bg = p.blue4, fg = p.white },
				LspReferenceWrite = { bg = p.blue4, fg = p.white },
			},
		})
		vim.cmd.colorscheme("poimandres")
	end,
}
