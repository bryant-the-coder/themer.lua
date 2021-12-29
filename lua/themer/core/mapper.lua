local config = require("themer.config")("get")

---return a cleaned styles
---@param cp table
---@param cs string
---@return table
local function remap_styles(cp)
    local groups = {
        styles = {
            comment = { fg = cp.subtle },
            func = { fg = cp.blue },
            keyword = { fg = cp.magenta },
            string = { fg = cp.green },
            variable = { fg = cp.fg },
            parameter = { fg = cp.yellow },
            field = { fg = cp.fg },
            punc = { fg = cp.subtle },
            heading = {
                h1 = { style = "bold", fg = cp.magenta },
                h2 = { style = "bold", fg = cp.green },
                h3 = { style = "bold", fg = cp.orange },
                h4 = { style = "bold", fg = cp.yellow },
                h5 = { style = "bold", fg = cp.green },
                h6 = { style = "bold", fg = cp.blue },
            },
        },
        diagnostics = {
            colors = { -- Also can be used for stuff like TSError
                hint = cp.magenta,
                info = cp.blue,
                error = cp.red,
                warn = cp.yellow,
            },
        },
    }

    groups.diagnostics.virtual_text = {
        hint = { fg = groups.hint, style = "italic" },
        warn = { fg = groups.warn, style = "italic" },
        info = { fg = groups.info, style = "italic" },
        error = { fg = groups.error, style = "italic" },
    }

    groups.diagnostics.underlines = {
        hint = { sp = groups.hint, style = "undercurl" },
        warn = { sp = groups.warn, style = "undercurl" },
        info = { sp = groups.info, style = "undercurl" },
        error = { sp = groups.error, style = "undercurl" },
    }

    groups = vim.tbl_deep_extend("force", groups, cp.groups or {}, config or {})
    return groups
end

