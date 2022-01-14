local base = {
   white = "#D3C6AA",
   darker_black = "#272f35",
   black = "#2b3339", --  nvim bg
   black2 = "#323a40",
   one_bg = "#333b41",
   one_bg2 = "#363e44",
   one_bg3 = "#3a4248",
   grey = "#4a5258",
   grey_fg = "#50585e",
   grey_fg2 = "#545c62",
   light_grey = "#586066",
   red = "#e67e80",
   baby_pink = "#ce8196",
   pink = "#ff75a0",
   line = "#3a4248", -- for lines like vertsplit
   green = "#83c092",
   vibrant_green = "#a7c080",
   nord_blue = "#78b4ac",
   blue = "#7393b3",
   yellow = "#dbbc7f",
   sun = "#d1b171",
   purple = "#b4bbc8",
   dark_purple = "#d699b6",
   teal = "#69a59d",
   orange = "#e69875",
   cyan = "#95d1c9",
   statusline_bg = "#2e363c",
   lightbg = "#3d454b",
   lightbg2 = "#333b41",
   pmenu_bg = "#83c092",
   folder_bg = "#7393b3",
    base00 = "#2b3339",
    base01 = "#323c41",
    base02 = "#3a4248",
    base03 = "#868d80",
    base04 = "#d3c6aa",
    base05 = "#d3c6aa",
    base06 = "#e9e8d2",
    base07 = "#fff9e8",
    base08 = "#7fbbb3",
    base09 = "#d699b6",
    base0A = "#83c092",
    base0B = "#dbbc7f",
    base0C = "#e69875",
    base0D = "#a7c080",
    base0E = "#e67e80",
    base0F = "#d699b6"
}

local cp = {
    -- Legacy colors for compatibility
    red = base.red,
    yellow = base.yellow,
    orange = base.orange,
    magenta = base.dark_purple,
    blue = base.blue,
    green = base.green,
    cyan = base.teal,

    -- The new shiny boy
    directory = base.folder_bg,
    fg = base.white,
    diff = {
        add = base.green,
        remove = base.red,
        text = base.blue,
        change = base.yellow,
    },
    accent = base.base0C,
    search_result = { fg = base.base01, bg = base.base0A, telescope = base.base0A },
    match = base.base06,
    dimmed = {
        inactive = base.base03,
        subtle = base.grey_fg,
    },
    bg = {
        base = base.base00,
        alt = base.darker_black,
        selected = base.base02,
    },
    border = base.blue,
    syntax = {
        statement = base.base08,
        ["function"] = base.base0D,
        variable = base.base05,
        include = base.base0D,
        keyword = base.base0E,
        struct = base.base0E,
        string = base.base0B,
        identifier = base.base08,
        field = base.base08,
        parameter = base.base08,
        property = base.base08,
        punctuation = base.base0F,
        constructor = base.base0C,
        operator = base.base05,
        preproc = base.base0A,
        constant = base.base09,
        todo = { fg = base.base0A, bg = base.base01 },
        number = base.base09,
        comment = base.base03,
        type = base.base0A,
        conditional = base.base0E,
    },
    built_in = {
        ["function"] = base.base0C,
        type = base.base0A,
        variable = base.base0C,
        keyword = base.base0E,
        constant = base.base09,
    },
    diagnostic = {
        error = base.red,
        warn = base.yellow,
        info = base.green,
        hint = base.purple,
    },
    inc_search = { fg = base.base01, bg = base.base09 },
    uri = base.base08,
    pum = {
        fg = base.base06,
        bg = base.one_bg,
        sbar = base.one_bg2,
        thumb = base.nord_blue,
        sel = {
            bg = base.pmenu_bg,
            fg = base.base05,
        },
    },
    heading = {
        h1 = base.blue,
        h2 = base.blue,
    },
}

return cp
