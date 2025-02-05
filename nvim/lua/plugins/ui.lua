return {
	{
		"nvimdev/dashboard-nvim",
		enabled = false,
	},
	{
		"akinsho/bufferline.nvim",
		enabled = false,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		enabled = false,
	},
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			local function filepath()
				return vim.fn.expand("%:p")
			end

			local function filename()
				return vim.fn.expand("%:t")
			end

			require("lualine").setup({
				options = {
					icons_enabled = true,
					theme = "auto",
					disabled_filetypes = {},
					component_separators = "",
					section_separators = { left = "", right = "" },
					always_divide_middle = true,
					globalstatus = false,
				},
				sections = {
					lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
					lualine_b = { { "filename", file_status = true, path = 3 } },
					lualine_c = {},
					lualine_x = {},
					lualine_y = { "branch", "diff" },
					lualine_z = { "location" },
				},
				inactive_sections = {
					lualine_a = { "filename" },
					lualine_b = {},
					lualine_c = {},
					lualine_x = {},
					lualine_y = {},
					lualine_z = { { "location", separator = { right = "" }, left_padding = 2 } },
				},
				tabline = {},
				extensions = {},
			})
		end,
	},
	-- messages, cmdline and the popupmenu
	{
		"folke/noice.nvim",
		opts = function(_, opts)
			table.insert(opts.routes, {
				filter = {
					event = "notify",
					find = "No information available",
				},
				opts = { skip = true },
			})
			local focused = true
			vim.api.nvim_create_autocmd("FocusGained", {
				callback = function()
					focused = true
				end,
			})
			vim.api.nvim_create_autocmd("FocusLost", {
				callback = function()
					focused = false
				end,
			})
			table.insert(opts.routes, 1, {
				filter = {
					cond = function()
						return not focused
					end,
				},
				view = "notify_send",
				opts = { stop = false },
			})

			opts.commands = {
				all = {
					-- options for the message history that you get with `:Noice`
					view = "split",
					opts = { enter = true, format = "details" },
					filter = {},
				},
			}

			opts.presets.lsp_doc_border = true
		end,
	},
	{
		"rcarriga/nvim-notify",
		opts = {
			timeout = 8000,
			background_colour = "#000000",
			render = "wrapped-compact",
		},
	},
	-- filename
	-- {
	-- 	"b0o/incline.nvim",
	-- 	dependencies = { "nvim-tree/nvim-web-devicons" },
	-- 	config = function()
	-- 		local devicons = require("nvim-web-devicons")
	-- 		require("incline").setup({
	-- 			window = {
	-- 				padding = 0,
	-- 				margin = {
	-- 					horizontal = 0,
	-- 					vertical = 0,
	-- 				},
	-- 				placement = {
	-- 					horizontal = "center",
	-- 					vertical = "top",
	-- 				},
	-- 			},
	-- 			render = function(props)
	-- 				local lazy_icons = require("lazyvim.config").icons
	--
	-- 				local function get_file_name()
	-- 					local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
	-- 					if filename == "" then
	-- 						filename = "[No Name]"
	-- 					end
	-- 					local ft_icon, ft_color = devicons.get_icon_color(filename)
	-- 					local modified = vim.bo[props.buf].modified
	-- 					local label = {}
	--
	-- 					table.insert(label, { (ft_icon or "") .. " ", guifg = ft_color, guibg = "none" })
	-- 					table.insert(label, { filename, gui = modified and "bold,italic" or "bold" })
	-- 					if #label > 0 then
	-- 						table.insert(label, { "" })
	-- 					end
	-- 					return label
	-- 				end
	--
	-- 				local function get_diagnostics()
	-- 					local icons = {
	-- 						error = lazy_icons.diagnostics.Error,
	-- 						warn = lazy_icons.diagnostics.Warn,
	-- 						info = lazy_icons.diagnostics.Info,
	-- 						hint = lazy_icons.diagnostics.Hint,
	-- 					}
	-- 					local labels = {}
	--
	-- 					for severity, icon in pairs(icons) do
	-- 						local n = #vim.diagnostic.get(
	-- 							props.buf,
	-- 							{ severity = vim.diagnostic.severity[string.upper(severity)] }
	-- 						)
	-- 						if n > 0 then
	-- 							table.insert(labels, { " " .. icon .. n, group = "DiagnosticSign" .. severity })
	-- 						end
	-- 					end
	-- 					if #labels > 0 then
	-- 						table.insert(labels, { " " })
	-- 					end
	-- 					return labels
	-- 				end
	--
	-- 				local function get_git_diff()
	-- 					local icons = { removed = " ", changed = " ", added = " " }
	-- 					local signs = vim.b[props.buf].gitsigns_status_dict
	-- 					local labels = {}
	-- 					if signs == nil then
	-- 						return labels
	-- 					end
	-- 					for name, icon in pairs(icons) do
	-- 						if tonumber(signs[name]) and signs[name] > 0 then
	-- 							table.insert(labels, { icon .. signs[name] .. " ", group = "Diff" .. name })
	-- 						end
	-- 					end
	-- 					return labels
	-- 				end
	--
	-- 				return {
	-- 					{ get_file_name() },
	-- 					{ get_diagnostics() },
	-- 					--{ get_git_diff() },
	-- 				}
	-- 			end,
	-- 		})
	-- 	end,
	-- },
	-- LazyGit integration with Telescope
	{
		"kdheepak/lazygit.nvim",
		keys = {
			{
				";c",
				":LazyGit<Return>",
				silent = true,
				noremap = true,
			},
		},
		-- Optional for floating window border decoration
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	-- Database Interface
	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = {
			{ "tpope/vim-dadbod", lazy = true },
			{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
		},
		cmd = {
			"DBUI",
			"DBUIToggle",
			"DBUIAddConnection",
			"DBUIFindBuffer",
		},
		init = function()
			-- Your DB UI configuration
			vim.g.db_ui_use_nerd_fonts = 1
		end,
		keys = {
			{

				"<leader>d",
				"<cmd>NvimTreeClose<cr><cmd>tabnew<cr><bar><bar><cmd>DBUI<cr>",
			},
		},
	},
	-- File explorer
	{
		"nvim-tree/nvim-tree.lua",
		config = function()
			require("nvim-tree").setup({
				on_attach = function(bufnr)
					local api = require("nvim-tree.api")

					local function opts(desc)
						return {
							desc = "nvim-tree: " .. desc,
							buffer = bufnr,
							noremap = true,
							silent = true,
							nowait = true,
						}
					end

					-- default mappings
					api.config.mappings.default_on_attach(bufnr)

					-- custom mappings
					vim.keymap.del("n", "s", { buffer = bufnr })
					vim.keymap.del("n", "a", { buffer = bufnr })
					vim.keymap.set("n", "t", api.node.open.tab, opts("Tab"))
					vim.keymap.set("n", "n", api.fs.create, opts("Create File or Directory"))
				end,
				actions = {
					open_file = {
						quit_on_open = true,
					},
				},
				sort = {
					sorter = "case_sensitive",
				},
				view = {
					width = 30,
					relativenumber = true,
				},
				renderer = {
					group_empty = true,
				},
				filters = {
					dotfiles = false,
					custom = {
						"node_modules/.*",
					},
				},
				log = {
					enable = true,
					truncate = true,
					types = {
						diagnostics = true,
						git = true,
						profile = true,
						watcher = true,
					},
				},
			})

			if vim.fn.argc(-1) == 0 then
				vim.cmd("NvimTreeFocus")
			end
		end,
	},
}
