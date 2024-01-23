local ChangeHistoryService = game:GetService("ChangeHistoryService")
local CollectionService = game:GetService("CollectionService")
local ServerStorage = game:GetService("ServerStorage")
local Lighting = game:GetService("Lighting")

local Roact = require(script.Parent.Parent.Libs.Roact)
local DumpParser = require(script.Parent.Parent.Libs.DumpParser)
local Filter = DumpParser.Filter

local Dump = DumpParser.fetchFromServer()

local function createProfile()
	local lightingDump = Dump:GetClass("Lighting")
	local properties = lightingDump:GetProperties(
		Filter.Invert(Filter.Deprecated),
		Filter.HasSecurity("None"),
		Filter.Scriptable,
		Filter.Invert(Filter.ReadOnly),
		Filter.Invert(Filter.ValueType("Instance"))
	)

	local profileFolder = Instance.new("Folder")

	for property in properties do
		profileFolder:SetAttribute(property, Lighting[property])
	end

	for _, child in Lighting:GetChildren() do
		child:Clone().Parent = profileFolder
	end

	return profileFolder
end

local function determineParent()
	local parentCounts = {}

	for _, profile in CollectionService:GetTagged("LightingProfile") do
		if not parentCounts[profile.Parent] then
			parentCounts[profile.Parent] = 1
		else
			parentCounts[profile.Parent] += 1
		end
	end

	local highestCount = 0
	local commonParent = ServerStorage

	for parent, count in parentCounts do
		if count > highestCount then
			commonParent = parent
		end
	end

	return commonParent
end

return function(props)
	local textBox = props.textBoxRef:getValue()

	return Roact.createElement("ImageButton", {
		AnchorPoint = Vector2.new(1, 0),
		Position = UDim2.fromScale(1, 0),
		Size = UDim2.fromScale(0.25, 1),

		BackgroundColor3 = Color3.fromRGB(3, 145, 236),
		BorderSizePixel = 0,

		[Roact.Event.MouseButton1Click] = function()
			local profileName = textBox.Text
			if profileName == "" then
				return
			end

			textBox.Text = ""

			local profile = createProfile()
			profile.Name = profileName
			profile:AddTag("LightingProfile")
			profile.Parent = determineParent()

			ChangeHistoryService:SetWaypoint("Create lighting profile")
		end,
	}, {
		UICorner = Roact.createElement("UICorner", {
			CornerRadius = UDim.new(0, 4),
		}),

		Content = Roact.createElement("TextLabel", {
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			Size = UDim2.new(1, 0, 0, 14),

			Text = "Save",
			TextColor3 = Color3.fromRGB(255, 255, 255),
			TextScaled = true,

			BackgroundTransparency = 1,
			BorderSizePixel = 0,
		}),
	})
end
