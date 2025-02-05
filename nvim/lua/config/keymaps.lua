local keymap = vim.keymap
local opts = { noremap = true, silent = true }
local util = require("lazyvim.util")

local function map(mode, l, r, opts)
	opts = opts or {}
	keymap.set(mode, l, r, opts)
end

-- Illegal stuff
map("n", "a", "h", opts)
map("n", "s", "j", opts)

map("i", "<C-k>", "<Up>", opts)
map("i", "<C-s>", "<Down>", opts)
map("i", "<C-a>", "<Left>", opts)
map("i", "<C-l>", "<Right>", opts)

map("n", "q", "b", opts)
map("n", "Q", "B", opts)

map({ "i", "v", "o", "x" }, "<F12>", "<Esc>", opts)
map({ "i", "v", "o", "x" }, "<C-c>", "<Esc>", opts)

map("n", "G", "gg", opts)
map("n", "gg", "G", opts)

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
map("n", "<Leader>w", ":update<Return>", opts)
map("n", "<Leader>q", ":quit<Return>", opts)
map("n", "<Leader>Q", ":qa<Return>", opts)

map("n", ";t", function()
	util.terminal()
end, { desc = "Terminal (cwd)" })
map("t", "<F12>", "<cmd>close<cr>", { desc = "Close Terminal" })
map("t", "<C-c>", "<cmd>close<cr>", { desc = "Close Terminal" })

-- File explorer with NvimTree
map("n", "<Leader>f", ":NvimTreeFindFile<Return>", opts)
map("n", "<Leader>t", ":NvimTreeToggle<Return>", opts)

-- Tabs
map("n", "te", ":tabedit")
map("n", "<tab>", ":tabnext<Return>", opts)
map("n", "<s-tab>", ":tabprev<Return>", opts)
map("n", "tw", ":tabclose<Return>", opts)

-- Split window
map("n", "<Leader>h", ":split<Return>", opts)
map("n", "<Leader>v", ":vsplit<Return>", opts)

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
map("n", "<M-s>", ":resize -2<CR>", opts)
map("n", "<M-k>", ":resize +2<CR>", opts)
map("n", "<M-a>", ":vertical resize -2<CR>", opts)
map("n", "<M-l>", ":vertical resize +2<CR>", opts)

-- Scroll Up/Down
map("n", "K", "C-U", opts)
map("n", "S", "C-D", opts)

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
