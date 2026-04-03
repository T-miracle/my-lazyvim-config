-- 由于这只是一个示例规范，这里实际上不会加载任何内容，并返回一个空的 spec
-- stylua: ignore
if true then return {} end

-- "plugins" 目录下的每个 spec 文件都会被 lazy.nvim 自动加载
--
-- 在你的插件文件中，你可以：
-- * 添加额外插件
-- * 禁用/启用 LazyVim 插件
-- * 覆盖 LazyVim 插件的配置
return {
  -- 添加 gruvbox
  { "ellisonleao/gruvbox.nvim" },

  -- 配置 LazyVim 加载 gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },

  -- 修改 trouble 配置
  {
    "folke/trouble.nvim",
    -- opts 会与父级 spec 合并
    opts = { use_diagnostic_signs = true },
  },

  -- 禁用 trouble
  { "folke/trouble.nvim", enabled = false },

  -- 覆盖 nvim-cmp 并添加 cmp-emoji
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      table.insert(opts.sources, { name = "emoji" })
    end,
  },

  -- 修改部分 telescope 选项，并添加一个用于浏览插件文件的快捷键
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- 添加一个快捷键用于浏览插件文件
      -- stylua: ignore
      {
        "<leader>fp",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "查找插件文件",
      },
    },
    -- 修改部分选项
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
      },
    },
  },

  -- 将 pyright 添加到 lspconfig
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- pyright 会通过 mason 自动安装，并由 lspconfig 加载
        pyright = {},
      },
    },
  },

  -- 添加 tsserver，并通过 typescript.nvim 而不是 lspconfig 进行配置
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "jose-elias-alvarez/typescript.nvim",
      init = function()
        require("lazyvim.util").lsp.on_attach(function(_, buffer)
          -- stylua: ignore
          vim.keymap.set( "n", "<leader>co", "TypescriptOrganizeImports", { buffer = buffer, desc = "整理导入" })
          vim.keymap.set("n", "<leader>cR", "TypescriptRenameFile", { desc = "重命名文件", buffer = buffer })
        end)
      end,
    },
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- tsserver 会通过 mason 自动安装，并由 lspconfig 加载
        tsserver = {},
        -- vue2
        vetur = {},
      },
      -- 你可以在这里进行任何额外的 lsp server 配置
      -- 如果返回 true，则不会使用 lspconfig 来设置该 server
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        -- 使用 typescript.nvim 进行配置示例
        tsserver = function(_, opts)
          require("typescript").setup({ server = opts })
          return true
        end,
        -- 指定 * 可作为任意 server 的兜底处理函数
        -- ["*"] = function(server, opts) end,
      },
    },
  },

  -- 对于 typescript，LazyVim 也提供了额外的 spec 来正确配置 lspconfig、
  -- treesitter、mason 和 typescript.nvim。因此可以使用如下方式替代上面的配置：
  { import = "lazyvim.plugins.extras.lang.typescript" },

  -- 添加更多 treesitter 解析器
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
        "vue",
      },
    },
  },

  -- 由于 `vim.tbl_deep_extend` 只能合并表而不能合并列表，上面的代码
  -- 会用新值覆盖 `ensure_installed`。
  -- 如果你希望在默认配置基础上扩展，可以使用下面的写法：
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- 添加 tsx 和 typescript
      vim.list_extend(opts.ensure_installed, {
        "tsx",
        "typescript",
      })
    end,
  },

  -- opts 函数也可以用于修改默认配置：
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, {
        function()
          return "😄"
        end,
      })
    end,
  },

  -- 或者返回新的配置以完全覆盖默认配置
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      return {
        --[[在这里添加你的自定义 lualine 配置]]
      }
    end,
  },

  -- 使用 mini.starter 替代 alpha
  { import = "lazyvim.plugins.extras.ui.mini-starter" },

  -- 添加 jsonls 和 schemastore，并为 json、json5、jsonc 配置 treesitter
  { import = "lazyvim.plugins.extras.lang.json" },

  -- 在下面添加你希望自动安装的工具
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
        "vetur-vls", -- Vue2
        "tsserver", -- JS/TS
        "prettier", -- 格式化
        "eslint_d", -- Lint
      },
    },
  },
}

