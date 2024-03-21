return {
  "GDPereira/gen-lm-studio.nvim",
  opts = {
    model = "mixtral-8x7b", -- The default model to use.
    host = "localhost", -- The host running the Ollama service.
    port = "1234", -- The port on which the Ollama service is listening.
    display_mode = "float", -- The display mode. Can be "float" or "split".
    show_prompt = false, -- Shows the Prompt submitted to Ollama.
    show_model = false, -- Displays which model you are using at the beginning of your chat session.
    quit_map = "q", -- set keymap for quit
    no_auto_close = false, -- Never closes the window automatically.
    debug = false, -- Prints errors and the command which is run.
  },
}
