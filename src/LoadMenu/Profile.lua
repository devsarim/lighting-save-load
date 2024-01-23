local ChangeHistoryService = game:GetService("ChangeHistoryService")
local Selection = game:GetService("Selection")
local Lighting = game:GetService("Lighting")

local Roact = require(script.Parent.Parent.Libs.Roact)
local Hooks = require(script.Parent.Parent.Libs.Hooks)

local function loadProfile(profile: Folder)
	for _, child in Lighting:GetChildren() do
		child.Parent = nil
	end

	for _, child in profile:GetChildren() do
		child:Clone().Parent = Lighting
	end

	for key, value in profile:GetAttributes() do
		pcall(function()
			Lighting[key] = value
		end)
	end
end

local function isSelected(instance: Instance)
	local currentSelection = Selection:Get()
	if table.find(currentSelection, instance) then
		return true
	end

	return false
end

local function Profile(props, hooks)
	local selected, setSelected = hooks.useState(isSelected(props.profile))

	hooks.useEffect(function()
		local conn
		conn = Selection.SelectionChanged:Connect(function()
			setSelected(isSelected(props.profile))
		end)

		return function()
			conn:Disconnect()
		end
	end, {})

	return Roact.createElement("ImageButton", {
		Size = UDim2.new(1, 0, 0, 24),

		BackgroundTransparency = 1,

		BorderSizePixel = 0,
		LayoutOrder = 1,

		[Roact.Event.MouseButton1Click] = function()
			Selection:Set({ props.profile })
		end,
	}, {
		Load = Roact.createElement("ImageButton", {
			AnchorPoint = Vector2.new(1, 0),
			Position = UDim2.fromScale(1, 0),
			Size = UDim2.fromScale(0.25, 1),

			BackgroundColor3 = Color3.fromRGB(3, 145, 236),
			BorderSizePixel = 0,

			Visible = selected,

			[Roact.Event.MouseButton1Click] = function()
				loadProfile(props.profile)
				ChangeHistoryService:SetWaypoint("Load lighting profile")
			end,
		}, {
			UICorner = Roact.createElement("UICorner", {
				CornerRadius = UDim.new(0, 4),
			}),

			Content = Roact.createElement("TextLabel", {
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.fromScale(0.5, 0.5),
				Size = UDim2.new(1, 0, 0, 14),

				BackgroundTransparency = 1,
				BorderSizePixel = 0,

				Text = "Load",
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextScaled = true,
			}),
		}),

		ProfileName = Roact.createElement("TextLabel", {
			AnchorPoint = Vector2.new(0, 0.5),
			Position = UDim2.fromScale(0, 0.5),
			Size = UDim2.new(1, 0, 0, 14),

			BackgroundTransparency = 1,
			BorderSizePixel = 0,

			Text = props.profile.Name,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextColor3 = Color3.fromRGB(255, 255, 255),
			TextScaled = true,
		}),
	})
end

return Hooks.new(Roact)(Profile)
