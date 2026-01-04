return require("lazy").setup({
  { "tpope/vim-sleuth" },
  { "numToStr/Comment.nvim", config = true },
  { "folke/which-key.nvim", config = true },
  { "lewis6991/gitsigns.nvim", config = true },
  { "windwp/nvim-autopairs", config = true },
  {
    "stevearc/conform.nvim",
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          python = { "ruff_format" },
          javascript = { "biome" },
          typescript = { "biome" },
          javascriptreact = { "biome" },
          typescriptreact = { "biome" },
          json = { "biome" },
        },
        format_on_save = { timeout_ms = 1500, lsp_fallback = true },
      })
      vim.keymap.set("n", "<leader>f", function()
        require("conform").format({ async = true, lsp_fallback = true })
      end, { desc = "포맷" })
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = true,
  },
  { "nvim-tree/nvim-web-devicons", lazy = true },
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("oil").setup()
      vim.keymap.set("n", "-", "<cmd>Oil<cr>", { desc = "상위 폴더 열기" })
      vim.keymap.set("n", "<leader>e", "<cmd>Oil<cr>", { desc = "파일 탐색" })
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup()
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "파일 찾기" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "문자열 검색" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "버퍼 목록" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "도움말" })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "tsserver", "rust_analyzer" },
        automatic_installation = false,
      })

      local lspconfig = require("lspconfig")
      local util = require("lspconfig.util")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local on_attach = function(_, bufnr)
        local bufmap = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end
        bufmap("n", "gd", vim.lsp.buf.definition, "정의로 이동")
        bufmap("n", "gD", vim.lsp.buf.declaration, "선언으로 이동")
        bufmap("n", "gi", vim.lsp.buf.implementation, "구현으로 이동")
        bufmap("n", "gr", vim.lsp.buf.references, "참조로 이동")
        bufmap("n", "K", vim.lsp.buf.hover, "호버")
        bufmap("n", "<leader>rn", vim.lsp.buf.rename, "이름 변경")
        bufmap("n", "<leader>ca", vim.lsp.buf.code_action, "코드 액션")
        bufmap("n", "[d", vim.diagnostic.goto_prev, "이전 진단")
        bufmap("n", "]d", vim.diagnostic.goto_next, "다음 진단")
        bufmap("n", "<leader>e", vim.diagnostic.open_float, "라인 진단")
      end

      require("mason-lspconfig").setup_handlers({
        function(server_name)
          lspconfig[server_name].setup({
            capabilities = capabilities,
            on_attach = on_attach,
          })
        end,
        ["lua_ls"] = function()
          lspconfig.lua_ls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
              Lua = {
                diagnostics = { globals = { "vim" } },
              },
            },
          })
        end,
      })

      if vim.fn.executable("ty") == 1 then
        if not lspconfig.configs.ty then
          lspconfig.configs.ty = {
            default_config = {
              cmd = { "ty", "server" },
              filetypes = { "python" },
              root_dir = util.root_pattern("pyproject.toml", "requirements.txt", ".git"),
              settings = {},
            },
          }
        end
        lspconfig.ty.setup({
          capabilities = capabilities,
          on_attach = on_attach,
          cmd = { "ty", "server" },
          settings = {
            ty = {
              diagnosticMode = "workspace",
              inlayHints = {
                variableTypes = false,
              },
              completions = {
                autoImport = true,
              },
            },
          },
        })
      end
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "path" },
          { name = "luasnip" },
        }),
      })
    end,
  },
})
