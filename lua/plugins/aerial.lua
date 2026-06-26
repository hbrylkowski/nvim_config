-- Disable treesitter backend for aerial to avoid errors
-- LSP backend is more reliable anyway
return {
  "stevearc/aerial.nvim",
  opts = {
    backends = { "lsp", "markdown", "man" },
  },
}
