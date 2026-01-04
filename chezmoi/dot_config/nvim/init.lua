vim.g.mapleader = " "

local opt = vim.opt
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.smartindent = true
opt.wrap = false
opt.ignorecase = true
opt.smartcase = true
opt.completeopt = "menuone,noselect"
opt.termguicolors = true
opt.signcolumn = "yes"
opt.updatetime = 300
opt.timeoutlen = 400
opt.splitright = true
opt.splitbelow = true
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.undofile = true
opt.scrolloff = 5

vim.keymap.set("n", "<leader>w", "<cmd>write<cr>", { desc = "저장" })
vim.keymap.set("n", "<leader>q", "<cmd>quit<cr>", { desc = "닫기" })
vim.keymap.set("n", "<leader>h", "<cmd>nohlsearch<cr>", { desc = "검색 하이라이트 끄기" })

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local uv = vim.uv or vim.loop
if not uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("plugins")
