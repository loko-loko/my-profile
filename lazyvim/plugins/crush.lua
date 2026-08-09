return {
  -- Disable LazyVim's codelens <leader>cc keymap so it doesn't override Crush
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ["*"] = {
          keys = {
            { "<leader>cc", false },
          },
        },
      },
    },
  },
  {
    "gitsang/codock.nvim",
    opts = {
      width = 80,             -- Adjust the width of the vertical split if desired
      codock_cmd = "crush",   -- Sets Crush as the default AI CLI tool
      copy_to_clipboard = false,
    },
    -- Lazy-load the plugin on these commands
    cmd = { "Codock", "CodockFilePosPaste", "CodockFilePosYank", "CodockActions" },
    keys = {
      -- Toggle the Crush agent in a vertical split
      { "<leader>cc", "Codock", desc = "Open Crush Agent", mode = { "n", "v" } },
      { "ac", "Codock", desc = "Open Crush Agent (alias)", mode = { "n", "v" } },
    },
  }
}
