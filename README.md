
# imgui-for-roblox
ImGui style Luau UI library for all your quick debugging needs! (unfinished at the moment)


# Documentation
First, create a new ModuleScript instance inside ReplicatedStorage, lets call it "ImGui".
Copy everything from src.lua and put it in there.

This library is very simple at the moment.
Initialize a Window by requiring the module and using the .new function.
```lua
    local library = require(game.ReplicatedStorage.ImGui)
    local window = library.new(
      "My Cool Window!", -- window title
      Vector2.new(200,300), -- window size
      Color3.fromRGB(41, 74,122), -- Title bar color
		  Color3.fromRGB(21, 22, 23), -- Content color
		  UDim2.fromScale(0.1,0.1) -- Starting position
    )
```

## Its Getting Started!

Lets make some UI Elements now that we have the Window!
Currently theres two types of Elements:

 - Button 	
 - Label

Lets make a Button!

```lua
    function myCoolFunction()
	    print("Hello World!")
    end
    
    window.new("Button","Text goes here...", myCoolFunction)
```

At the moment, Buttons are above other UIElements. Will be patched soon.
So that we have a button, Why not add a label?

```lua
    local label = window.new("Label","My Cool Label!")
```

Also why not make the button change the text of that label?
```lua
    local library = require(game.ReplicatedStorage.ImGui)
    local window = library.new(
      "My Cool Window!", -- window title
      Vector2.new(200,300), -- window size
      Color3.fromRGB(41, 74,122), -- Title bar color
      Color3.fromRGB(21, 22, 23), -- Content color
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
