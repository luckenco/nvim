return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup()

    local slots = { "1", "2", "3", "4" }
    for idx, key in ipairs(slots) do
      vim.keymap.set("n", string.format("<leader>a%s", key), function()
        harpoon:list():replace_at(idx)
      end, { desc = string.format("Harpoon set file %d", idx) })
    end

    for idx, key in ipairs(slots) do
      vim.keymap.set("n", string.format("<leader>%s", key), function()
        harpoon:list():select(idx)
      end, { desc = string.format("Harpoon goto file %d", idx) })
    end
  end,
}