---return the basic hig groups
---@param cp table
---@param cs string
---@return table
local function get_base(cp, cs)
    local groups = remap_styles(cp, cs)
    local maybe_transparent = config.transparent and "NONE" or cp.bg
    cp.built_in = cp.built_in or cp.syntax

    -- Transparent
    cp.bg.base = maybe_transparent and "NONE" or cp.bg.base
    cp.bg.alt = maybe_transparent and "NONE" or cp.bg.base

    -- ---------------------
    -- ░█▀▄░█▀█░█▀▀░█▀▀
    -- ░█▀▄░█▀█░▀▀█░█▀▀
    -- ░▀▀░░▀░▀░▀▀▀░▀▀▀
    -- ---------------------
    local base = {
        -- base groups
        ThemerAccent = { fg = cp.accent },
        ThemerAccentFloat = { fg = cp.accent, bg = cp.bg.alt },
        ThemerFloat = { bg = cp.bg.alt },
        ThemerSelected = { bg = cp.bg.selected },
        ThemerCursor = { bg = cp.fg, fg = cp.bg.base },

        -- umm misc groups
        ThemerDirectory = { fg = cp.directory or "NONE" },

        -- spell stuff
        ThemerSpellBad = { style = config.styles.spell, sp = cp.spell.bad or "NONE" },
        ThemerSpellCap = { style = config.styles.spell, sp = cp.spell.cap or "NONE" },
        ThemerSpellLocal = { style = config.styles.spell, sp = cp.spell["local"] or "NONE" },
        ThemerSpellRare = { style = config.styles.spell, sp = cp.spell.rare or "NONE" },

        -- git diffs
        ThemerDiffAdd = { bg = cp.diff.add },
        ThemerSignAdd = { fg = cp.diff.add },
        ThemerSignChange = { bg = cp.diff.change },
        ThemerSignChange = { fg = cp.diff.change },
        ThemerDiffText = { bg = cp.diff.text or cp.fg },
        ThemerSignText = { fg = cp.diff.text or cp.fg },
        ThemerDiffDelete = { bg = cp.diff.delete },
        ThemerSignDelete = { fg = cp.diff.delete },

        -- syntax highlighting
        ThemerBoolean = { fg = cp.boolean },
        ThemerFunctions = { fg = cp.syntax["function"] },
        ThemerFunctionsBuiltIn = { fg = cp.built_in["function"] },
        ThemerVariables = { fg = cp.syntax.variable },
        ThemerVariablesBuiltIn = { fg = cp.built_in.variable },
        ThemerKeyword = { fg = cp.syntax.keyword },
        ThemerKeywordBuiltIn = { fg = cp.built_in.keyword },
        ThemerStruct = { fg = cp.syntax.struct },
        ThemerString = { fg = cp.syntax.string },
        ThemerParameter = { fg = cp.syntax.parameter },
        ThemerField = { fg = cp.syntax.field },
        ThemerType = { fg = cp.syntax.type },
        ThemerTypeBuiltIn = { fg = cp.built_in.type },
        ThemerProperty = { fg = cp.syntax.property or cp.syntax.variable },
        ThemerPunctuation = { fg = cp.syntax.punctuation },
        ThemerConstructor = { fg = cp.syntax.constructor or cp.syntax.punctuation },
        ThemerOperator = { fg = cp.syntax.operator or cp.sytax.punctuation },
        ThemerPuncDelimiter = { fg = cp.syntax.punc_delimiter or cp.syntax.punctuation },
        ThemerSearchResult = { fg = cp.accent, style = "bold", bg = cp.bg.selected },
        ThemerDimmed = { fg = cp.dimmed.inactive },
        ThemerConstants = { fg = cp.syntax.constant },
        ThemerConstantsBuiltIn = { fg = cp.built_in.constant },
        ThemerSubtle = { fg = cp.dimmed.subtle },

        -- gui and pum stuff
        ThemerButton = { fg = cp.gui.button.base or cp.fg, bg = cp.gui.bg.base or cp.bg.alt },
        ThemerInactiveButton = {
            fg = cp.gui.button.inactive or cp.dimmed.subtle,
            bg = cp.gui.bg.inactive or cp.bg.alt,
        },
        ThemerInactiveSelectedButton = {
            fg = cp.gui.button.inactive_selected or cp.dimmed.subtle,
            bg = cp.gui.bg.selected or cp.bg.selected,
        },
        ThemerSuccessButton = { fg = cp.gui.button.success or cp.diff.add, bg = cp.gui.bg.base or cp.bg.alt },
        ThemerClosedSelectedButton = {
            fg = cp.gui.button.closed or cp.diff.delete,
            bg = cp.gui.bg.selected or cp.bg.selected,
        },
        ThemerSel = { fg = cp.gui.pum.fg or cp.fg, bg = cp.gui.pum.selected or cp.bg.selected },
        ThemerSbar = { fg = cp.gui.pum.sbar or cp.dimmed.inactive },
        ThemerThumb = { fg = cp.gui.pum.thumb or cp.dimmed.subtle },
        ThemerPum = { fg = cp.gui.pum.fg or cp.dimmed.subtle, bg = cp.gui.pum.bg or cp.bg.alt },

        -- lsp stuff
        ThemerError = { fg = cp.diagnostic.error },
        ThemerErrorVirtualText = { fg = cp.diagnostic.error, style = config.diagnostic.virtual_text },
        ThemerErrorUnderline = { fg = cp.diagnostic.error, style = config.diagnostic.underline },
        ThemerErrorFloat = { fg = cp.diagnostic.error, bg = cp.bg.alt },
        ThemerHint = { fg = cp.diagnostic.hint },
        ThemerHintVirtualText = { fg = cp.diagnostic.hint, style = config.diagnostic.virtual_text },
        ThemerHintUnderline = { fg = cp.diagnostic.hint, style = config.diagnostic.underline },
        ThemerHintFloat = { fg = cp.diagnostic.hint, bg = cp.bg.alt },
        ThemerInfo = { fg = cp.diagnostic.info },
        ThemerInfoVirtualText = { fg = cp.diagnostic.info, style = config.diagnostic.virtual_text },
        ThemerInfoUnderline = { fg = cp.diagnostic.info, style = config.diagnostic.underline },
        ThemerInfoFloat = { fg = cp.diagnostic.info, bg = cp.bg.alt },
        ThemerWarn = { fg = cp.diagnostic.warn },
        ThemerWarnVirtualText = { fg = cp.diagnostic.warn, style = config.styles.virtual_text },
        ThemerWarnUnderline = { fg = cp.diagnostic.warn, style = config.styles.underline },
        ThemerWarnFloat = { fg = cp.diagnostic.warn, bg = cp.bg.alt },

        ColorColumn = { bg = cp.bg.selected },
        Conceal = { bg = "NONE" },
        -- Cursor = {},
        CursorColumn = { bg = cp.bg.selected },
        -- CursorIM = {},
        CursorLine = { bg = cp.highlight_inactive },
        CursorLineNr = { fg = cp.fg },
        DarkenedPanel = { bg = cp.bg_alt },
        DarkenedStatusline = { bg = cp.bg_alt },
        DiffAdd = { fg = cp.green },
        DiffChange = { fg = cp.orange },
        DiffDelete = { fg = cp.red },
        DiffText = { fg = cp.fg },
        Directory = { fg = cp.green, bg = cp.none },
        EndOfBuffer = { bg = maybe_transparent },
        ErrorMsg = { fg = cp.red, style = "bold" },
        FloatBorder = { fg = cp.subtle },
        Folded = { fg = cp.fg, bg = maybe_transparent },
        IncSearch = { bg = cp.highlight },
        LineNr = { fg = cp.inactive },
        MatchParen = { fg = cp.fg, bg = cp.bg_float },
        -- ModeMsg = {},
        MoreMsg = { fg = cp.magenta },
        NonText = { fg = cp.inactive },
        Normal = { fg = cp.fg, bg = maybe_transparent },
        NormalNC = { link = "Normal" },
        -- NormalFloat = {},
        Pmenu = { fg = cp.subtle, bg = cp.bg_alt },
        PmenuSbar = { bg = cp.bg_float },
        PmenuSel = { fg = cp.fg, bg = cp.bg_float },
        PmenuThumb = { bg = cp.inactive },
        Question = { fg = cp.yellow },
        -- QuickFixLine = {},
        Search = { fg = cp.magenta, bg = cp.highlight_overlay },
        SpecialKey = { fg = cp.green },
        SpellBad = { style = "undercurl", sp = cp.red },
        SpellCap = { style = "undercurl", sp = cp.subtle },
        SpellLocal = { style = "undercurl", sp = cp.subtle },
        SpellRare = { style = "undercurl", sp = cp.subtle },
        SignColumn = { fg = cp.fg, bg = maybe_transparent },
        StatusLine = { fg = cp.fg, bg = cp.bg_alt },
        StatusLineNC = { fg = cp.subtle, bg = cp.bg_alt },
        -- StatusLineTerm = {},
        -- StatusLineTermNC = {},
        TabLine = { fg = cp.subtle, bg = cp.bg_float },
        TabLineFill = { bg = cp.bg_alt },
        TabLineSel = { fg = cp.fg, bg = cp.inactive },
        Title = { fg = cp.fg },
        VertSplit = { fg = cp.bg_alt, bg = cp.bg_alt },
        Visual = { bg = cp.highlight },
        -- VisualNOS = {},
        WarningMsg = { fg = cp.yellow },
        -- Whitespace = {},
        -- WildMenu = {},
        Boolean = { fg = cp.yellow },
        Character = { fg = cp.yellow },
        Comment = groups.styles.comment,
        Conditional = { fg = cp.blue },
        Constant = { fg = cp.yellow },
        Debug = { fg = cp.orange },
        Define = { fg = cp.magenta },
        Delimiter = { fg = cp.orange },
        Error = { fg = cp.red },
        Exception = { fg = cp.blue },
        Float = { fg = cp.yellow },
        Function = groups.styles.func,
        Identifier = groups.styles.variable,
        -- Ignore = { fg = '' },
        Include = { fg = cp.magenta },
        Keyword = groups.styles.keyword,
        Label = { fg = cp.green },
        Macro = { fg = cp.magenta },
        Number = { fg = cp.yellow },
        Operator = { fg = cp.subtle },
        PreCondit = { fg = cp.magenta },
        PreProc = { fg = cp.magenta },
        Repeat = { fg = cp.blue },
        Special = { fg = cp.orange },
        SpecialChar = { fg = cp.orange },
        SpecialComment = { fg = cp.magenta },
        Statement = { fg = cp.blue },
        StorageClass = { fg = cp.green },
        String = groups.styles.string,
        Structure = { fg = cp.green },
        Tag = { fg = cp.orange },
        Todo = { fg = cp.magenta },
        Type = { fg = cp.green },
        Typedef = { fg = cp.green },
        Underlined = { fg = cp.green, style = "underline" },
    }

    ---------------------------------------
    -- ░█▀█░█░░░█░█░█▀▀░▀█▀░█▀█░█▀▀
    -- ░█▀▀░█░░░█░█░█░█░░█░░█░█░▀▀█
    -- ░▀░░░▀▀▀░▀▀▀░▀▀▀░▀▀▀░▀░▀░▀▀▀
    ---------------------------------------

    local plugins = {}

    local availablePlugins = {
        barbar = {
            BufferTabpageFill = { bg = "NONE" },
            BufferCurrent = { fg = cp.fg, bg = cp.bg_float },
            BufferCurrentIndex = { fg = cp.fg, bg = cp.bg_float },
            BufferCurrentMod = { fg = cp.green, bg = cp.bg_float },
            BufferCurrentSign = { fg = cp.subtle, bg = cp.bg_float },
            BufferInactive = { fg = cp.subtle },
            BufferInactiveIndex = { fg = cp.subtle },
            BufferInactiveMod = { fg = cp.green },
            BufferInactiveSign = { fg = cp.subtle },
            BufferVisible = { fg = cp.subtle },
            BufferVisibleIndex = { fg = cp.subtle },
            BufferVisibleMod = { fg = cp.green },
            BufferVisibleSign = { fg = cp.subtle },
        },

        bufferline = {
            BufferLineFill = { bg = cp.bg_float },
            BufferLineBackground = { fg = cp.subtle, bg = cp.inactive },
            BufferLineBufferVisible = { fg = cp.subtle, bg = cp.inactive },
            BufferLineBufferSelected = { fg = cp.fg, bg = cp.bg },
            BufferLineTab = { fg = cp.subtle, bg = cp.bg },
            BufferLineTabSelected = { fg = cp.red, bg = cp.blue },
            BufferLineTabClose = { fg = cp.red, bg = cp.inactive },
            BufferLineIndicatorSelected = { fg = cp.bg, bg = cp.bg },
            -- separators
            BufferLineSeparator = { fg = cp.inactive, bg = cp.inactive },
            BufferLineSeparatorVisible = { fg = cp.inactive, bg = cp.inactive },
            BufferLineSeparatorSelected = { fg = cp.inactive, bg = cp.inactive },
            -- close buttons
            BufferLineCloseButton = { fg = cp.subtle, bg = cp.inactive },
            BufferLineCloseButtonVisible = { fg = cp.subtle, bg = cp.inactive },
            BufferLineCloseButtonSelected = { fg = cp.red, bg = cp.bg },
        },

        cmp = {
            CmpItemKind = { fg = cp.magenta },
            CmpItemAbbr = { fg = cp.subtle },
            CmpItemAbbrMatch = { fg = cp.fg, style = "bold" },
            CmpItemAbbrMatchFuzzy = { fg = cp.fg, style = "bold" },
            CmpItemAbbrDeprecated = { fg = cp.subtle, style = "strikethrough" },
        },

        gitsigns = {
            SignAdd = { fg = cp.green },
            SignChange = { fg = cp.orange },
            SignDelete = { fg = cp.red },
            GitSignsAdd = { fg = cp.green },
            GitSignsChange = { fg = cp.orange },
            GitSignsDelete = { fg = cp.red },
        },

        indentline = {
            IndentBlanklineChar = { fg = cp.subtle, style = "nocombine" },
            IndentBlanklineIndent6 = { style = "nocombine", fg = cp.yellow },
            IndentBlanklineIndent5 = { style = "nocombine", fg = cp.red },
            IndentBlanklineIndent4 = { style = "nocombine", fg = cp.green },
            IndentBlanklineIndent3 = { style = "nocombine", fg = cp.orange },
            IndentBlanklineIndent2 = { style = "nocombine", fg = cp.blue },
            IndentBlanklineIndent1 = { style = "nocombine", fg = cp.magenta },
        },

        lsp = {
            LspReferenceText = { bg = cp.bg_alt },
            LspReferenceRead = { bg = cp.bg_alt },
            LspReferenceWrite = { bg = cp.bg_alt },
            DiagnosticError = { fg = groups.diagnostics.colors.error },
            DiagnosticWarn = { fg = groups.diagnostics.colors.warn },
            DiagnosticInfo = { fg = groups.diagnostics.colors.info },
            DiagnosticHint = { fg = groups.diagnostics.colors.hint },
            DiagnosticDefaultError = { fg = groups.diagnostics.colors.error },
            DiagnosticDefaultWarn = { fg = groups.diagnostics.colors.warn },
            DiagnosticDefaultInfo = { fg = groups.diagnostics.colors.info },
            DiagnosticDefaultHint = { fg = groups.diagnostics.colors.hint },
            DiagnosticFloatingError = { bg = cp.bg_alt, fg = groups.diagnostics.colors.error },
            DiagnosticFloatingWarn = { bg = cp.bg_alt, fg = groups.diagnostics.colors.warn },
            DiagnosticFloatingInfo = { bg = cp.bg_alt, fg = groups.diagnostics.colors.info },
            DiagnosticFloatingHint = { bg = cp.bg_alt, fg = groups.diagnostics.colors.hint },
            DiagnosticVirtualTextError = groups.diagnostics.virtual_text.error,
            DiagnosticVirtualTextWarn = groups.diagnostics.virtual_text.warn,
            DiagnosticVirtualTextInfo = groups.diagnostics.virtual_text.info,
            DiagnosticVirtualTextHint = groups.diagnostics.virtual_text.hint,
            DiagnosticUnderlineError = groups.diagnostics.underlines.error,
            DiagnosticUnderlineWarn = groups.diagnostics.underlines.warn,
            DiagnosticUnderlineInfo = groups.diagnostics.underlines.info,
            DiagnosticUnderlineHint = groups.diagnostics.underlines.hint,

            LspDiagnosticsError = { link = "DiagnosticError" },
            LspDiagnosticsWarning = { link = "DiagnosticWarn" },
            LspDiagnosticsInformation = { link = "DiagnosticInfo" },
            LspDiagnosticsHint = { link = "DiagnosticHint" },
            LspDiagnosticsDefaultError = { link = "DiagnosticDefaultError" },
            LspDiagnosticsDefaultWarning = { link = "DiagnosticDefaultWarn" },
            LspDiagnosticsDefaultInformation = { link = "DiagnosticDefaultInfo" },
            LspDiagnosticsDefaultHint = { link = "DiagnosticDefaultHint" },
            LspDiagnosticsFloatingError = { link = "DiagnosticFloatingError" },
            LspDiagnosticsFloatingWarning = { link = "DiagnosticFloatingWarn" },
            LspDiagnosticsFloatingInformation = { link = "DiagnosticFloatingInfo" },
            LspDiagnosticsFloatingHint = { link = "DiagnosticFloatingHint" },
            LspDiagnosticsVirtualTextError = { link = "DiagnosticVirtualTextError" },
            LspDiagnosticsVirtualTextWarning = { link = "DiagnosticVirtualTextWarn" },
            LspDiagnosticsVirtualTextInformation = { link = "DiagnosticVirtualTextInfo" },
            LspDiagnosticsVirtualTextHint = { link = "DiagnosticVirtualTextHint" },
            LspDiagnosticsUnderlineError = { link = "DiagnosticUnderlineError" },
            LspDiagnosticsUnderlineWarning = { link = "DiagnosticUnderlineWarn" },
            LspDiagnosticsUnderlineInformation = { link = "DiagnosticUnderlineInfo" },
            LspDiagnosticsUnderlineHint = { link = "DiagnosticUnderlineHint" },

            LspSignatureActiveParameter = { fg = cp.orange },
            LspCodeLens = { fg = cp.subtle },
        },

        telescope = {
            TelescopeBorder = { fg = cp.subtle },
            TelescopeSelectionCaret = { fg = cp.red },
            TelescopeSelection = { fg = cp.fg, bg = cp.highlight_overlay },
            TelescopeMatching = { fg = cp.fg, style = "bold" },
        },

        treesitter = {
            -- TSAnnotation = {},
            -- TSAttribute = {},
            TSBoolean = { fg = cp.orange },
            -- TSCharacter = {},
            TSComment = groups.styles.comment,
            TSNote = { bg = cp.blue, fg = groups.diagnostics.colors.info },
            TSWarning = { bg = cp.bg, fg = groups.diagnostics.colors.warn },
            TSDanger = { bg = cp.bg, fg = groups.diagnostics.colors.error },
            TSConditional = { fg = cp.red },
            TSConstBuiltin = { fg = cp.red },
            -- TSConstMacro = {},
            TSConstant = { fg = cp.orange },
            TSConstructor = { fg = cp.magenta },
            -- TSEmphasis = {},
            -- TSError = {},
            -- TSException = {},
            TSField = groups.styles.field,
            -- TSFloat = {},
            TSFuncBuiltin = { fg = cp.blue },
            -- TSFuncMacro = {},
            TSFunction = groups.styles.func,
            TSInclude = { fg = cp.green },
            TSKeyword = groups.styles.keyword,
            TSKeywordFunction = { fg = cp.magenta },
            TSKeywordOperator = { fg = cp.blue },
            TSLabel = { fg = cp.green },
            -- TSLiteral = {},
            -- TSMethod = {},
            -- TSNamespace = {},
            -- TSNone = {},
            -- TSNumber = {},
            TSOperator = { fg = cp.blue },
            TSParameter = groups.styles.parameter,
            -- TSParameterReference = {},
            TSProperty = groups.styles.field,
            TSPunctBracket = groups.styles.punc,
            TSPunctDelimiter = groups.styles.punc,
            TSPunctSpecial = groups.styles.punc,
            -- TSRepeat = {},
            -- TSStrike = {},
            TSString = groups.styles.string,
            TSStringEscape = { fg = cp.blue },
            -- TSStringRegex = {},
            -- TSSymbol = {},
            TSTag = { fg = cp.green },
            TSTagDelimiter = { fg = cp.subtle },
            TSText = { fg = cp.fg },
            -- TSTitle = {},
            -- TSType = {},
            -- TSTypeBuiltin = {},
            TSURI = { fg = cp.blue, style = "undercurl" },
            -- TSUnderline = {},
            TSVariable = groups.styles.variable,
            TSVariableBuiltin = groups.variable,
        },
    }

    -----------------------------
    -- ░█░░░█▀█░█▀█░█▀▀░█▀▀
    -- ░█░░░█▀█░█░█░█░█░▀▀█
    -- ░▀▀▀░▀░▀░▀░▀░▀▀▀░▀▀▀
    -----------------------------

    local langs = {}

    local availableLangs = {
        html = {
            htmlArg = { fg = cp.magenta },
            htmlEndTag = { fg = cp.subtle },
            htmlLink = { fg = cp.fg },
            htmlTag = { fg = cp.subtle },
            htmlTagN = { fg = cp.fg },
            htmlTagName = { fg = cp.green },
        },

        md = {
            markdownHeadingDelimiter = { fg = cp.subtle },
            markdownCode = { fg = cp.yellow },
            markdownCodeDelimiter = { fg = cp.green },
            markdownCodeBlock = { fg = cp.green },
            markdownH1 = { fg = cp.red, style = "bold" },
            markdownH2 = { fg = cp.red, style = "bold" },
            markdownLinkText = { fg = cp.red },
        },
    }

    for lang, isEnabled in pairs(config.langs) do
        if isEnabled then
            langs[lang] = availableLangs[lang] or {}
        end
    end

    for plugin, isEnabled in pairs(config.plugins) do
        if isEnabled then
            plugins[plugin] = availablePlugins[plugin] or {}
        end
    end

    return {
        base = base,
        plugins = plugins,
        langs = langs,
    }
end

--- return the final integrations table
--- @param cp table
--- @param cs string
--- @return table
local function get_hig_groups(cp, cs)
    local hig_groups = get_base(cp, cs)
    hig_groups = vim.tbl_deep_extend(
        "force",
        hig_groups or {},
        config.remaps.highlights.globals or {},
        cp.remaps or {},
        config.remaps.highlights[cs] or {}
    )

    return hig_groups
end

---get color scheme properties
---@param cp table
---@return table
local function get_properties(cp)
    local props = {
        termguicolors = true,
        background = cp.flavour or "dark",
    }
    return props
end

---return theme table containing highlights
---@param cp table
---@param cs string
---@return table
return function(cp, cs)
    local theme = {}
    theme.colors = cp
    theme.hig_groups = get_hig_groups(cp, cs)
    theme.properties = get_properties(cp)
    return theme
end
