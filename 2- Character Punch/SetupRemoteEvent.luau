--- [[ GAME OBJECTS ]]
local remoteEventPunch : RemoteEvent = game.ReplicatedStorage.RemoteEventPlayerPunch
--- [[ VARIABLE ]]
local punchDamage : number = 90


--[[**
	Makes the player punch
	@param [player : Player] The player that will do a punching action
**--]]
local function playerPunch(player : Player)
	print("PlayerPunch")
	-- Get the player's character
	local playerCharacter : Model = player.Character	
	-- Save the main part of the player's character for easier use	
	--		Using `player.Character.PrimaryPart` works too
	local playerCharacterPrimaryPart : Part = playerCharacter.PrimaryPart
	
	--- [[ OWNERSHIP 1 ]]
	-- Set ownership of the character to the server 
	--		to play animation on the server
	--		which will then automatically be replicated to all clients.
	-- 		It also allows update the player's position on the server (try disabling it and move quickly to see the difference)
	--		SetNetworkOwner() means server
	playerCharacterPrimaryPart:SetNetworkOwner()
	

	--- [[ HITBOX ]]
	-- We create a new object to let Roblox do the Hitbox detection
	local hitbox : Part = Instance.new("Part")
	
	-- Configure the part. These configuration can be seen in the `Properties` window during gameplay
	hitbox.Name = "PlayerPunch" .. tostring(player.UserId) .. tostring(tick())
	hitbox.Size = Vector3.new(3, 3, 3)
	hitbox.Material = Enum.Material.ForceField
	hitbox.CanCollide = false
	hitbox.Anchored = true
	hitbox.Color = Color3.fromRGB(255, 0, 0)
	-- We will use the player's position and look direction to place the hitbox in front of the player
	hitbox.Position = player.Character.PrimaryPart.Position + (player.Character:GetPivot().LookVector * 3)
	hitbox.Parent = playerCharacter
	
	--- [[ HITBOX DETECTION ]]
	-- This RBXScriptConnection connects to a Roblox game event (collision in this case)
	--		We can use this connection to do something when the hitbox touches something
	-- 		We store it in a variable so it can be accessed inside the OnHitboxTouched function
	local hitboxTouchConnection : RBXScriptConnection = nil
	-- This function will be ran when the hitbox touches something
	local function OnHitboxTouched(hit : BasePart)
		print("Hitbox touched", hit)
		-- To know which character has touched the hitbox,
		--		we need to look at the parent of the hit object
		local parent = hit.Parent
		
		-- If there is no parent, the object was destroyed and should be ignored
		if not parent then
			return
		end
		-- If the parent is not a Model, we should ignore it
		if not parent:IsA("Model") then
			return
		end
		-- We don't want to harm the player itself
		if parent == playerCharacter then
			return
		end
		-- All characters are Model but not all Model are character,
		--		A character must have a Humanoid inside its Model
		--		We need to use this humanoid
		local humanoid : Humanoid = parent:FindFirstChildOfClass("Humanoid")
		
		if not humanoid then
			return
		end
		-- Now that we have a humanoid, we can damage it using Roblox's built-in system
		print("Punch damaging", humanoid:GetFullName())
		humanoid:TakeDamage(punchDamage)
		-- We don't need to keep the collision connexion anymore so we disconnect it to avoid multi hit on a single character
		hitboxTouchConnection:Disconnect()
		-- We no longer need the hitbox
		hitbox:Destroy()
	end
	-- Connect this function to Roblox's hitbox collision
	hitboxTouchConnection = hitbox.Touched:Connect(OnHitboxTouched)
	
	--- [[ HITBOX REMOVAL ]]
	-- We schedule a deletion in case the hitbox does not get destroyed by a collision
	--		The function will run in half a second
	task.delay(0.5, function()
		hitbox:Destroy()
	end)
	
	--- [[ ANIMATION ]]
	-- This one is a bit difficult to understand so don't worry about it _for now_
	-- Create, loads and plays the punching animation
	local animation : Animation = Instance.new("Animation")
	
	-- Set the roblox's animation id. It is stored online and will be downloaded at use
	animation.AnimationId = "rbxassetid://84139210256098"
	playerCharacter:FindFirstChildOfClass("Humanoid"):LoadAnimation(animation):Play()
	-- We don't need the animation now that it is loaded and played
	animation:Destroy()
	
	--- [[ OWNERSHIP 2 ]]
	-- Give back ownership to the player to allow player inputs again
	playerCharacterPrimaryPart:SetNetworkOwner(player)
	
	return
end

remoteEventPunch.OnServerEvent:Connect(playerPunch)