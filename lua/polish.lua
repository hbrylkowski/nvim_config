-- This will run last in the setup process.
-- This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

vim.o.scrolloff = 20;
vim.o.sidescrolloff = 8;

vim.api.nvim_create_autocmd("VimEnter", {
  desc = "Auto open neo-tree on startup",
  callback = function()
    -- This command opens Neo-tree and focuses back on the file window
    vim.cmd("Neotree action=show")
    -- Use this alternative if you want focus to stay in the Neo-tree window
    -- vim.cmd("Neotree")
  end,
})

