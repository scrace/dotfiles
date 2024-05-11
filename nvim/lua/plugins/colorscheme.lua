return {
	"olivercederborg/poimandres.nvim",
	priority = 1000,
	config = function()
		require("poimandres").setup({
			disable_background = true,
			disable_float_background = true,
			dim_nc_background = true,
			disable_italics = false,
			bold_vert_split = false,
		})
		vim.cmd.colorscheme("poimandres")
	end,
}
