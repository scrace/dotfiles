vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.noremap({ "n", "v", "o", "x" }, "<C-c>", "<Esc>")
vim.keymap.noremap({ "n", "v", "o", "x" }, "<F24>", "<Esc>")

-- Clear highlight-search on pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Disable arrow keys (I tend to use these -> good for learning)
vim.keymap.set("n", "<left>")
vim.keymap.set("n", "<right>")
vim.keymap.set("n", "<up>")
vim.keymap.set("n", "<down>")

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
