vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set tabstop=2")
vim.cmd("set shiftwidth=2")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
  {"utilyre/sentiment.nvim", version = "*", event = "VeryLazy"},
  {
   'Exafunction/codeium.vim',
    event = 'BufEnter'
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" }
  }
}
local opts = {}


-- Setup lazy.nvim
require("lazy").setup(plugins, opts)

local telescope = require('telescope') 
local builtin = require('telescope.builtin')

vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<C-g>', builtin.live_grep, {})

require("catppuccin").setup({
  flavour = "frappe",
  custom_highlights = function(C)
	return {
		CmpItemKindSnippet = { fg = C.base, bg = C.mauve },
		CmpItemKindKeyword = { fg = C.base, bg = C.red },
		CmpItemKindText = { fg = C.base, bg = C.teal },
		CmpItemKindMethod = { fg = C.base, bg = C.blue },
		CmpItemKindConstructor = { fg = C.base, bg = C.blue },
		CmpItemKindFunction = { fg = C.base, bg = C.blue },
		CmpItemKindFolder = { fg = C.base, bg = C.blue },
		CmpItemKindModule = { fg = C.base, bg = C.blue },
		CmpItemKindConstant = { fg = C.base, bg = C.peach },
		CmpItemKindField = { fg = C.base, bg = C.green },
		CmpItemKindProperty = { fg = C.base, bg = C.green },
		CmpItemKindEnum = { fg = C.base, bg = C.green },
		CmpItemKindUnit = { fg = C.base, bg = C.green },
		CmpItemKindClass = { fg = C.base, bg = C.yellow },
		CmpItemKindVariable = { fg = C.base, bg = C.flamingo },
		CmpItemKindFile = { fg = C.base, bg = C.blue },
		CmpItemKindInterface = { fg = C.base, bg = C.yellow },
		CmpItemKindColor = { fg = C.base, bg = C.red },
		CmpItemKindReference = { fg = C.base, bg = C.red },
		CmpItemKindEnumMember = { fg = C.base, bg = C.red },
		CmpItemKindStruct = { fg = C.base, bg = C.blue },
		CmpItemKindValue = { fg = C.base, bg = C.peach },
		CmpItemKindEvent = { fg = C.base, bg = C.blue },
		CmpItemKindOperator = { fg = C.base, bg = C.blue },
		CmpItemKindTypeParameter = { fg = C.base, bg = C.blue },
		CmpItemKindCopilot = { fg = C.base, bg = C.teal },
		}
  end,
})

vim.cmd.colorscheme "catppuccin"

require('nvim-treesitter.configs').setup {
  highlight = {
    enabled = true
  }
}

require("sentiment").enable()

require("cmp").setup()
