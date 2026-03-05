vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight text yank",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- vim.api.nvim_create_autocmd("VimEnter", {
--   callback = function()
--     local keys = { "h", "j", "k", "l" }
--     local last_press = {}
--     local press_count = {}
--     local spam_threshold = 0.5 -- seconds
--
--     local function speak(text)
--       -- This command uses 'say' on macOS. Adjust for other operating systems.
--       vim.fn.jobstart({ "say", text }, { detach = true })
--     end
--
--     local function create_mapping(modes)
--       for _, key in ipairs(keys) do
--         vim.keymap.set(modes, key, function()
--           local current_time = vim.loop.hrtime() / 1e9
--           local count = vim.v.count1
--
--           if last_press[key] and (current_time - last_press[key] < spam_threshold) and count == 1 then
--             press_count[key] = (press_count[key] or 0) + 1
--             if press_count[key] > 2 then
--               speak("move properly bozo!")
--               return ""
--             end
--           else
--             press_count[key] = 1
--           end
--
--           last_press[key] = current_time
--           return key
--         end, { noremap = true, expr = true })
--       end
--     end
--
--     -- Create mappings for normal and visual modes
--     create_mapping({ "n", "v" })
--   end,
-- })

-- Adjust line length color column for rust files
vim.api.nvim_create_autocmd("Filetype", { pattern = "rust", command = "set colorcolumn=100" })

-- Shorter columns for text
local text = vim.api.nvim_create_augroup("text", { clear = true })
for _, pat in ipairs({ "text", "markdown", "gitcommit" }) do
  vim.api.nvim_create_autocmd("Filetype", {
    pattern = pat,
    group = text,
    command = "setlocal tw=72 colorcolumn=73",
  })
end

vim.diagnostic.config({
  virtual_lines = { only_current_line = true },
})
