# License
**WARNING**: This repository and its code is licensed under the Mozilla Public License, version 2.0. You can obtain a copy [here](https://www.mozilla.org/en-US/MPL/2.0/), or open LICENSE in a text editor. Any infringements will void your rights mentioned in the license.
**IMPORTANT**: **This source code form is Incompatible With Secondary Licenses. While the MPL 2.0 license only refers to GNU licenses, this restriction applies to all licenses other than the license included with this repository.**
You are required to license any code, whether unmodified or modified, from this repository under the same license, as you received it.

(Note: The reason secondary licenses are not permitted, is because of certain problematic licenses that harm both the open-source community and my project.)

# imgui-for-roblox
ImGui style Luau UI library for all your quick debugging needs! (unfinished at the moment)


# Tutorial
First, create a new ModuleScript instance inside ReplicatedStorage, lets call it "ImGui".
Copy everything from ImGui.lua and put it in there.
Also, create another ModuleScript called "Themes" and put it inside "ImGui".
(or get the module [from here](https://www.roblox.com/library/13475147376/ImGui-Simple-UI-Library))
Now in that one, we copy contents from Themes.lua (We can use this to make our windows with style!)

This library is very simple at the moment.
Initialize a Window by requiring the module and using the .new function.
Require the themes module as well if you want to use predefined themes.
Themes are completely optional, you can set nil in place of it to use the default theme.
```lua
	local library = require(game.ReplicatedStorage.ImGui)
	local themes = require(game.ReplicatedStorage.ImGui.Themes)
	local window = library.new(
		"My Cool Window!", -- Window title
		Vector2.New(200,200), -- Window size
		nil, -- Can be nil or one of the themes (e.g. themes.Dracula)
		UDim2.fromScale(0.1,0.1) -- Starting position
	)
```

## Want a titlebar icon?
Its very simple.
Since Window instances contain a property pointing back to the CanvasGroup it was created as, this is a piece of cake!
You do need to offset the titlebar text however.
```lua
	local img = Instance.new("ImageLabel")
	local image = "rbxassetid://8382597378"
	img.Image = image
	img.BackgroundTransparency = 1
	img.Size = UDim2.fromOffset(window.WindowInstance.TitleBar.Size.Y.Offset,window.WindowInstance.TitleBar.Size.Y.Offset)
	img.Parent = window.WindowInstance.TitleBar
	window.WindowInstance.TitleBar.TBText.Position = UDim2.new(0,window.WindowInstance.TitleBar.Size.Y.Offset + 8,0,0)
```

## Making some Elements

Lets make some UI Elements now that we have the Window!
Currently theres two types of Elements:

 - Button 	
 - Label

All UIElements are in the order they are created from top to bottom.

Lets make a Button!

```lua
    function myCoolFunction()
	    print("Hello World!")
    end
    
    window.new("Button","Text goes here...", myCoolFunction)
```

So that we have a button, Why not add a label?

```lua
    local label = window.new("Label","My Cool Label!")
```

Also why not make the button change the text of said label?
```lua
	local library = require(game.ReplicatedStorage.ImGui)
	local themes = require(game.ReplicatedStorage.ImGui.Themes)
	local window = library.new(
		"My Cool Window!", -- Window title
		Vector2.New(200,200), -- Window size
		nil, -- Can be nil or one of the themes (e.g. themes.Dracula)
		UDim2.fromScale(0.1,0.1) -- Starting position
	)
	local label = window.new("Label","My Cool Label!")
	-- Now, the reason we put the label inside a variable, is so we can access its .setText() function.
	function myCoolFunction()
		label.setText("You clicked it!")
		print("Hello World!")
	end

	window.new("Button","Change Label Text", myCoolFunction)
```

# Documentation

## Theme
A table that can be passed into Module.new() [see Module.new()](#modulenew)
```lua
{
	ContentColor = Color3.fromRGB(21, 22, 23),
	TitleBarColor = Color3.fromRGB(41, 74,122),
	ButtonColor = Color3.fromRGB(41, 74,122),
	TitleBarTextColor = Color3.fromRGB(255,255,255),
	ContentTextColor = Color3.fromRGB(255,255,255),
	Font = Enum.Font.Gotham,
	CornerRadius = 0
}
```
### Properties
ContentColor - Background color of Window

TitleBarColor - Background color of the Title bar

ButtonColor - Background color of All button instances in applied window

TitleBarTextColor - The title bar's text color

ContentTextColor - Overrides all contained UIElement's TextColor on applied Window

Font - Overrides all contained UIElement's Font on applied Window

CornerRadius - Controls the roundness of the window container and the title bar

## Module.new()
The root function of the whole UI Library.
```lua
function new(Text : string, Size : Vector2, Theme : ImGuiTheme, StartingPosition : UDim2)
```
### Arguments
Text - Text displayed on the titlebar

Size - Size of the window as a Vector2

Theme - Controls the Theme of the Window [see Theme](#theme)

StartingPosition - The position of the window to start in, as a UDim2 (from top-left)

## Window
Window is a special class, as it is a container and the main UIElement for everything.
Can be created via Module.new() [see Module.new()](#modulenew)
### Functions
```lua
function Window.new(ClassName, <ClassArguments>)
```
Creates a new UIElement by ClassName and its arguments.

```lua
function Window.destroy()
```
Destroys the window forever, and makes it out of scope.

## Button
It is a very simple class that can be created by passing the first argument of "Button" (as a string) into the Window.new() function [see Window](#window)
```lua
function Window.new("Button", Text : string, Callback : function)
```
### Class-Specific Arguments
Text - Text thats displayed on the button

Callback - Callback function that gets called once button is clicked (Must not contain brackets and no arguments!)

## Label
It is also a very simple class with a single ClassArgument, can be created by passing the first argument of "Label" (as a string) into the Window.new() function [see Window](#window)
```lua
function Window.new("Label", Text : string)
```
### Class-Specific Arguments
Text - Text displayed on the Label
