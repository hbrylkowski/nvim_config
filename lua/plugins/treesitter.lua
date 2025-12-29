-- Customize Treesitter

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = { 'go', 'lua', 'typescript', 'javascript', 'json', 'yaml', 'html', 'css', 'bash', 'python', 'markdown', 'scala' },
    highlight = {
      enable = true,
    },
  },
}
