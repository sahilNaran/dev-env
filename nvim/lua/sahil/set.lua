vim.opt.number = true
vim.opt.relativenumber = true

-- Tabs & Indentation (2-space soft tabs)
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Search
vim.opt.hlsearch = true   -- keep search highlights
vim.opt.incsearch = true  -- incremental search
vim.opt.ignorecase = true -- case-insensitive search
vim.opt.smartcase = true  -- unless search contains uppercase

-- Visual
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.scrolloff = 8 -- keep 8-line padding when scrolling
vim.opt.fillchars = {
  eob = " ",
  vert = " "
}
vim.opt.wrap = false -- no line wrapping

-- Undo/Backup
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

-- Editing Behavior
vim.opt.updatetime = 50       -- faster completion timeout
vim.opt.isfname:append("@-@") -- recognize special chars in filenames

-- Clipboard & Input
vim.opt.clipboard:append("unnamedplus") -- system clipboard
vim.opt.backspace = "indent,eol,start"  -- better backspace

-- Window Splitting
vim.opt.splitright = true -- vertical splits to right
vim.opt.splitbelow = true -- horizontal splits below


-- Seperator
vim.cmd([[highlight WinSeparator guifg=NONE guibg=NONE ctermfg=NONE ctermbg=NONE]])

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.cc" },
  callback = function()
    vim.bo.filetype = "cpp"
  end,
})
