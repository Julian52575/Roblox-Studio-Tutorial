local UserInputService = game:GetService("UserInputService")
local player = game:GetService("Players").LocalPlayer

local RemoteEventPlayerPunch : RemoteEvent = game.ReplicatedStorage.RemoteEventPlayerPunch 

local function onInputBegan(input : InputObject, gameProcessedEvent : boolean)
	if gameProcessedEvent then
		return
	end
	
	if input.KeyCode == Enum.KeyCode.E then
		RemoteEventPlayerPunch:FireServer()
	end
end

UserInputService.InputBegan:Connect(onInputBegan)