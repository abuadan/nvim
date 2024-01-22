local M = {}

local whichkey = require "which-key"
-- local legendary = require "legendary"
-- local next = next

local conf = {
  window = {
    border = "double", -- none, single, double, shadow
    position = "bottom", -- bottom, top
  },
}
whichkey.setup(conf)

local opts = {
  mode = "n", -- Normal mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = false, -- use `nowait` when creating keymaps
}

local v_opts = {
  mode = "v", -- Visual mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = false, -- use `nowait` when creating keymaps
}

local function normal_keymap()
  local keymap_f = nil -- File search
  local keymap_p = nil -- Project search
  local keymap_tree = nil -- Explorer

  keymap_tree = {
    name = "Explorer",
    n = { "<CMD>Neotree reveal<CR>", "Explorer" },
    f = { "<CMD>Neotree toggle<CR>", "Toggle Explorer" },
  }
  keymap_f = {
    name = "Find",
    f = { "<CMD>lua require('telescope.builtin').find_files()<CR>", "Files" },
    ["<Space>"] = { "<CMD>lua require'config.navigation.telescope'.project_files()<CR>", "Search Project" },
    g = { "<CMD>lua require('telescope.builtin').live_grep()<CR>", "Live Grep" },
    b = { "<CMD>lua require('telescope.builtin').buffers()<CR>", "Buffers" },
    h = { "<CMD>lua require('telescope.builtin').help_tags()<CR>", "Help" },
    m = { "<CMD>lua require('telescope.builtin').marks()<CR>", "Marks" },
    o = { "<CMD>lua require('telescope.builtin').oldfiles()<CR>", "Old Files" },
    c = { "<CMD>lua require('telescope.builtin').commands()<CR>", "Commands" },
    r = { "<CMD>lua require'telescope'.extensions.file_browser.file_browser()<CR>", "File Browser" },
    w = { "<CMD>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>", "Current Buffer" },
  }

  keymap_p = {
    name = "Project",
    p = { "<CMD>lua require'telescope'.extensions.project.project{display_type = 'full'}<CR>", "List" },
    s = { "<CMD>lua require'telescope'.extensions.repo.list{}<CR>", "Search" },
    P = { "<CMD>TermExec cmd='BROWSER=brave yarn dev'<CR>", "Slidev" },
  }

  local keymap = {
    ["w"] = { "<CMD>update!<CR>", "Save" },
    -- ["t"] = { "<CMD>ToggleTerm<CR>", "Terminal" },

    a = {
      name = "Attempt",
      n = { "<CMD>lua require('attempt').new_select()<CR>", "New Select" },
      i = { "<CMD>lua require('attempt').new_input_ext()<CR>", "New Input Extension" },
      r = { "<CMD>lua require('attempt').run()<CR>", "Run" },
      d = { "<CMD>lua require('attempt').delete_buf()<CR>", "Delete Buffer" },
      c = { "<CMD>lua require('attempt').rename_buf()<CR>", "Rename Buffer" },
      s = { "<CMD>Telescope attempt<CR>", "Search" },
    },

    b = {
      name = "Buffer",
      c = { "<CMD>BDelete this<CR>", "Close Buffer" },
      f = { "<CMD>bdelete!<CR>", "Force Close Buffer" },
      D = { "<CMD>BWipeout other<CR>", "Delete All Buffers" },
      b = { "<CMD>BufferLinePick<CR>", "Pick a Buffer" },
      p = { "<CMD>BufferLinePickClose<CR>", "Pick & Close a Buffer" },
      m = { "<CMD>JABSOpen<CR>", "Menu" },
    },

    c = {
      -- TODO add Lspsaga keymaps
      name = "Code",
      g = { "<CMD>Neogen func<CR>", "Func Doc" },
      G = { "<CMD>Neogen class<CR>", "Class Doc" },
      d = { "<CMD>DogeGenerate<CR>", "Generate Doc" },
      o = { "<CMD>Telescope aerial<CR>", "Outline" },
      T = { "<CMD>TodoTelescope<CR>", "TODO" },
      x = {
        name = "Swap Next",
        f = "Function",
        p = "Parameter",
        c = "Class",
      },
      X = {
        name = "Swap Previous",
        f = "Function",
        p = "Parameter",
        c = "Class",
      },
    },
    f = keymap_f,
    p = keymap_p,
    n = keymap_tree,

    j = {
      name = "Jump",
      a = { "<CMD>lua require('harpoon.mark').add_file()<CR>", "Add File" },
      m = { "<CMD>lua require('harpoon.ui').toggle_quick_menu()<CR>", "UI Menu" },
      c = { "<CMD>lua require('harpoon.cmd-ui').toggle_quick_menu()<CR>", "Command Menu" },
    },
    ["0"] = { "<CMD>2ToggleTerm<CR>", "ToggleTerm 2" },
    ["1"] = { "<CMD>lua require('harpoon.ui').nav_file(1) <CR>", "File 1" },
    ["2"] = { "<CMD>lua require('harpoon.ui').nav_file(2) <CR>", "File 2" },
    ["3"] = { "<CMD>lua require('harpoon.term').gotoTerminal(1)<CR>", "Terminal 1" },
    ["4"] = { "<CMD>lua require('harpoon.term').gotoTerminal(2)<CR>", "Terminal 2" },
    ["5"] = { "<CMD>lua require('harpoon.term').sendCommand(1,1)<CR>", "Command 1" },
    ["6"] = { "<CMD>lua require('harpoon.term').sendCommand(1,2)<CR>", "Command 2" },

    o = {
      name = "Overseer",
      C = { "<CMD>OverseerClose<CR>", "OverseerClose" },
      a = { "<CMD>OverseerTaskAction<CR>", "OverseerTaskAction" },
      b = { "<CMD>OverseerBuild<CR>", "OverseerBuild" },
      c = { "<CMD>OverseerRunCmd<CR>", "OverseerRunCmd" },
      d = { "<CMD>OverseerDeleteBundle<CR>", "OverseerDeleteBundle" },
      l = { "<CMD>OverseerLoadBundle<CR>", "OverseerLoadBundle" },
      o = { "<CMD>OverseerOpen!<CR>", "OverseerOpen" },
      q = { "<CMD>OverseerQuickAction<CR>", "OverseerQuickAction" },
      r = { "<CMD>OverseerRun<CR>", "OverseerRun" },
      s = { "<CMD>OverseerSaveBundle<CR>", "OverseerSaveBundle" },
      t = { "<CMD>OverseerToggle!<CR>", "OverseerToggle" },
    },

    t = {
      name = "Test",
      a = { "<CMD>lua require('neotest').run.attach()<CR>", "Attach" },
      f = { "<CMD>lua require('neotest').run.run(vim.fn.expand('%'))<CR>", "Run File" },
      F = { "<CMD>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<CR>", "Debug File" },
      l = { "<CMD>lua require('neotest').run.run_last()<CR>", "Run Last" },
      L = { "<CMD>lua require('neotest').run.run_last({ strategy = 'dap' })<CR>", "Debug Last" },
      n = { "<CMD>lua require('neotest').run.run()<CR>", "Run Nearest" },
      N = { "<CMD>lua require('neotest').run.run({strategy = 'dap'})<CR>", "Debug Nearest" },
      o = { "<CMD>lua require('neotest').output.open({ enter = true })<CR>", "Output" },
      S = { "<CMD>lua require('neotest').run.stop()<CR>", "Stop" },
      s = { "<CMD>lua require('neotest').summary.toggle()<CR>", "Summary" },
      p = { "<Plug>PlenaryTestFile", "PlenaryTestFile" },
      v = { "<CMD>TestVisit<CR>", "Visit" },
      x = { "<CMD>TestSuite<CR>", "Suite" },
      t = {
        name = "Test",
        l = { "<CMD>TestLast<CR>", "Run Last" },
        n = { "<CMD>TestNearest<CR>", "Run Nearest" },
      },
    },

    r = {
      name = "Refactor",
      -- i = { [[<CMD>lua require('refactoring').refactor('Inline Variable')<CR>]], "Inline Variable" },
      -- b = { [[<CMD>lua require('refactoring').refactor('Exract Block')<CR>]], "Extract Block" },
      --  B = { [[<CMD>lua require('refactoring').refactor('Exract Block To File')<CR>]], "Extract Block to File" },
      -- P = {
      -- [[<CMD>lua require('refactoring').debug.printf({below = false})<CR>]],
      -- "Debug Print",
      -- },
      -- p = {
      -- [[<CMD>lua require('refactoring').debug.print_var({normal = true})<CR>]],
      -- "Debug Print Variable",
      -- },
      -- c = { [[<CMD>lua require('refactoring').debug.cleanup({})<CR>]], "Debug Cleanup" },
    },

    x = {
      name = "External",
      g = { "<CMD> lua require('config.ide.toggleterm').lazygit()<CR>", "Lazy Git" },
      d = { "<CMD>lua require('config.ide.toggleterm').lazydocker()<CR>", "Lazy Docker" },
      t = { "<CMD>lua require('config.ide.toggleterm').docker_ctop()<CR>", "Docker - ctop" },
      -- y = { "<CMD>lua require('config.ide.toggleterm').docker_dockly()<CR>", "Docker - dockly" },
      s = { "<CMD>lua require('config.ide.toggleterm').navi()<CR>", "Interactive Cheatsheet" },
    },

    z = {
      name = "System",
      -- c = { "<CMD>PackerCompile<CR>", "Compile" },
      c = { "<CMD>Telescope neoclip<CR>", "Clipboard" },
      d = { "<CMD>DiffviewOpen<CR>", "Diff View Open" },
      D = { "<CMD>DiffviewClose<CR>", "Diff View Close" },
      i = { "<CMD>PackerInstall<CR>", "Install" },
      m = { "<CMD>lua require('telescope').extensions.macroscope.default()<CR>", "Macros" },
      p = { "<CMD>PackerProfile<CR>", "Profile" },
      s = { "<CMD>PackerSync<CR>", "Sync" },
      S = { "<CMD>PackerStatus<CR>", "Status" },
      u = { "<CMD>PackerUpdate<CR>", "Update" },
      -- x = { "<CMD>cd %:p:h<CR>", "Change Directory" },
      -- x = { "<CMD>set autochdir<CR>", "Auto ChDir" },
      x = { "<CMD>Telescope cder<CR>", "Change Directory" },
      e = { "!!$SHELL<CR>", "Execute line" },
      z = { "<CMD>lua require'telescope'.extensions.zoxide.list{}<CR>", "Zoxide" },
    },

    g = {
      name = "Git",
      b = { "<CMD>GitBlameToggle<CR>", "Blame" },
      p = { "<CMD>Git push<CR>", "Push" },
      S = { "<CMD>Git<CR>", "Status - Fugitive" },
      g = { "<CMD>lua require('telescope').extensions.gh.gist()<CR>", "Gist" },
      x = { "<CMD>lua require('telescope.builtin').git_branches()<CR>", "Switch Branch" },
    },
  }
  whichkey.register(keymap, opts)
  -- require("legendary.integrations.which-key").bind_whichkey(keymap, opts, false)
  -- false if which-key.nvim handles binding them,
  -- set to true if you want legendary.nvim to handle binding
  -- the mappings; if not passed, true by default
  -- false,
  -- )
