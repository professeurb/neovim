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
  { 'm4xshen/autoclose.nvim', config = true, event = "InsertEnter",}
}
