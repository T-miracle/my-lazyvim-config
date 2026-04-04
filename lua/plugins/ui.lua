-- ui.lua
-- 该文件用于配置 UI 相关的插件和设置
return {
  {
    "akinsho/bufferline.nvim",
    opts = function(_, opts)
      opts.options = opts.options or {}
      -- 始终显示 bufferline，即使只有一个 buffer
      opts.options.always_show_bufferline = true
      return opts
    end,
  }
}
