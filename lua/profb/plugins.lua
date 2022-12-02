local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.api.nvim_create_autocmd("BufWritePost", {
  command = "source <afile> | PackerSync",
  group = vim.api.nvim_create_augroup("Packer", { clear = true }),
  pattern = "plugins.lua",
})

packer.init {
  autoremove = true,
}

packer.startup {
  function(use)
    -- let packer manage itself
    use "wbthomason/packer.nvim"

    -- utilities
    use { "nvim-lua/popup.nvim", as = "popup" }
    use { "nvim-lua/plenary.nvim", as = "plenary" }
    use { "mhinz/vim-sayonara", as = "sayonara" }


    -- treesitter
    use {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      config = function()
        require("profb.treesitter").setup()
      end,
      requires = {
        "nvim-treesitter/nvim-treesitter-textobjects",
        "nvim-treesitter/nvim-treesitter-context",
        "p00f/nvim-ts-rainbow",
        "JoosepAlviste/nvim-ts-context-commentstring",
        "nvim-treesitter/playground"
      },
    }

    use { "RRethy/nvim-treesitter-textsubjects" }

    -- colorschemes
    use { "tjdevries/colorbuddy.vim" }
    use { "bkegley/gloombuddy" }
    use { "lunarvim/darkplus.nvim" }
    use { "rose-pine/neovim" }
    use { "rebelot/kanagawa.nvim" }
    use { "EdenEast/nightfox.nvim" }
    use { "folke/tokyonight.nvim" }
    use { "sainnhe/everforest" }
    use { "savq/melange" }
    use { "ayu-theme/ayu-vim" }
    use { "rakr/vim-one" }
    use { "mhartington/oceanic-next" }
    use { "numToStr/Sakura.nvim" }
    use { "marko-cerovac/material.nvim" }
    use { "bluz71/vim-nightfly-guicolors" }
    use { "dracula/vim" }
    use { "fenetikm/falcon" }
    use { "shaunsingh/nord.nvim" }
    use { "catppuccin/nvim", as = "catppuccin",
      config = function()
        require('catppuccin').setup({
          integrations = {
            nvimtree = true,
            which_key = true
          }
        })
      end
    }

    use {
      "kyazdani42/nvim-web-devicons",
      config = function()
        require("nvim-web-devicons").setup({
          default = true,
        })
      end,
    }

    use({
      "folke/which-key.nvim",
      config = function()
        require("profb.whichkey").setup()
      end,
    })

    use({
      "kyazdani42/nvim-tree.lua",
      config = function()
        require("profb.nvimtree")
      end,
    })

    use {
      "numToStr/Comment.nvim",
      config = function()
        require('Comment').setup {
          pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
        }
      end
    }

    -- telescope
    use {
      "nvim-telescope/telescope.nvim", tag = '0.1.0',
      requires = { 'plenary', "telescope-fzf-native.nvim" },
      config = function()
        require('profb.telescope').setup()
      end,
      wants = { "telescope-fzf-native.nvim" },
    }
    use {
      "nvim-telescope/telescope-fzf-native.nvim",
      run = 'make'
    }

    -- lsp
    use {
      "williamboman/mason.nvim",
      requires = {
        -- lsp
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
        "jose-elias-alvarez/null-ls.nvim",
        "j-hui/fidget.nvim"
      },
      config = function()
        require("mason").setup()
        require("mason-lspconfig").setup({
          automatic_installation = true,
        })
        require("profb.lsp")
      end
    }

    -- cmp
    use({
      "hrsh7th/nvim-cmp",
      requires = {
        -- cmp
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-emoji",
        "hrsh7th/cmp-calc",

        -- cmp x lsp
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lsp-signature-help",

        -- snip x cmp
        "saadparwaiz1/cmp_luasnip",
        "L3MON4D3/LuaSnip",
        "rafamadriz/friendly-snippets",

        -- autopairs (x cmp)
        "windwp/nvim-autopairs",
      },
      config = function()
        require("luasnip").setup({
          -- see: https://github.com/L3MON4D3/LuaSnip/issues/525
          region_check_events = "CursorHold,InsertLeave,InsertEnter",
          delete_check_events = "TextChanged,InsertEnter",
        })
        require("nvim-autopairs").setup()
        require("luasnip.loaders.from_vscode").load()
        require("profb.cmp")
      end,
    })

    use "machakann/vim-sandwich"

    use {
      "folke/trouble.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
        require("trouble").setup {
          -- your configuration comes here
          -- or leave it empty to use the default settings
          -- refer to the configuration section below
        }
      end
    }
    use { "simrat39/symbols-outline.nvim",
      config = function()
        require("symbols-outline").setup()
      end }

    -- vimtex
    use { "lervag/vimtex" }

    -- markdown
    use({
      "iamcco/markdown-preview.nvim",
      -- attention, l'initialisation ne marche pas, à modifier
      -- mais on peut initialiser à la main en exécutant
      -- :call mkdp#util#install()
      run = function() vim.fn["mkdp#util#install"]() end,
    })

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
      packer.sync()
    end
  end,
  config = {
    display = {
      open_fn = require("packer.util").float,
    }
  }
}


if packer_bootstrap then
  print "=================================="
  print "    Plugins are being installed"
  print "    Wait until Packer completes,"
  print "       then restart nvim"
  print "=================================="
  return
end
