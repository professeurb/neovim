return {
  "MunifTanjim/nui.nvim",
  "nvim-lua/plenary.nvim",
  {
    "folke/trouble.nvim",
    dependencies = { "kyazdani42/nvim-web-devicons" },
    cmd = { "TroubleToggle" },
    keys = { { "<leader>tt", "<cmd>TroubleToggle<cr>", desc = "Trouble" } },
    config = true
  },
  {
    "kyazdani42/nvim-web-devicons",
    config = {
      default = true,
    }
  },
  {
    "abecodes/tabout.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    cmd = { "Tabout", "TaboutBack", "TaboutToggle" },
    event = "VeryLazy",
    config = function()
      require("tabout").setup({ ignore_beginning = false })
    end
  },
  {
    'stevearc/oil.nvim',
    opts = {},
    cmd = { "Oil" }
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    -- stylua: ignore
    keys = {
      { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
      { "S",     mode = { "n", "o", "x" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end,
                                                                                                  desc =
        "Treesitter Search" },
      { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc =
      "Toggle Flash Search" },
    },
  },
  {
    -- https://www.ejmastnak.com/tutorials/vim-latex/intro/
    "lervag/vimtex",
    ft = "tex", -- without ft, it's not working too
    config = function()
      vim.cmd("call vimtex#init()")
    end
  }
}
