return {
	{
		"nvimdev/dashboard-nvim",
		enabled = false,
	},
	{
		"nvim-lualine/lualine.nvim",
		enabled = false,
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
			timeout = 10000,
			background_colour = "#000000",
			render = "wrapped-compact",
		},
	},

	-- buffer line
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		keys = {
			{ "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
			{ "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
		},
		opts = {
			options = {
				mode = "tabs",
				show_buffer_close_icons = false,
				show_close_icon = false,
			},
		},
	},

	-- filename
	{
		"b0o/incline.nvim",
		dependencies = {},
		event = "BufReadPre",
		priority = 1200,
		config = function()
			local devicons = require 'nvim-web-devicons'
			require("incline").setup({
				window = {
					padding = 0,
					margin = {
						horizontal = 0,
						vertical = 0,
					},
					placement = {
						horizontal = "center",
						vertical = "top",
					},
				},
				render = function(props)
					local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
					if filename == "" then
			      filename = "[No Name]"
	    		end
					local ft_icon, ft_color = devicons.get_icon_color(filename)

			    local function get_file_name()
			      local label = {}
			      table.insert(label, { (ft_icon or "") .. " ", guifg = ft_color, guibg = "none" })
			      table.insert(label, { vim.bo[props.buf].modified and " " or "", guifg = "#d19a66" })
			      table.insert(
			        label,
			        { filename , gui = vim.bo[props.buf].modified and "bold,italic" or "bold" }
			      )
			      if not props.focused then
			        label["group"] = "BufferInactive"
			      end
			      if #label > 0 then
			        table.insert(label, { " | " })
			      end

			      return label
			    end

			    local function get_git_diff()
			      local icons = { removed = " ", changed = " ", added = " " }
			      local signs = vim.b[props.buf].gitsigns_status_dict
			      local labels = {}
			      if signs == nil then
			        return labels
			      end
			      for name, icon in pairs(icons) do
			        if tonumber(signs[name]) and signs[name] > 0 then
			          table.insert(labels, { icon .. signs[name] .. " ", group = "Diff" .. name })
			        end
			      end
           	if #labels > 0 then
        			table.insert(labels, { " | " })
      		 	end
			      return labels
			    end

			    local function get_diagnostic_label()
			      local icons = { error = " ", warn = " ", info = " ", hint = " " }
			      local label = {}
			      for severity, icon in pairs(icons) do
			        local n = #vim.diagnostic.get(
			          props.buf,
			          { severity = vim.diagnostic.severity[string.upper(severity)] }
			        )
			        if n > 0 then
			          table.insert(label, { icon .. n .. " ", group = "DiagnosticSign" .. severity })
			        end
			      end
			      return label
			    end

			    return {
		        { get_file_name() },
		        { get_diagnostic_label() },
		        { get_git_diff() },
			    }
				end,
			})
		end,
	},
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
		-- optional for floating window border decoration
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
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
			-- Your DBUI configuration
			vim.g.db_ui_use_nerd_fonts = 1
		end,
		keys = {
			{

				"<leader>d",
				"<cmd>NvimTreeClose<cr><cmd>tabnew<cr><bar><bar><cmd>DBUI<cr>",
			},
		},
	},
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
					vim.keymap.set("n", "t", api.node.open.tab, opts("Tab"))
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
					dotfiles = true,
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
