-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 256, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics = { virtual_text = true, virtual_lines = false }, -- diagnostic settings on startup
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- passed to `vim.filetype.add`
    filetypes = {
      -- see `:h vim.filetype.add` for usage
      extension = {
        foo = "fooscript",
      },
      filename = {
        [".foorc"] = "fooscript",
        -- Docker compose files - use yaml.docker-compose for better highlighting if available
        ["docker-compose.yml"] = "yaml.docker-compose",
        ["docker-compose.yaml"] = "yaml.docker-compose",
        ["compose.yml"] = "yaml.docker-compose",
        ["compose.yaml"] = "yaml.docker-compose",
      },
      pattern = {
        [".*/etc/foo/.*"] = "fooscript",
        -- Match docker-compose.*.yml files (overrides)
        ["docker%-compose%..*%.yml"] = "yaml.docker-compose",
        ["docker%-compose%..*%.yaml"] = "yaml.docker-compose",
        -- Kubernetes manifest files
        [".*/k8s/.*%.ya?ml"] = "yaml.kubernetes",
        [".*/kubernetes/.*%.ya?ml"] = "yaml.kubernetes",
        [".*/manifests/.*%.ya?ml"] = "yaml.kubernetes",
        [".*/helm/.*%.ya?ml"] = "yaml.kubernetes",
        [".*/deploy/.*%.ya?ml"] = "yaml.kubernetes",
        [".*%.ya?ml"]= function(path, bufnr)
          local content = vim.api.nvim_buf_get_lines(bufnr, 0, 20, false)
          for _, line in ipairs(content) do
            if line:match("^apiVersion:%s*k8s%.io") or 
               line:match("^apiVersion:%s*v%d+") or
               line:match("^kind:%s*Deployment") or
               line:match("^kind:%s*Service") or
               line:match("^kind:%s*ConfigMap") or
               line:match("^kind:%s*Secret") or
               line:match("^kind:%s*Ingress") or
               line:match("^kind:%s*Pod") or
               line:match("^kind:%s*DaemonSet") or
               line:match("^kind:%s*StatefulSet") or
               line:match("^kind:%s*Job") or
               line:match("^kind:%s*CronJob") or
               line:match("^kind:%s*ReplicaSet") or
               line:match("^kind:%s*PersistentVolume") then
              return "yaml.kubernetes"
            end
          end
          return "yaml"
        end,
      },
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        relativenumber = true, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = false, -- sets vim.opt.spell
        signcolumn = "yes", -- sets vim.opt.signcolumn to yes
        wrap = false, -- sets vim.opt.wrap
        syntax = "on", -- enable vim regex syntax highlighting
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      n = {
        -- second key is the lefthand side of the map

        -- navigate buffer tabs
        ["]b"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        ["[b"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

        -- mappings seen under group name "Buffer"
        ["<Leader>bd"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Close buffer from tabline",
        },

        -- tables with just a `desc` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        -- ["<Leader>b"] = { desc = "Buffers" },

        -- setting a mapping to false will disable it
        -- ["<C-S>"] = false,
      },
    },
    -- Enable vim regex syntax highlighting as fallback for disabled treesitter
    autocmds = {
      syntax_fallback = {
        {
          event = "FileType",
          desc = "Enable vim syntax highlighting fallback",
          callback = function()
            if not vim.bo.syntax or vim.bo.syntax == "" then
              vim.cmd("set syntax=on")
            end
          end,
        },
      },
    },
  },
}
