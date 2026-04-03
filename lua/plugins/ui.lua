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
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = function(_, opts)
      opts.window = opts.window or {}
      opts.window.position = "left"
      opts.filesystem = opts.filesystem or {}
      opts.filesystem.follow_current_file = {
        enabled = false, -- 跟随当前文件（可选）
        leave_dirs_open = true, -- 切换文件时目录保持展开（更“固定”）
      }

      return opts
    end,
  },
}
