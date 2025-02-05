return {
	{
		"nvim-treesitter/nvim-treesitter",
		tag = "v0.9.1",
		opts = {
			ignore_install = {
				"printf",
				"xml",
			},
			ensure_installed = {
				"javascript",
				"typescript",
				"css",
				"gitignore",
				"graphql",
				"http",
				"json",
				"scss",
				"sql",
				"vim",
				"lua",
				"rust",
			},
			auto_install = true,
			query_linter = {
				enable = true,
				use_virtual_text = true,
				lint_events = { "BufWrite", "CursorHold" },
			},
		},
	},
}
