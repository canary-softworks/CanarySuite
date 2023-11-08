--!strict

-- // Package

local MDify = { }

-- // Variables

local MarkdownPatterns = {
	"*%*%*[%w%p%s]-*%*%*",
	"*%*[%w%p%s]-*%*",
	"%*[%w%p%s]-%*",
	"~~[%w%p%s]-~~",
	"`[%w%p%s]-`",
	"__[%w%p%s]-__",
	"==[%w%p%s]-==",
}

local MarkdownSyntax = {
	"***",
	"**",
	"*",
	"~~",
	"`",
	"__",
	"==",
}

local RichTextSyntax = {
	{"<b><i>", "</i></b>"},
	{"<b>", "</b>"},
	{"<i>", "</i>"},
	{"<s>", "</s>"},
	{"<font family='rbxasset://fonts/families/RobotoMono.json'>", "</font>"},
	{"<u>", "</u>"},
	{"<font color='rgb(255,231,96)'>", "</font>"},
}

-- // Functions

function MDify.MarkdownToRichText(text: string, emojiColor: "d" | "md" | "m" | "ml" | "l"?): string
	for patternIndex, markdownPattern in MarkdownPatterns do
		text = text:gsub(
			markdownPattern,
			function(result)
				return `{RichTextSyntax[patternIndex][1]}{result:gsub(MarkdownSyntax[patternIndex], "")}{RichTextSyntax[patternIndex][2]}`
			end
		)
	end
	
	return text
end

-- // Connections

-- // Actions

return MDify