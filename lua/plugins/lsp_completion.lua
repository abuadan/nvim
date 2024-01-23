return {
  {
    "L3MON4D3/LuaSnip",
    keys = function()
      return {}
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "onsails/lspkind.nvim",
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local lspkind = require("lspkind")
      local luasnip = require("luasnip")
      local cmp = require("cmp")
      local str = require("cmp.utils.str")
      local types = require("cmp.types")

      opts.mapping = vim.tbl_extend("force", opts.mapping, {

        -- ["<C-n>"] = cmp.mapping.select_next_item({
        --   behavior = cmp.SelectBehavior.Select,
        -- }),
        -- ["<C-p>"] = cmp.mapping.select_prev_item({
        --   behavior = cmp.SelectBehavior.Select,
        -- }),
        ["<C-e>"] = cmp.mapping({
          i = cmp.mapping.abort(),
          c = cmp.mapping.close(),
        }),
        -- ["<CR>"] = cmp.mapping.confirm({
        --   select = true,
        -- }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            -- You could replace select_next_item() with confirm({ select = true }) to get VS Code autocompletion behavior
            cmp.select_next_item()
          -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
          -- this way you will only jump inside the snippet region
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      })

      opts.formatting = vim.tbl_extend("force", opts.formatting, {
        fields = { cmp.ItemField.Abbr, cmp.ItemField.Menu, cmp.ItemField.Kind },
        format = lspkind.cmp_format({
          with_text = true,
          -- maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
          ellipsis_char = "...",
          menu = {
            nvim_lsp = "[LSP]",
            buffer = "[Buffer]",
            nvim_lua = "[Lua]",
            path = "[Path]",
            luasnip = "[Snippet]",
          },
          before = function(entry, vim_item)
            -- Get the full snippet (and only keep first line)
            local word = entry:get_insert_text()
            if entry.completion_item.insertTextFormat == types.lsp.InsertTextFormat.Snippet then
              word = str.get_word(word)
            end
            word = str.oneline(word)

            -- concatenates the string
            local max = 50
            if string.len(word) >= max then
              local before = string.sub(word, 1, math.floor((max - 3) / 2))
              word = before .. "..."
            end

            if
              entry.completion_item.insertTextFormat == types.lsp.InsertTextFormat.Snippet
              and string.sub(vim_item.abbr, -1, -1) == "~"
            then
              word = word .. "~"
            end
            vim_item.abbr = word

            return vim_item
          end,
        }),
      })
      opts.snippet = vim.tbl_extend("force", opts.snippet, {
        expand = function(args)
          if not luasnip then
            return
          end
          luasnip.lsp_expand(args.body)
        end,
      })
      opts.sources = vim.tbl_extend("force", opts.sources, {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "text" },
        { name = "path" },
        { name = "buffer" },
      })
      opts.completion = vim.tbl_extend("force", opts.completion, { completeopt = "menu,menuone,noinsert,noselect" })
      -- opts.window = vim.tbl_extend("force", opts.window, {
      --   completion = cmp.config.window.bordered(),
      --   documentation = cmp.config.window.bordered(),
      -- })
      opts.experimental = vim.tbl_extend("force", opts.experimental, { ghost_text = true })
    end,
    vim.cmd([[
    	highlight! link CmpItemMenu Comment
    	highlight! CmpItemKindStruct guifg=#00ff00
    	" gray
    	highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080
    	" blue
    	highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6
    	highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6
    	" light blue
    	highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE
    	highlight! CmpItemKindInterface guibg=NONE guifg=#9CDCFE
    	highlight! CmpItemKindText guibg=NONE guifg=#9CDCFE
    	" pink
    	highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0
    	highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0
    	" front
    	highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4
    	highlight! CmpItemKindProperty guibg=NONE guifg=#D4D4D4
    	highlight! CmpItemKindUnit guibg=NONE guifg=#D4D4D4
    ]]),
  },
}
