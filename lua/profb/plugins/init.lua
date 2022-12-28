return {
  "MunifTanjim/nui.nvim",
  "nvim-lua/plenary.nvim",
  {
    "folke/trouble.nvim",
    dependencies = {"kyazdani42/nvim-web-devicons"},
    cmd = { "TroubleToggle"},
    config = true
  },
  {
    "kyazdani42/nvim-web-devicons",
    config = {
      default = true,
    }
  },
  { 
    -- https://www.youtube.com/watch?v=UWSOGoHqkv4&t=14s
    "phaazon/mind.nvim", config = true, dependencies = { 'nvim-lua/plenary.nvim' }, cmd = { "MindOpenMain" }
  },
  { 'm4xshen/autoclose.nvim', config = true, event = "InsertEnter",}
}
