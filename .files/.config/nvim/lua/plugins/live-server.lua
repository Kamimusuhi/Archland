return {
	"barrett-ruth/live-server.nvim",
	config = function()
    vim.keymap.set("n", "<C-A-l>", ":LiveServerStart<CR>", {})
    vim.keymap.set("n", "<C-A-c>", ":LiveServerStop<CR>", {})
	  require("live-server").setup()
	end,
}
