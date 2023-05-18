--[[
	ImGui style UI library for all your quick debugging needs!
	
	By: NoTexturesLoaded
]]

local module = {}
local ui = Instance.new("ScreenGui",game.Players.LocalPlayer.PlayerGui)
ui.Name = "ImGui"
ui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ui.IgnoreGuiInset = true

local globalDefaultTheme = {
	ContentColor = Color3.fromRGB(21, 22, 23),
	TitleBarColor = Color3.fromRGB(41, 74,122),
	ButtonColor = Color3.fromRGB(41, 74,122),
	TitleBarTextColor = Color3.fromRGB(255,255,255),
	ContentTextColor = Color3.fromRGB(255,255,255),
	Font = Enum.Font.Gotham,
	CornerRadius = 0
}

local currentTheme = globalDefaultTheme

local scale = 1.5

function addCorner(uiElement)
	local c = Instance.new("UICorner",uiElement)
	c.CornerRadius = UDim.new(0,currentTheme.CornerRadius)
end

function makeLabel(text)
	local tT = Instance.new("TextLabel")
	tT.TextXAlignment = Enum.TextXAlignment.Left
	tT.Position = UDim2.fromOffset(8 * scale,0)
	tT.Size = UDim2.new(1,0,0,16 * scale)
	tT.BackgroundTransparency = 1
	tT.Font = currentTheme.Font
	tT.TextSize = 12 * scale
	tT.Text = text
	tT.TextColor3 = currentTheme.ContentTextColor
	tT.Name = "UIElement"
	return tT
end

function makeButton(text,callback,tc)
	local tT = Instance.new("TextButton")
	tT.BackgroundColor3 = currentTheme.ButtonColor
	tT.BorderSizePixel = 0
	tT.AnchorPoint = Vector2.new(0.5,0)
	tT.Position = UDim2.new(0.5,0,0,0)
	tT.Size = UDim2.new(1,-16 * scale,0,18 * scale)
	tT.BackgroundTransparency = 0
	tT.Font = currentTheme.Font
	tT.TextSize = 12 * scale
	tT.Text = text
	tT.TextColor3 = currentTheme.ContentTextColor
	tT.MouseButton1Click:Connect(callback)
	tT.Name = "UIElement"
	return tT
end

function makeWindow(text,size,sp)
	local win = Instance.new("CanvasGroup")
	addCorner(win)
	win.Name = text
	win.ClipsDescendants = true
	win.BorderSizePixel = 0
	local title = Instance.new("CanvasGroup",win)
	title.Name = "TitleBar"
	title.BorderSizePixel = 0
	title.ClipsDescendants = true
	local content = Instance.new("CanvasGroup",win)
	content.Name = "Content"
	content.ClipsDescendants = true
	local uO = Instance.new("UIPadding")
	local button = Instance.new("TextButton")
	button.BackgroundTransparency = 1
	button.Size = UDim2.fromOffset(18 * scale,18 * scale)
	button.AnchorPoint = Vector2.new(1,0)
	button.Position = UDim2.fromScale(1,0)
	button.Text = "X"
	button.TextColor3 = currentTheme.TitleBarTextColor
	button.Font = currentTheme.Font
	button.TextSize = 18 * scale
	button.Parent = title
	button.MouseButton1Click:Connect(function()
		win.Visible = false
	end)
	uO.Parent = content
	uO.PaddingTop = UDim.new(0,8 * scale)
	content.Size = UDim2.new(1,0,1,-18 * scale)
	content.Position = UDim2.fromOffset(8,18 * scale)
	content.BackgroundTransparency = 1
	title.Size = UDim2.new(1,0,0,18 * scale)
	local listLay = Instance.new("UIListLayout",content)
	listLay.SortOrder = Enum.SortOrder.LayoutOrder
	listLay.Padding = UDim.new(0,2)
	local tT = Instance.new("TextLabel",title)
	tT.TextXAlignment = Enum.TextXAlignment.Left
	tT.Position = UDim2.fromOffset(8 * scale,0)
	tT.Font = currentTheme.Font
	tT.Size = UDim2.fromScale(1,1)
	tT.BackgroundTransparency = 1
	tT.TextSize = 12 * scale
	tT.Text = text
	tT.TextColor3 = currentTheme.TitleBarTextColor
	win.Size = UDim2.fromOffset(size.X * scale,size.Y * scale)
	win.Position = sp
	win.BackgroundColor3 = currentTheme.ContentColor
	title.BackgroundColor3 = currentTheme.TitleBarColor
	
	local UserInputService = game:GetService("UserInputService")

	local gui = win

	local dragging
	local dragInput
	local dragStart
	local startPos

	local function update(input)
		local delta = input.Position - dragStart
		gui:TweenPosition(UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y), 'Out', 'Linear', 0, true)
	end

	gui.InputBegan:Connect(function(input)
		pcall(function()
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				dragging = true
				dragStart = input.Position
				startPos = gui.Position

				input.Changed:Connect(function()
					if input.UserInputState == Enum.UserInputState.End then
						dragging = false
					end
				end)
			end
		end)
	end)

	gui.InputChanged:Connect(function(input)
		pcall(function()
			if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
				dragInput = input
			end
		end)
	end)

	UserInputService.InputChanged:Connect(function(input)
		pcall(function()
			if input == dragInput and dragging then
				update(input)
			end
		end)
	end)
	
	win.Parent = ui
	
	return {
		WindowInstance = win,
		new = function(ClassName,...)
			if ClassName == "Label" then
				local label = makeLabel(...)
				addCorner(label)
				label.Parent = content
				return {
					LabelInstance = label,
					setText = function(newText)
						label.Text = newText
					end,
				}
			elseif ClassName == "Button" then
				local button = makeButton(...)
				addCorner(button)
				button.Parent = content
				return {
					ButtonInstance = button,
					setText = function(newText)
						button.Text = newText
					end,
				}
			end
		end,
		destroy = function()
			win:Destroy()
		end,
	}
end

function module.new(Text,Size,Theme,StartingPosition)
	Theme = Theme or nil
	if not Theme then
		currentTheme = globalDefaultTheme
	else
		currentTheme = Theme
	end
	local win = makeWindow(Text,Size,StartingPosition)
	return win
end

return module
