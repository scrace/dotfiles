local opt = vim.opt

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = false

vim.scriptencoding = "utf-8"
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"

opt.title = true
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.showmode = false
opt.showcmd = true
opt.cmdheight = 0
opt.laststatus = 0
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true
opt.splitright = true
opt.splitbelow = true
opt.splitkeep = "cursor"
opt.termguicolors = true
opt.scrolloff = 10
opt.signcolumn = "yes"
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

opt.expandtab = true
opt.autoindent = true
opt.smartindent = true
opt.smarttab = true
opt.backspace = { "start", "eol", "indent" }

opt.undofile = true
opt.backup = false
opt.autoread = true
opt.autowrite = true
opt.autowriteall = true

opt.mouse = ""
opt.inccommand = "split"
opt.path:append({ "**" })
opt.wildignore:append({ "*/node_modules/*" })
opt.formatoptions:append({ "r" }) -- Add asterisks in block comments

opt.updatetime = 100
opt.timeoutlen = 300