end

local function visual_keymap()
  local keymap = {
    -- g = {
    --   name = "Git",
    --   y = {
    --     "<CMD>lua require'gitlinker'.get_buf_range_url('v', {action_callback = require'gitlinker.actions'.open_in_browser})<CR>",
    --     "Link",
    --   },
    -- },
    --
    r = {
      name = "Refactor",
      f = { [[<CMD>lua require('refactoring').refactor('Extract Function')<CR>]], "Extract Function" },
      F = {
        [[ <CMD>lua require('refactoring').refactor('Extract Function to File')<CR>]],
        "Extract Function to File",
      },
      v = { [[<CMD>lua require('refactoring').refactor('Extract Variable')<CR>]], "Extract Variable" },
      i = { [[<CMD>lua require('refactoring').refactor('Inline Variable')<CR>]], "Inline Variable" },
      r = { [[<CMD>lua require('telescope').extensions.refactoring.refactors()<CR>]], "Refactor" },
      d = { [[<CMD>lua require('refactoring').debug.print_var({})<CR>]], "Debug Print Var" },
    },
  }

  whichkey.register(keymap, v_opts)
  -- require("legendary.integrations.which-key").bind_whichkey(keymap, v_opts, false)
end

function M.setup()
  normal_keymap()
  visual_keymap()
  -- code_keymap()
end

return M
