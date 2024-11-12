local Request = request or http_request or (http and http.request) or syn and syn.request
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Boards = game.Workspace.Boards
local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()

local hour = tonumber(os.date("%H", os.time()))
if hour >= 0 and hour < 12 then
	greeting = "Good morning"
elseif hour >= 12 and hour < 18 then
	greeting = "Good afternoon"
else
	greeting = "Good evening"
end

local Lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Pstrw/Reuploaded-Librarys/main/Venyx/source.lua"))()
local Win = Lib.new(greeting .. ", " .. Player.Name, 5013109572)

local Tabs = {
	Combat = Win:addPage("Combat", 7485051715),
	Character = Win:addPage("Character", 13285102351),
	Visuals = Win:addPage("Visuals", 13321848320--[[6851126250]]),
	Credits = Win:addPage("Credits", 118847726887896)
}

local Sections = {
	Reach = Tabs.Combat:addSection("Reach"),
	ReachO = Tabs.Combat:addSection("Others"),
	Character = Tabs.Character:addSection("Speed"),
	CharacterO = Tabs.Character:addSection("Others"),
	Visuals = Tabs.Visuals:addSection("Visuals"),
	VisualsG = Tabs.Visuals:addSection("GUI"),
	Credits = Tabs.Credits:addSection(" ")
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

local Whitelist = function(PlayerName, All)
	local Player = FindPlr(PlayerName)
	if Player then
		if not table.find(getgenv().Whitelist, Player.Name) then
			table.insert(getgenv().Whitelist, Player.Name)
		end
		if not All then
			Notify('Whitelist', Player.Name .. " has been added to the whitelist.")
		end
	else
		Notify('Whitelist', "Player not found.")
	end
end

local Blacklist = function(PlayerName, All)
	local Player = FindPlr(PlayerName)
	if Player then
		local Index = table.find(getgenv().Whitelist, Player.Name)
		if Index then
			table.remove(getgenv().Whitelist, Index)
		end
		if not All then
			Notify('Blacklist', Player.Name .. " has been removed from the whitelist.")
		end
	else
		Notify('Blacklist', "Player not found.")
	end
end

local WhitelistAll = function()
	for _, Player in ipairs(Players:GetPlayers()) do
		Whitelist(Player.Name, true)
	end
	Notify('Whitelist', "Whitelisted all players.")
end

local BlacklistAll = function()
	for _, Player in ipairs(Players:GetPlayers()) do
		Blacklist(Player.Name, true)
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

Sections.Credits:addButton("Made by Jengu", function() 
	-- im pro
end)

Sections.Credits:addButton("VFly from IY", function() 
	warn("https://infyiff.github.io/")
	if Request then
		local success, result = pcall(function()
			return Request({
				Url = 'http://127.0.0.1:6463/rpc?v=1',
				Method = 'POST',
				Headers = {
					['Content-Type'] = 'application/json',
					Origin = 'https://discord.com'
				},
				Body = HttpService:JSONEncode({
					cmd = 'INVITE_BROWSER',
					nonce = HttpService:GenerateGUID(false),
					args = { code = "78ZuWSq" }
				})
			})
		end)
	end
end)

Sections.Credits:addButton("Venyx UI Library", function() 
	setclipboard("made by dino")
	warn("made by dino")
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
