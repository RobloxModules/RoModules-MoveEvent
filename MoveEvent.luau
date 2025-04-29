local RunService = game:GetService("RunService")

local mod = {}

function mod.GetPartMovedSignal(part: BasePart, callback: () -> any)
	assert(typeof(part) == "Instance" and part:IsA("BasePart"), "Argument 1 must be a BasePart")
	assert(typeof(callback) == "function", "Argument 2 must be a function")
	
	local self = {}
	self.EventConnections = {}
	self._BindableEvent = Instance.new("BindableEvent")
	
	self.Disconnect = mod.Disconnect
	
	local prevPosition = part.Position
	self.EventConnections[1] = RunService.PreSimulation:Connect(function(deltaTime)
		if part.Position ~= prevPosition then
			self._BindableEvent:Fire()
		end
		
		prevPosition = part.Position
	end)
	
	self.EventConnections[2] = self._BindableEvent.Event:Connect(function()
		callback()
	end)
	
	self.EventConnections[3] = part.Destroying:Connect(function()
		self:Disconnect()
	end)
	
	return self
end

function mod:Disconnect()
	for i, connection in pairs(self.EventConnections) do
		connection:Disconnect()
		self.EventConnections[i] = nil
	end
	
	self = nil
end

return mod
