vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.clipboard:append("unnamedplus")
vim.opt.backspace = "indent,eol,start"

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.scrolloff = 8
vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

vim.opt.updatetime = 50
vim.opt.isfname:append("@-@")

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.cmd([[highlight WinSeparator guifg=NONE guibg=NONE ctermfg=NONE ctermbg=NONE]])
