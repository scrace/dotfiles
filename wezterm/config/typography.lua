local wezterm = require("wezterm")

return {
  --font_size = 13,
  --cell_width = 0.9,
  line_height = 1.2,
  warn_about_missing_glyphs = true,
  font = wezterm.font_with_fallback {
    { -- Default font
      family = "Monaspace Neon",
      weight = "Regular",
      harfbuzz_features = { "calt", "liga", "dlig", "ss01", "ss02", "ss03", "ss04", "ss05", "ss06", "ss07", "ss08" },
    },

    { -- Fallback font
      family = "JetBrains Mono",
      weight = "Medium",
    }
  },

  --[[
  font_rules = {
    { -- Italic
      intensity = "Normal",
      italic = true,
      font = wezterm.font({
        family="Monaspace Xenon",
        style = "Italic",
      })
    },

    { -- Bold
      intensity = "Bold",
      italic = false,
      font = wezterm.font({
        family="Monaspace Krypton",
        weight="Bold",
        })
    },

    { -- Bold Italic
      intensity = "Bold",
      italic = true,
      font = wezterm.font( {
        family="Monaspace Xenon",
        style="Italic",
        weight="Bold",
        }
      )
    },
  },
  ]]--
}
