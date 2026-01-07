" Modern Neovim Configuration
scriptencoding utf-8

" Basic Settings
set nocompatible
filetype plugin indent on
syntax enable

" Display
set number
set showmatch
set cursorline
set signcolumn=yes
set termguicolors
set pumheight=10
set scrolloff=8
set sidescrolloff=8

" Indentation
set autoindent
set smartindent
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set smarttab

" Search
set ignorecase
set smartcase
set incsearch
set hlsearch

" File handling
set noswapfile
set nobackup
set undofile
set undodir=~/.config/nvim/undo
set hidden
set autoread

" UI improvements
set wildmenu
set wildmode=longest:full,full
set cmdheight=1
set updatetime=50
set shortmess+=c
set laststatus=2

" Split behavior
set splitbelow
set splitright

" Clipboard
set clipboard=unnamedplus

" Backspace behavior
set backspace=indent,eol,start

" Plugin Management with vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')

" File management and navigation
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-lua/plenary.nvim'

" Treesitter (modern syntax highlighting)
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'

" LSP and completion
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'rafamadriz/friendly-snippets'

" Git integration
Plug 'lewis6991/gitsigns.nvim'
Plug 'tpope/vim-fugitive'
Plug 'sindrets/diffview.nvim'

" Editing enhancements
Plug 'kylechui/nvim-surround'
Plug 'numToStr/Comment.nvim'
Plug 'windwp/nvim-autopairs'
Plug 'wellle/targets.vim'
Plug 'machakann/vim-highlightedyank'

" Status line and UI
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-web-devicons'

" Colorschemes
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'folke/tokyonight.nvim'
Plug 'EdenEast/nightfox.nvim'
Plug 'rebelot/kanagawa.nvim'

" Modern utilities
Plug 'folke/which-key.nvim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'folke/trouble.nvim'
Plug 'akinsho/toggleterm.nvim'

" Language specific
Plug 'tpope/vim-rails', { 'for': 'ruby' }
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }

call plug#end()

" Color scheme
set background=dark
try
  colorscheme catppuccin-mocha
catch
  colorscheme desert
endtry

" Key Mappings
let mapleader = " "
let maplocalleader = ","

" Quick actions
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>x :x<CR>
nnoremap <leader>/ :nohlsearch<CR>

" File operations (Telescope)
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>e :NvimTreeToggle<CR>

" Window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Advanced window management with 's' prefix
nnoremap s <Nop>
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H
nnoremap sn :tabnext<CR>
nnoremap sp :tabprevious<CR>
nnoremap sr <C-w>r
nnoremap s= <C-w>=
nnoremap sw <C-w>w
nnoremap so <C-w>_<C-w>|
nnoremap sO <C-w>=
nnoremap ss :split<CR>
nnoremap sv :vsplit<CR>
nnoremap sq :q<CR>
nnoremap sQ :bdelete<CR>
nnoremap st :tabnew<CR>

" Buffer operations
nnoremap ]b :bnext<CR>
nnoremap [b :bprevious<CR>
nnoremap <leader>bd :bdelete<CR>

" Lua configurations
lua << EOF
-- Setup nvim-tree
require("nvim-tree").setup()

-- Setup Treesitter
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "lua", "ruby", "javascript", "typescript", "python", "html", "css", "json", "yaml" },
  highlight = { enable = true },
  indent = { enable = true },
}

-- Setup lualine
require('lualine').setup {
  options = {
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
  }
}

-- Setup gitsigns
require('gitsigns').setup()

-- Setup Comment.nvim
require('Comment').setup()

-- Setup nvim-surround
require("nvim-surround").setup()

-- Setup nvim-autopairs
require("nvim-autopairs").setup()

-- Setup which-key
require("which-key").setup()

-- Setup indent-blankline
require("ibl").setup()

-- LSP setup with Mason
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls", "ruby_ls", "tsserver", "pyright" },
})

local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Setup language servers
local servers = { 'lua_ls', 'ruby_ls', 'tsserver', 'pyright' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    capabilities = capabilities,
  }
end

-- Setup nvim-cmp (completion)
local cmp = require('cmp')
cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
  })
})

-- LSP key mappings
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  end,
})
EOF

" Auto commands
augroup NeovimAutoCommands
  autocmd!
  
  " Return to last position
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
  
  " Auto-create directories
  autocmd BufWritePre * call mkdir(expand('<afile>:p:h'), 'p')
augroup END

" Create necessary directories
if !isdirectory($HOME.'/.config/nvim/undo')
  call mkdir($HOME.'/.config/nvim/undo', 'p', 0700)
endif
