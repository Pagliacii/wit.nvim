local M = {}

local config = require("wit.config")
local core = require("wit.core")
local utils = require("wit.utils")

local function setup_commands()
	vim.api.nvim_create_user_command(config.values.command_search, function(opts)
		core.search(opts.args)
	end, { nargs = 1 })

	vim.api.nvim_create_user_command(config.values.command_search_visual, function()
		local lines = utils.get_visual_selection()
		local query = table.concat(lines, " ")

		---@diagnostic disable-next-line
		core.search(query)
	end, { range = true }) -- allowing range to handle f**ing E481

	vim.api.nvim_create_user_command(config.values.command_search_wiki, function(opts)
		local query = opts.args:gsub(" ", "_")
		local url = "https://en.wikipedia.org/w/index.php?search=" .. query

		core.open_url(url)
	end, { nargs = 1 })
end

--- Initialize the plugin
--- @param opts Config
function M.setup(opts)
	config.setup(opts)
	setup_commands()
end

return M
