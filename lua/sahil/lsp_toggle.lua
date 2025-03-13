local M = {}

M.active_ts_server = "ts_ls"

M.tsgo_path = "/Users/naransahil/development/typescript-go/built/local/tsgo"

function M.use_tsgo()
  return M.active_ts_server == "tsgo"
end

function M.use_ts_ls()
  return M.active_ts_server == "ts_ls"
end

function M.set_tsgo()
  M.active_ts_server = "tsgo"
end

function M.set_ts_ls()
  M.active_ts_server = "ts_ls"
end

function M.toggle_ts_server()
  if M.active_ts_server == "ts_ls" then
    M.set_tsgo()
    vim.notify("Switched to TypeScript-Go LSP", vim.log.levels.INFO)
    vim.g.ts_server_type = "TypeScript-Go"
  else
    M.set_ts_ls()
    vim.notify("Switched to standard TypeScript LSP", vim.log.levels.INFO)
    vim.g.ts_server_type = "TypeScript"
  end

  vim.cmd("LspRestart")

  vim.defer_fn(function()
    local msg = "Active TypeScript server: " .. (M.use_tsgo() and "tsgo 🚀" or "standard ts_ls 📝")
    vim.api.nvim_echo({ { msg, "WarningMsg" } }, true, {})
  end, 1000) -- Wait a second for LSP to restart
end

vim.api.nvim_create_user_command("TSServerCheck", function()
  local is_tsgo = M.use_tsgo()
  local server_name = is_tsgo and "TypeScript-Go (tsgo)" or "Standard TypeScript Server (ts_ls)"
  local icon = is_tsgo and "🚀" or "📝"

  vim.api.nvim_echo({ {
    "Currently active TypeScript server: " .. server_name .. " " .. icon,
    "WarningMsg"
  } }, true, {})

  vim.defer_fn(function()
    vim.api.nvim_echo({ {
      "For confirmation, run :LspInfo to see the active language servers",
      "Comment"
    } }, true, {})
  end, 2000)
end, { desc = "Check which TypeScript server is currently active" })

return M

-- Update commands:
-- git pull
-- git submodule update --recursive
-- npx hereby build
