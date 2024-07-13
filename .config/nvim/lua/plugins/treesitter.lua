return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup {
      ensure_installed = {
        "lua",
        "javascript",
        "angular",
        "astro",
        "bash",
        "css",
        "dockerfile",
        "dot",
        "go",
        "hcl",
        "helm",
        "html",
        "jq",
        "json",
        "markdown",
        "nix",
        "php",
        "prisma",
        "python",
        "rust",
        "sql",
        "tsx",
        "typescript",
        "vue",
        "yaml",
      },
      highlight = { enabled = true },
      indent = { enabled = true },
    }
  end,
}
