return {
  "Vigemus/iron.nvim",
  cmd = { "IronRepl", "IronRestart", "IronFocus", "IronHide" },
  keys = {
    { "<leader>rs", "<cmd>IronRepl<cr>", desc = "Toggle REPL" },
    { "<leader>rr", "<cmd>IronRestart<cr>", desc = "Restart REPL" },
    { "<leader>rf", "<cmd>IronFocus<cr>", desc = "Focus REPL" },
    { "<leader>rh", "<cmd>IronHide<cr>", desc = "Hide REPL" },
    { "<leader>sc", mode = "n", desc = "Send line to REPL" },
    { "<leader>ss", mode = "v", desc = "Send selection to REPL" },
    { "<leader>sb", mode = "n", desc = "Send code block to REPL" },
    { "<leader>sn", mode = "n", desc = "Send block and move to next" },
  },
  config = function()
    local iron = require("iron.core")
    local view = require("iron.view")

    iron.setup({
      config = {
        scratch_repl = true,
        repl_definition = {
          python = {
            command = { "uv", "run", "python" },
            format = require("iron.fts.common").bracketed_paste_python,
            block_dividers = { "# %%", "#%%" },
          },
        },
        repl_open_cmd = view.split.vertical.botright(50),
      },
      keymaps = {
        send_motion = "<leader>sc",
        visual_send = "<leader>ss",
        send_code_block = "<leader>sb",
        send_code_block_and_move = "<leader>sn",
      },
      highlight = { italic = true },
      ignore_blank_lines = true,
    })
  end,
}
