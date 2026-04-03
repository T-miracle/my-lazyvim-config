local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    -- 添加 LazyVim 并导入其插件
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- 使用你的插件进行导入/覆盖
    { import = "plugins" },
  },
  defaults = {
    -- 默认情况下，只有 LazyVim 插件会延迟加载。你的自定义插件会在启动时加载。
    -- 如果你清楚这项设置的影响，可以将其设为 `true`，让所有自定义插件默认延迟加载。
    lazy = false,
    -- 当前建议保持 version=false，因为许多支持版本管理的插件发布版本较旧，
    -- 可能会导致你的 Neovim 环境出现问题。
    version = false, -- 始终使用最新的 git 提交
    -- version = "*", -- 对支持 semver 的插件尝试安装最新稳定版
  },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = {
    enabled = true, -- 定期检查插件更新
    notify = false, -- 更新时不通知
  },                -- 自动检查插件更新
  performance = {
    rtp = {
      -- 禁用部分 rtp 插件
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
