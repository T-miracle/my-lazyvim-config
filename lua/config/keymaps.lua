-- 键位映射会在 VeryLazy 事件触发时自动加载
-- 这些默认的键位映射始终会设置： https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- 在这里添加额外的键位映射

-- bufferline 增强
vim.keymap.set("n", "<M-LEFT>", "<cmd>BufferLineCyclePrev<CR>", { desc = "切换到上一个缓冲区" })
vim.keymap.set("n", "<M-RIGHT>", "<cmd>BufferLineCycleNext<CR>", { desc = "切换到下一个缓冲区" })

