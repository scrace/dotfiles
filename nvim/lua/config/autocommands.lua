local autogroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local opt = vim.opt

autocmd("TextYankPost", {
	group = autogroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

local function set_tab_options()
	local filetype = vim.bo.filetype

	opt.tabstop = 4
	opt.softtabstop = 4
	opt.shiftwidth = 4

	if
		filetype == "javascript"
		or filetype == "typescript"
		or filetype == "javascriptreact"
		or filetype == "typescriptreact"
		or filetype == "html"
		or filetype == "css"
	then
		opt.tabstop = 2
		opt.softtabstop = 2
		opt.shiftwidth = 2
	end
end

autocmd("SetTabOptions", {
	group = autogroup("tab-options", { clear = false }),
	callback = function()
		set_tab_options()
	end,
})
