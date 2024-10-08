local catppuccin = {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      transparent_background = vim.g.transparent_enabled,
    })

    vim.cmd.colorscheme("catppuccin-mocha")
  end,
}

local rosepine = {
  "rose-pine/neovim",
  name = "rose-pine",
  lazy = false,
  priority = 1000,
  config = function()
    require("rose-pine").setup({
      styles = {
        transparent = vim.g.transparent_enabled,
      },
    })

    vim.cmd.colorscheme("rose-pine-moon")
  end,
}

return {
  rosepine, -- ONE OF THE THEMES DEFINED ABOVE
  { -- UI TRANSPARENCY
    "xiyaowong/transparent.nvim",
    config = function()
      require("transparent").setup({
        extra_groups = {},
      })

      require("transparent").clear_prefix("lualine")
      require("transparent").clear_prefix("NeoTree")
      require("transparent").clear_prefix("BufferLine")

      vim.keymap.set(
        "n",
        "<Leader>t",
        ":TransparentToggle<CR>",
        { noremap = true, silent = true, desc = "Toggle Transparency" }
      )
    end,
  },
}
