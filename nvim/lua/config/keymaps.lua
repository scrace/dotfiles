local keymap = vim.keymap
local opts = { noremap = true, silent = true }
local util = require("lazyvim.util")

local function map(mode, l, r, opts)
	opts = opts or {}
	keymap.set(mode, l, r, opts)
end

local handle_punctuation

-- Illegal stuff --
-- Move
map("n", "a", "h", opts)
map("n", "s", "j", opts)

map("i", "<C-k>", "<Up>", opts)
map("i", "<C-s>", "<Down>", opts)
map("i", "<C-a>", "<Left>", opts)
map("i", "<C-l>", "<Right>", opts)

map("i", "<M-k>", "<Up>", opts)
map("i", "<M-s>", "<Down>", opts)
map("i", "<M-a>", "<Left>", opts)
map("i", "<M-l>", "<Right>", opts)

map("n", "q", "b", opts)
map("n", "Q", "B", opts)

-- Scroll Up/Down
map("n", "<M-S-k>", "<C-u>", opts)
map("n", "<M-S-s>", "<C-d>", opts)

map("n", "G", "gg", opts)
map("n", "gg", "G", opts)

map({ "i", "v", "o", "x" }, "<F12>", "<Esc>", opts)
map({ "i", "v", "o", "x" }, "<C-c>", "<Esc>", opts)

map("n", "<Enter>", "o", opts)
map("n", "<S-Enter>", "O", opts)
-- map("i", "<M-Enter>", "M-o", opts)
-- map("i", "<M-S-Enter>", "M-O", opts)

-- Insert Semicolon EOL
map("n", "<M-;>", function()
	return handle_punctuation(";", ",", false)()
end, opts)

map("i", "<M-;>", function()
	return handle_punctuation(";", ",", true)()
end, opts)

-- Insert Comma EOL
map("n", "<M-,>", function()
	return handle_punctuation(",", ";", false)()
end, opts)

map("i", "<M-,>", function()
	return handle_punctuation(",", ";", true)()
end, opts)

-- Go to previous file
map("n", "gp", ":e#<CR>", opts)

-- Replace word under cursor
map("n", "<leader>ss", "*:%s///c<left><left>", {
	noremap = true,
})
-- Replace selection
map("x", "<leader>ss", "y:%s/<C-r>0//c<left><left>", {
	noremap = true,
})

-- Paste last yanked
map("n", ",P", '"0P', opts)
map("n", ",p", '"0p', opts)

-- Duplicate line/selection up/down
map("n", "<leader>dk", "yyP", opts)
map("n", "<leader>ds", "yyp", opts)
map("x", "<leader>dk", "yP", opts)
map("x", "<leader>ds", "y'>p", opts)

-- Increment/decrement
map("n", "+", "<C-a>")
map("n", "-", "<C-x>")

-- Select all
map("n", "<C-a>", "gg<S-v>G")

-- Clear highlight-search on pressing <Esc> in normal mode
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Save only when there's changes
map("n", "<C-s>", ":up<CR>", opts)

-- Save file and quit
map("n", "<Leader>w", ":update<CR>", opts)
map("n", "<Leader>q", ":quit<CR>", opts)
map("n", "<Leader>Q", ":qa<CR>", opts)

map("n", ";t", function()
	util.terminal()
end, { desc = "Terminal (cwd)" })
map("t", "<F12>", "<cmd>close<cr>", { desc = "Close Terminal" })
map("t", "<C-c>", "<cmd>close<cr>", { desc = "Close Terminal" })

-- File explorer with NvimTree
map("n", "<Leader>f", ":NvimTreeFindFile<CR>", opts)
map("n", "<Leader>t", ":NvimTreeToggle<CR>", opts)

-- Tabs
-- map("n", "tn", ":tabnew<CR>")
map("n", "tn", function()
	vim.cmd("tabnew")
	require("telescope.builtin").find_files()
end, { desc = "New Tab with File Picker" })
map("n", "te", ":tabedit<CR>")
map("n", "<tab>", ":tabnext<CR>", opts)
map("n", "<s-tab>", ":tabprev<CR>", opts)
map("n", "tw", ":tabclose<CR>", opts)

-- Split window
map("n", "<Leader>h", ":split<CR>", opts)
map("n", "<Leader>v", ":vsplit<CR>", opts)

-- Window navigation
map("n", "<Leader>a", "<C-w>h", opts)
map("n", "<Leader>l", "<C-w>l", opts)
map("n", "<Leader>k", "<C-w>k", opts)
map("n", "<Leader>s", "<C-w>j", opts)
map("n", "<C-c>", "<C-w>c", opts)
map("n", "<F13>", "<C-w>c", opts)

-- Move window
map("n", "<C-w>a", "<C-w>H", opts)
map("n", "<C-w>l", "<C-w>L", opts)
map("n", "<C-w>k", "<C-w>K", opts)
map("n", "<C-w>s", "<C-w>J", opts)

-- Resize window
map("n", "<C-M-s>", ":resize -2<CR>", opts)
map("n", "<C-M-k>", ":resize +2<CR>", opts)
map("n", "<C-M-a>", ":vertical resize -2<CR>", opts)
map("n", "<C-M-l>", ":vertical resize +2<CR>", opts)

-- Diagnostic keymaps
map("n", "[d", vim.diagnostic.goto_prev)
map("n", "]d", vim.diagnostic.goto_next)
map("n", "<leader>e", vim.diagnostic.open_float)
map("n", "<leader>q", vim.diagnostic.setloclist)

-- Disable arrow keys (I tend to use these -> good for learning)
map("n", "<left>", "<Nop>")
map("n", "<right>", "<Nop>")
map("n", "<up>", "<Nop>")
map("n", "<down>", "<Nop>")

-- Windows/Wsl specific --
-- Remove ^M all Characters which are inserted in wsl terminals
map("n", ",m", function()
	vim.cmd(":%s/\r//g")
end)

-- Helper --
-- Helper function to handle punctuation at EOL
handle_punctuation = function(char_to_add, blocking_char, in_insert_mode)
	return function()
		local line = vim.api.nvim_get_current_line()
		local pos = vim.api.nvim_win_get_cursor(0)

		if line:match(blocking_char .. "$") then
			-- Do nothing if blocking character exists
			if in_insert_mode then
				vim.cmd("startinsert")
			end
			return
		elseif line:match(char_to_add .. "$") then
			-- Remove character if it exists
			vim.cmd("normal! $x")
			vim.api.nvim_win_set_cursor(0, pos)
			if in_insert_mode then
				vim.cmd("startinsert")
			end
		else
			-- Add character if no punctuation exists
			vim.cmd("normal! A" .. char_to_add)
			vim.api.nvim_win_set_cursor(0, pos)
			if in_insert_mode then
				vim.cmd("startinsert")
			end
		end
	end
end
