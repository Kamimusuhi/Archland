return {
	"barrett-ruth/live-server.nvim",
	build = "pnpm add -g live-server",
	config = function()
    vim.keymap.set("n", "<C-A-l>", ":LiveServerStart<CR>", {})
    vim.keymap.set("n", "<C-A-c>", ":LiveServerStop<CR>", {})
	  require("live-server").setup()
	end,
}
