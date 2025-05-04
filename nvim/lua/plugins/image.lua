return {
  {
    "3rd/image.nvim",
    -- so that it doesn't build the rock
    -- https://github.com/3rd/image.nvim/issues/91#issuecomment-2453430239
    build = false,
    opts = {
      processor = "magick_cli",
    },
    config = function()
      require("image").setup({
        -- Use the ueberzug backend
        backend = "ueberzug",
        -- do whatever you want with image.nvim's integrations
        integrations = {
          markdown = {
            enabled = true,
            clear_in_insert_mode = false,
            download_remote_images = true,
            only_render_image_at_cursor = false,
            only_render_image_at_cursor_mode = "popup",
            -- if true, images will be rendered in floating markdown windows
            floating_windows = false,
            -- markdown extensions (ie. quarto) can go here
            filetypes = { "markdown", "vimwiki" },
          },
        },
        max_width = 100, -- tweak to preference
        max_height = 12, -- ^
        -- this is necessary for a good experience
        max_height_window_percentage = math.huge,
        max_width_window_percentage = math.huge,
        window_overlap_clear_enabled = true,
        window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
      })
    end,
  }
}
