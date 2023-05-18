
# imgui-for-roblox
ImGui style Luau UI library for all your quick debugging needs! (unfinished at the moment)


# Tutorial
First, create a new ModuleScript instance inside ReplicatedStorage, lets call it "ImGui".
Copy everything from ImGui.lua and put it in there.
Also, create another ModuleScript called "Themes" and put it inside "ImGui".
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
		nil, -- Can be nil or one of the themes (e.g. themes.Dracula)
		UDim2.fromScale(0.1,0.1) -- Starting position
	)
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
