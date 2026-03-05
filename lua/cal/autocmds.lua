vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight text yank",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local keys = { "h", "j", "k", "l" }
    local last_press = {}
    local press_count = {}
    local warned_in_burst = {}
    local spam_threshold = 0.5 -- seconds

    local function speak(text)
      if vim.fn.executable("say") == 1 then
        vim.fn.jobstart({ "say", text }, { detach = true })
      else
        vim.notify(text, vim.log.levels.INFO, { title = "training-mode" })
      end
    end

    local function create_mapping(modes)
      for _, key in ipairs(keys) do
        vim.keymap.set(modes, key, function()
          local current_time = vim.uv.hrtime() / 1e9
          local count = vim.v.count1
          local repeated = last_press[key] and (current_time - last_press[key] < spam_threshold) and count == 1

          if repeated then
            press_count[key] = (press_count[key] or 1) + 1
          else
            press_count[key] = 1
            warned_in_burst[key] = false
          end

          last_press[key] = current_time

          if press_count[key] > 2 then
            if not warned_in_burst[key] then
              speak("move properly bozo!")
              warned_in_burst[key] = true
            end
            return ""
          end

          return key
        end, { noremap = true, expr = true })
      end
    end

    -- Create mappings for normal and visual modes
    create_mapping({ "n", "v" })
  end,
})

-- Adjust line length color column for rust files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "rust",
  callback = function()
    vim.opt_local.colorcolumn = "100"
  end,
})

-- Shorter columns for text
local text = vim.api.nvim_create_augroup("text", { clear = true })
for _, pat in ipairs({ "text", "markdown", "gitcommit" }) do
  vim.api.nvim_create_autocmd("FileType", {
    pattern = pat,
    group = text,
    command = "setlocal tw=72 colorcolumn=73",
  })
end

vim.diagnostic.config({
  virtual_lines = { only_current_line = true },
})
