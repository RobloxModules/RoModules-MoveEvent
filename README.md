<p align="center">
  <h1 align="center"><big>MoveEvent</big></h1>
</p>

**MoveEvent** is a Roblox module that lets you run a function when a part changes position.<br>
Roblox's connections don't run on [certain changes](https://create.roblox.com/docs/reference/engine/classes/Object#GetPropertyChangedSignal) of a BasePart, but this will catch every position change.

**MoveEvent** can easily integrate into your code when you need it to, with only a change needed for event creation.<br>
It also automatically disconnects itself when the part connected is destroyed, so you don't need to.

Example Usage:
```luau
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MoveEvent = require(ReplicatedStorage.MoveEvent)

local part = workspace.Part

local movedEvent
movedEvent = MoveEvent.GetPartMovedSignal(part, function()
  print(part.Name .. " has moved!")
end)

part.Changed:Connect(function(property)
  if property == "Name" then
    movedEvent:Disconnect()
  end
end)
```

Created by [Zalthen](https://www.roblox.com/users/1377987741/profile)
