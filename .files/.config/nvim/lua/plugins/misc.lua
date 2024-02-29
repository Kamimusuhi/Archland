return {
  {
    "barrett-ruth/live-server.nvim",
    config = function()
      vim.keymap.set("n", "<C-A-l>", ":LiveServerStart<CR>", {})
      vim.keymap.set("n", "<C-A-c>", ":LiveServerStop<CR>", {})
      require("live-server").setup()
    end,
  },
  {
    "NStefan002/speedtyper.nvim",
    cmd = "Speedtyper",
    opts = {
      language = "en",
      game_modes = {
        rain = {
          initial_speed = 0.5,
          throttle = -1,
        },
      },
    },
  },
}
