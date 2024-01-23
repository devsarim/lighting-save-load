local Roact = require(script.Parent.Libs.Roact)

local Input = require(script.Input)
local Save = require(script.Save)

return function()
	local textBoxRef = Roact.createRef()

	return Roact.createElement("Frame", {
		BackgroundTransparency = 1,
		BorderSizePixel = 0,

		Size = UDim2.new(1, 0, 0, 24),
	}, {
		Input = Roact.createElement(Input, {
			textBoxRef = textBoxRef,
		}),
		Save = Roact.createElement(Save, {
			textBoxRef = textBoxRef,
		}),
	})
end
