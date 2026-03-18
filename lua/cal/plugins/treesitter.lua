return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  opts = {
    ensure_installed = { "bash", "c", "diff", "html", "lua", "luadoc", "markdown", "vim", "vimdoc" },
  },
  config = function(_, opts)
    local treesitter = require("nvim-treesitter")
    require("nvim-treesitter.install").prefer_git = true
    treesitter.setup({})

    local ensure_installed = opts.ensure_installed or {}
    if #ensure_installed > 0 then
      local installed = treesitter.get_installed()
      local missing = vim.tbl_filter(function(lang)
        return not vim.list_contains(installed, lang)
      end, ensure_installed)

      if #missing > 0 then
        treesitter.install(missing)
      end
    end
  end,
}
