local hi = {}
local config = require("themer.config").options
function hi.get(cp)
    local groups = require("themer.core.groups").get_groups(cp)
    return {
        -- TSAnnotation = {},
        -- TSAttribute = {},
        TSBoolean = { fg = cp.orange },
        -- TSCharacter = {},
        TSComment = groups.comment,
        TSNote = { fg = cp.bg, bg = groups.info.fg },
        TSWarning = { fg = cp.bg, bg = groups.warn.fg },
        TSDanger = { fg = cp.bg, bg = groups.error.fg },
        TSConditional = { fg = cp.red },
        TSConstBuiltin = { fg = cp.red },
        -- TSConstMacro = {},
        TSConstant = { fg = cp.orange },
        TSConstructor = { fg = cp.magenta },
        -- TSEmphasis = {},
        -- TSError = {},
        -- TSException = {},
        TSField = { fg = cp.red },
        -- TSFloat = {},
        TSFuncBuiltin = { fg = cp.blue },
        -- TSFuncMacro = {},
        TSFunction = groups.functions,
        TSInclude = { fg = cp.green },
        TSKeyword = groups.keywords,
        TSKeywordFunction = { fg = cp.magenta },
        TSKeywordOperator = { fg = cp.blue },
        TSLabel = { fg = cp.green },
        -- TSLiteral = {},
        -- TSMethod = {},
        -- TSNamespace = {},
        -- TSNone = {},
        -- TSNumber = {},
        TSOperator = { fg = cp.blue },
        TSParameter = groups.parameters,
        -- TSParameterReference = {},
        TSProperty = groups.fields,
        TSPunctBracket = groups.punctuation,
        TSPunctDelimiter = groups.punctuation,
        TSPunctSpecial = groups.punctuation,
        -- TSRepeat = {},
        -- TSStrike = {},
        TSString = groups.strings,
        TSStringEscape = { fg = cp.blue },
        -- TSStringRegex = {},
        -- TSSymbol = {},
        TSTag = { fg = cp.green },
        TSTagDelimiter = { fg = cp.subtle },
        TSText = { fg = cp.fg },
        -- TSTitle = {},
        -- TSType = {},
        -- TSTypeBuiltin = {},
        TSURI = { fg = cp.blue, undercurl = true },
        -- TSUnderline = {},
        TSVariable = groups.variables,
        TSVariableBuiltin = { fg = cp.red },
    }
end

return hi
