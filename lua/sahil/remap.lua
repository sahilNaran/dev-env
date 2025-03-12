vim.g.mapleader = " "

vim.opt.clipboard:append("unnamedplus")

vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })                   -- split window vertically
vim.keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })                 -- split window horizontally
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })                    -- make split windows equal width & height
vim.keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })               -- close current split window

vim.keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })                     -- open new tab
vim.keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })              -- close current tab
vim.keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })                     --  go to next tab
vim.keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })                 --  go to previous tab
vim.keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab


vim.keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })                         -- toggle file explorer
vim.keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" }) -- toggle file explorer on current file
vim.keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" })                     -- collapse file explorer
vim.keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" })                       -- refresh file explorer

vim.api.nvim_create_autocmd("FileType", {
  pattern = "NvimTree",
  callback = function()
    vim.keymap.set("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>", { buffer = true })
    vim.keymap.set("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>", { buffer = true })
    vim.keymap.set("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>", { buffer = true })
    vim.keymap.set("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>", { buffer = true })
  end
})

vim.keymap.set("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>")
vim.keymap.set("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>")
vim.keymap.set("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>")
vim.keymap.set("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>")

-- Visual mode line movement
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" }) -- Move visual selection down
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })   -- Move visual selection up

-- Enhanced normal mode operations
vim.keymap.set("n", "J", "mzJ`z", { desc = "Smart join lines" })           -- Join lines while preserving cursor position
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down centered" }) -- Scroll down half-page with center keep
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up centered" })   -- Scroll up half-page with center keep

-- Search navigation improvements
vim.keymap.set("n", "n", "nzzzv", { desc = "Next centered match" })                               -- Next search result centered with fold open
vim.keymap.set("n", "N", "Nzzzv", { desc = "Prev centered match" })                               -- Previous search result centered with fold open

vim.keymap.set("n", "<leader>zm", ":ZenMode<CR>", { silent = true, desc = "Toggle Zen Mode" })    -- Toggle Zen Mode
vim.keymap.set("n", "<leader>tt", ":ToggleTerm<CR>", { silent = true, desc = "Toggle terminal" }) -- Toggle terminal
