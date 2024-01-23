local Roact = require(script.Parent.Parent.Libs.Roact)

return function(props)
	return Roact.createElement("Frame", {
		Size = UDim2.new(0.75, -5, 1, 0),

		BackgroundTransparency = 1,
		BorderSizePixel = 0,
	}, {
		UICorner = Roact.createElement("UICorner", {
			CornerRadius = UDim.new(0, 4),
		}),

		UIStroke = Roact.createElement("UIStroke", {
			Color = Color3.fromRGB(123, 123, 123),
		}),

		TextBox = Roact.createElement("TextBox", {
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			Size = UDim2.new(1, -20, 0, 14),

			BackgroundTransparency = 1,
			BorderSizePixel = 0,

			PlaceholderText = "Enter profile name",
			Text = "",
			TextColor3 = Color3.fromRGB(255, 255, 255),
			TextScaled = true,
			TextXAlignment = Enum.TextXAlignment.Left,

			[Roact.Ref] = props.textBoxRef,
		}),

		-- Placeholder = Roact.createElement("TextLabel", {
		-- 	AnchorPoint = Vector2.new(0.5, 0.5),
		-- 	Position = UDim2.fromScale(0.5, 0.5),
		-- 	Size = UDim2.new(1, -20, 0, 14),

		-- 	BackgroundTransparency = 1,
		-- 	BorderSizePixel = 0,

		-- 	Text = "Enter profile name",
		-- 	TextColor3 = Color3.fromRGB(178, 178, 178),
		-- 	TextScaled = true,
		-- 	TextXAlignment = Enum.TextXAlignment.Left,
		-- }),
	})
end
