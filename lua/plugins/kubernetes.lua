-- Kubernetes manifest file support
---@type LazySpec
return {
  {
    "andrewstuart/vim-kubernetes",
    ft = { "yaml", "yaml.docker-compose", "yaml.kubernetes" },
  },
}
