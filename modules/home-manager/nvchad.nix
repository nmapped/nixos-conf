{ pkgs, ... }:
{
  programs.nvchad = {
    enable = true;
    backup = false;
    extraPlugins = ''
      return {
        {
          "stevearc/conform.nvim",
          -- event = 'BufWritePre', -- uncomment for format on save
          opts = require "configs.conform",
        },

        {
          "neovim/nvim-lspconfig",
          config = function()
            require "configs.lspconfig"
          end,
        },

        {
          "hrsh7th/nvim-cmp",
          opts = function(_, opts)
            local cmp = require("cmp")

            local mymappings = {
              ["<Up>"] = cmp.mapping.select_prev_item(),
              ["<Down>"] = cmp.mapping.select_next_item(),
              ["<Tab>"] = cmp.mapping.confirm {
                behavior = cmp.ConfirmBehavior.Replace,
                select = true,
              },
            }
            opts.mapping = vim.tbl_deep_extend("force", opts.mapping, mymappings)
            opts.mapping["<CR>"] = nil
            cmp.setup(opts)
          end,
        },

        {
          "nvim-tree/nvim-web-devicons",
          opts = {
            color_icons = false
          }
        }
      }
    '';

    chadrcConfig = ''
      local M = {}

      M.base46 = {
        theme = "nord",
        transparency = false,
      }

      M.ui = {
        statusline = {
          theme = "vscode_colored",
          separator_style = "block",
        },

        tabufline = {
          order = { "treeOffset", "buffers", "tabs" }
        },
      }

      return M
    '';

    extraConfig = ''
      vim.opt.swapfile = false
      vim.opt.backup = false
      vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
      vim.opt.undofile = true

      vim.opt.hlsearch = false
      vim.opt.incsearch = true

      vim.cmd[[
        set relativenumber
        set guicursor=n-v-c-i:block
        set listchars=
        set listchars=trail:^
      ]]

      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          if vim.fn.argc() == 1 and vim.fn.isdirectory(vim.fn.argv(0)) == 1 then
            require("nvim-tree.api").tree.open()
          end
        end
      })

    '';
  };

}
