return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local lualine = require("lualine")
    local custom_theme = require("lualine.themes.auto")
    -- Make section backgrounds transparent except for mode and filename (a and z)
    for _, section in pairs({ "normal", "insert", "visual", "replace", "command", "inactive" }) do
      if custom_theme[section] then
        if custom_theme[section].b then
          custom_theme[section].b.bg = "none"
        end
        if custom_theme[section].c then
          custom_theme[section].c.bg = "none"
        end
      end
    end

    lualine.setup({
      options = {
        theme = custom_theme,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = {
          {
            "filename",
            separator = { left = "", right = "" },
            path = 0,
            use_mode_colors = true,
            symbols = {
              modified = "[+]", -- Text to show when the file is modified.
              readonly = "[-]", -- Text to show when the file is non-modifiable or readonly.
              unnamed = "[No Name]", -- Text to show for unnamed buffers.
              newfile = "[New]", -- Text to show for newly created file before first write
            },
          },
        },
        lualine_b = { "branch", { "diff", colored = false }, "diagnostics" },
        lualine_c = {},
        lualine_x = { { "buffers", mode = 4, icons_enabled = false } },
        lualine_y = {},
        lualine_z = { "mode" },
      },
    })
  end,
}
