return {
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
      -- Add a custom keymap (e.g., Space + a + c) to toggle the agent
      { "ac", "Codock", desc = "Open Crush Agent", mode = { "n", "v" } },
    },
  }
}
