return { 
  { "rebelot/kanagawa.nvim", event = "VeryLazy" },
  { "folke/tokyonight.nvim", event = "VeryLazy"},
  {
    "catppuccin/nvim",
    name = "catppuccin",
    event = "VeryLazy",
    config = {
      integrations = {
        nvimtree = true,
        which_key = true
      }
    }
  },
  { "EdenEast/nightfox.nvim", event = "VeryLazy" },
  { "ellisonleao/gruvbox.nvim", event = "VeryLazy" },
  { "numToStr/Sakura.nvim", event = "VeryLazy"  },
  { "dracula/vim", event = "VeryLazy"  },
  { "rose-pine/neovim", name = "rose-pine", event = "VeryLazy"  }
}
