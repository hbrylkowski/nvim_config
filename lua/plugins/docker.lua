-- Better Docker and docker-compose syntax highlighting
---@type LazySpec
return {
  {
    "ekalinin/Dockerfile.vim",
    ft = { "dockerfile", "yaml.docker-compose" },
  },
}
