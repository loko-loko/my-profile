return {
	-- Second, override the render-markdown settings
	{
		"MeanderingProgrammer/render-markdown.nvim",
		opts = {
			-- Customize code block behavior here
			code = {
				-- Turn code block rendering on or off completely
				enabled = false,

				-- Style of the code block. Options: 'normal', 'language', 'full'
				-- 'full' adds a background color padding across the screen
				style = "full",

				-- Where to put the language name. Options: 'right', 'left'
				position = "right",

				-- Custom width of the code block background
				width = "block",

				-- Padding around the block
				left_pad = 2,
				right_pad = 2,

				-- The highlight group for the code block background
				highlight = "RenderMarkdownCode",
			},
		},
	},
}
