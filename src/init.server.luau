local Roact = require(script.Libs.Roact)
local SaveMenu = require(script.SaveMenu)
local LoadMenu = require(script.LoadMenu)

local Toolbar = plugin:CreateToolbar("Lighting Save/Load")

local ToggleGuiButton = Toolbar:CreateButton("Lighting Profiles", "View lighting profiles", "rbxassetid://16062413484")
ToggleGuiButton.ClickableWhenViewportHidden = false

local InterfaceInfo = DockWidgetPluginGuiInfo.new(Enum.InitialDockState.Float, false, true, 300, 250, 300, 250)
local Interface = plugin:CreateDockWidgetPluginGui("Lighting Profiles", InterfaceInfo)
Interface.Title = "Lighting Profiles"

ToggleGuiButton.Click:Connect(function()
	Interface.Enabled = not Interface.Enabled
end)

local App = Roact.createElement("Frame", {
	BackgroundTransparency = 1,
	BorderSizePixel = 0,

	Size = UDim2.fromScale(1, 1),
}, {
	UIPadding = Roact.createElement("UIPadding", {
		PaddingTop = UDim.new(0, 10),
		PaddingRight = UDim.new(0, 10),
		PaddingBottom = UDim.new(0, 10),
		PaddingLeft = UDim.new(0, 10),
	}),

	UIListLayout = Roact.createElement("UIListLayout", {
		Padding = UDim.new(0, 5),
		SortOrder = Enum.SortOrder.LayoutOrder,
	}),

	SaveMenu = Roact.createElement(SaveMenu),
	LoadMenu = Roact.createElement(LoadMenu),
})

Roact.mount(App, Interface, "Wrapper")
