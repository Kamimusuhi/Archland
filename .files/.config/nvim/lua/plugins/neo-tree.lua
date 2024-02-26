return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
    "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  config = function()
    vim.g.neotree_quit_on_open = 1 -- Close NeoTree after opening a file
    vim.keymap.set("n", "<C-b>", ":Neotree filesystem toggle right<CR>", {})

    require("neo-tree").setup({
      window = {
        mappings = {
          ["P"] = { "toggle_preview", config = { use_float = false, use_image_nvim = true } },
        },
      },
    })
  end,
}
