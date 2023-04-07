local opts = { noremap = true } 
local keymap = vim.api.nvim_set_keymap
local null_ls = require("null-ls")
local eslint = require("eslint")

vim.opt.number = true
vim.cmd([[packadd packer.nvim]])

require("packer").startup(function()
  use("wbthomason/packer.nvim")
  use("morhetz/gruvbox")
  use("nvim-treesitter/nvim-treesitter")
  use("nvim-lualine/lualine.nvim")
  use("junegunn/fzf")
  use("junegunn/fzf.vim")
  use("preservim/nerdtree")
  use("jiangmiao/auto-pairs")
  use("alvan/vim-closetag")
  use("tpope/vim-surround")
  use("neoclide/coc.nvim")
  use("easymotion/vim-easymotion")
  use("mhinz/vim-signify")
  use("Yggdroot/indentLine")
  use("numToStr/Comment.nvim")
  use("christoomey/vim-tmux-navigator")
  use("nvim-lua/plenary.nvim")
  use("nvim-telescope/telescope.nvim")
  use("neovim/nvim-lspconfig")
  use("jose-elias-alvarez/null-ls.nvim")
  use("MunifTanjim/eslint.nvim")
end)

vim.cmd([[colorscheme gruvbox]])
vim.opt.list = true
vim.opt.listchars:append("tab:> ")
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.opt.swapfile = false
vim.opt.wrap = false
vim.opt.relativenumber = true

-- Map global leader from \ to Space
vim.g.mapleader = " "
-- Open recently used files
keymap("n", "<leader>fr", ":History<CR>", opts)
-- Open files in same directory as current file
keymap("n", "<leader>ff", ":e %:h/<C-d>", opts)
keymap("n", "<leader>p", ":Files<CR>", opts)
keymap("n", "<leader>ag", ":Ag", {noremap = true})

-- Nerdtree mapping
keymap("n", "<C-n>", ":NERDTreeToggle<CR>", {noremap = true})
keymap("n", "<C-t>", ":NERDTree<CR>", {noremap = true})
keymap("n", "<C-f>", ":NERDTreeFind<CR>", {noremap = true})

-- Split resize
keymap("n", "<leader>>", "10<C-w>>", {noremap = true})
keymap("n", "<leader><", "10<C-w><", {noremap = true})

-- Coc Commands
keymap("n", "gd", "<Plug>(coc-definition)", {noremap = true})
keymap("n", "gy", "<Plug>(coc-type-definition)", {noremap = true})
keymap("n", "gi", "<Plug>(coc-implementation)", {noremap = true})
keymap("n", "gr", "<Plug>(coc-references)", {noremap = true})
keymap("n", "gs", ":CocSearch", {noremap = true})

-- Diagnostics
keymap("n", "<leader>kp", ":let @*=expand('%')<CR>", {noremap = true}) 

-- Search words
keymap("n", "<leader>s", "<Plug>(easymotion-s2)", {noremap = true})

-- Scrolling
keymap("n", "<C-e>", "10<C-e>", {noremap = true})
keymap("n", "<C-y>", "10<C-y>", {noremap = true})

-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- Move text up and down
keymap("n", "<A-j>", ":m .+1<CR>==", opts)
keymap("n", "<A-k>", ":m .-2<CR>==", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Duplicate Line
keymap("v", "tt", ":t.<CR>", opts)

-- Comment
-- gcc comment
-- Visual Mode select and gc
require('Comment').setup()

-- Replace Word
keymap("n", "<leader>rm", ":%s/$1/$2/gc", opts)

-- Split 
keymap("n", "<leader>sh", ":split<CR>", opts)
keymap("n", "<leader>sv", ":vsplit<CR>", opts)

-- Syntax

null_ls.setup()
eslint.setup({
  bin = 'eslint', -- or `eslint_d`
  code_actions = {
    enable = true,
    apply_on_save = {
      enable = true,
      types = { "directive", "problem", "suggestion", "layout" },
    },
    disable_rule_comment = {
      enable = true,
      location = "separate_line", -- or `same_line`
    },
  },
  diagnostics = {
    enable = true,
    report_unused_disable_directives = false,
    run_on = "type", -- or `save`
  },
})

-- Doc 
-- :g/pattern/d - Remove lines matching pattern
-- :g!/pattern/d - Remove lines that do NOT match
-- :%s/$1/$2/c - Replace word one by one 
-- :norm i# or :norm x - Add/remove word in the line
