-- chinese-keys-desc.lua
-- 该文件用于覆盖 which-key 插件的快捷键描述，将英文描述替换为中文描述
-- 你可以根据需要添加更多的快捷键描述替换

local desc_list = {
  -- 基础快捷键
  { "^Up$", "向上移动" },
  { "^Down$", "向下移动" },
  { "^Left$", "向左移动" },
  { "^Right$", "向右移动" },
}

return {
  {
    "folke/which-key.nvim",
    opts = {
      replace = {
        desc = desc_list,
      },
    },
  },
}
