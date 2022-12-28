return {
  "kyazdani42/nvim-tree.lua",
  -- dependencies = { "folke/which-key.nvim"},
  keys = {
    { "<leader>e", "<cmd>NvimTreeToggle<cr>", "Explorer" 
    }
  },
  cmd = {"NvimTreeToggle"},
  event = {"VeryLazy"},
  config = function ()
    require("nvim-tree").setup {}
    -- require("which-key").register({
    --  e = { "<cmd>NvimTreeToggle<cr>", "Explorer" }
    --}, { prefix = "<leader>" })
  end
}
