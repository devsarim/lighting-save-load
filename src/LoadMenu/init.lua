local CollectionService = game:GetService("CollectionService")

local Roact = require(script.Parent.Libs.Roact)
local Hooks = require(script.Parent.Libs.Hooks)

local Profile = require(script.Profile)

local function LoadMenu(_, hooks)
	local profiles, setProfiles = hooks.useState({})

	hooks.useEffect(function()
		local addedConn, removedConn

		local function updateProfiles()
			local newProfiles = {}

			for _, profile in CollectionService:GetTagged("LightingProfile") do
				if profile.Parent == nil then
					continue
				end

				table.insert(newProfiles, profile)

				profile:GetPropertyChangedSignal("Name"):Connect(updateProfiles)
			end

			setProfiles(newProfiles)
		end

		updateProfiles()
		addedConn = CollectionService:GetInstanceAddedSignal("LightingProfile"):Connect(updateProfiles)
		removedConn = CollectionService:GetInstanceRemovedSignal("LightingProfile"):Connect(updateProfiles)

		return function()
			addedConn:Disconnect()
			removedConn:Disconnect()
		end
	end, {})

	local children = {
		UIListLayout = Roact.createElement("UIListLayout", {
			Padding = UDim.new(0, 5),
			SortOrder = Enum.SortOrder.LayoutOrder,
		}),
	}

	for idx, profileFolder in profiles do
		children[idx] = Roact.createElement(Profile, {
			profile = profileFolder,
		})
	end

	return Roact.createElement("ScrollingFrame", {
		AutomaticCanvasSize = Enum.AutomaticSize.XY,
		Size = UDim2.new(1, 0, 1, -29),
		CanvasSize = UDim2.new(),

		BackgroundTransparency = 1,
		BorderSizePixel = 0,

		ScrollBarThickness = 0,
	}, children)
end

return Hooks.new(Roact)(LoadMenu)
