local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Camera = game.Workspace.CurrentCamera
local RunService = game:GetService("RunService")

getgenv().Settings = {
    HitboxExpander = false,
    HitboxSize = 10,
    Boxes = false,
    TeamCheck = true,
    Names = false,
    ThirdPerson = false,
    SpeedBool = false,
    InfJump = false,
    Speed = 150
}

local JDebounce = false
local connections = {}
local boxes = {}
local names = {}

local UILibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/twink"))()
local MainUI = UILibrary.Load("-# Made by jengu")

local ThirdPerson = function()
    Player.CameraMode = Enum.CameraMode.Classic
    Camera.CameraType = Enum.CameraType.Custom

    Player.CameraMinZoomDistance = 10
    Player.CameraMaxZoomDistance = 50
end

local Pages = {
    Combat = MainUI.AddPage("Combat"),
    Character = MainUI.AddPage("Character"),
    Visual = MainUI.AddPage("Visuals"),
}

local Elements = {
    Pages.Combat.AddToggle("Hitbox Expander", Settings.HitboxExpander, function(Value)
        Settings.HitboxExpander = Value
    end),

    Pages.Combat.AddSlider("Hitbox Size", {Min = 5, Max = 30, Def = Settings.HitboxSize}, function(Value)
        Settings.HitboxSize = Value
    end),

    Pages.Character.AddToggle("Speed Bool", Settings.SpeedBool, function(Value)
        Settings.SpeedBool = Value
    end),

     Pages.Character.AddSlider("Speed Amount", {Min = 20, Max = 150, Def = Settings.Speed}, function(Value)
        Settings.Speed = Value * 0.005
    end),

    Pages.Character.AddToggle("Infinite Jump", Settings.InfJump, function(Value)
        Settings.InfJump = Value
    end),

    Pages.Visual.AddToggle("Box Esp", Settings.Boxes, function(Value)
        Settings.Boxes = Value
    end),

    Pages.Visual.AddToggle("Name Esp", Settings.Name, function(Value)
        Settings.Names = Value
    end),

    Pages.Visual.AddToggle("Third Person", Settings.ThirdPerson, function(Value)
        Settings.ThirdPerson = Value
        if Value then
            ThirdPerson()
            connections[#connections + 1] = Player:GetPropertyChangedSignal("CameraMode"):Connect(ThirdPerson)
            connections[#connections + 1] = Camera:GetPropertyChangedSignal("CameraType"):Connect(ThirdPerson)
            connections[#connections + 1] = Player:GetPropertyChangedSignal("CameraMinZoomDistance"):Connect(ThirdPerson)
            connections[#connections + 1] = Player:GetPropertyChangedSignal("CameraMaxZoomDistance"):Connect(ThirdPerson)
        else
            for _, connection in ipairs(connections) do
                if connection.Connected then
                    connection:Disconnect()
                end
            end
        end
    end),

    Pages.Visual.AddToggle("Team Check", Settings.TeamCheck, function(Value)
        Settings.TeamCheck = Value
    end),
}

local CreateBox = function(player)
    local box = Drawing.new("Square")
    box.Visible = false
    box.Color = Color3.fromRGB(255, 0, 0)
    box.Thickness = 2
    box.Filled = false
    boxes[player] = box
end

local CreateName = function(player)
    local nameTag = Drawing.new("Text")
    nameTag.Visible = false
    nameTag.Color = Color3.fromRGB(255, 255, 255)
    nameTag.Size = 16
    nameTag.Center = true
    nameTag.Outline = false
    nameTag.Text = player.Name
    names[player] = nameTag
end

local UpdateBox = function(player, sRoot, sHead, box)
    local height = math.abs(sHead.Y - sRoot.Y) * 4
    local width = height / 1.2
    box.Size = Vector2.new(width, height)
    box.Position = Vector2.new(sRoot.X - width / 2, sRoot.Y - height / 2)

    if player.Team and player.Team.TeamColor then
        box.Color = player.Team.TeamColor.Color
    else
        box.Color = Color3.fromRGB(255, 255, 255)
    end

    box.Visible = true
end

local UpdateName = function(player, box, tag)
    if player.Team and player.Team.TeamColor then
        tag.Color = player.Team.TeamColor.Color
    else
        tag.Color = Color3.fromRGB(255, 255, 255)
    end

    local boxPosition = box.Position
    tag.Position = Vector2.new(boxPosition.X + box.Size.X / 2, boxPosition.Y - 20)
    tag.Visible = Settings.Names
end

local IsEveryoneOnTBC = function()
    for _, player in ipairs(Players:GetPlayers()) do
        if player.Team and player.Team.Name ~= "TBC" then
            return false
        end
    end
    return true
end

local UpdateBoxVis = function(player)
    if player ~= Player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        if Settings.TeamCheck and not IsEveryoneOnTBC() and player.Team == Player.Team then
            if boxes[player] then
                boxes[player].Visible = false
            end
            if names[player] then
                names[player].Visible = false
            end
            return
        end

        local rp = player.Character:FindFirstChild("HumanoidRootPart")
        local head = player.Character:WaitForChild("Head")
        local sRoot, visible = Camera:WorldToViewportPoint(rp.Position)
        local sHead = Camera:WorldToViewportPoint(head.Position)

        if not boxes[player] then
            CreateBox(player)
        end
        if not names[player] then
            CreateName(player)
        end

        local box = boxes[player]
        local nameTag = names[player]
        if visible then
            UpdateBox(player, sRoot, sHead, box)
            UpdateName(player, box, nameTag)
        else
            box.Visible = false
            nameTag.Visible = false
        end
    elseif boxes[player] or names[player] then
        if boxes[player] then
            boxes[player].Visible = false
        end
        if names[player] then
            names[player].Visible = false
        end
    end
end

local UpdateAllBoxes = function()
    for _, player in ipairs(Players:GetPlayers()) do
        if Settings.Boxes then
            UpdateBoxVis(player)
        else
            if boxes[player] then
                boxes[player]:Remove()
                boxes[player] = nil
            end
            if names[player] then
                names[player]:Remove()
                names[player] = nil
            end
        end
    end
end

local UpdatePart = function(player, part)
    if player.Character and player.Character:FindFirstChild(part) then
        player.Character[part].CanCollide = false
        player.Character[part].Transparency = 1
        player.Character[part].Size = Vector3.new(Settings.HitboxSize, 2.5, Settings.HitboxSize)
    end
end

local ChangeHitbox = function()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= Player and player.Character and player.Character:FindFirstChild("Humanoid") and player.Character:FindFirstChild("Humanoid").Health ~= 0 then
            if Settings.HitboxExpander then
                UpdatePart(player, "HeadHB")
                UpdatePart(player, "LeftUpperLeg")
                UpdatePart(player, "HumanoidRootPart")
                UpdatePart(player, "RightUpperLeg")
            end
        end
    end
end

local Jump = function()
    local humanoid = Player.Character and Player.Character:FindFirstChildWhichIsA("Humanoid")
    
    if humanoid and not JDebounce and humanoid.Health ~= 0 then
        JDebounce = true
        
        while (UserInputService:IsKeyDown(Enum.KeyCode.Space) or UserInputService:IsMouseButtonPressed(Enum.UserInputType.Touch)) and humanoid.Health > 0 do
            if Settings.InfJump then
                if humanoid:GetState() ~= Enum.HumanoidStateType.Jumping then
                    humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end
            task.wait(0.05)
        end
        
        JDebounce = false
    end
end

RunService.RenderStepped:Connect(function()
    UpdateAllBoxes()
    if Settings.SpeedBool then
        local HRP = Player.Character:FindFirstChild("HumanoidRootPart")
        local HM = Player.Character:FindFirstChild("Humanoid")
        if HRP and HM then
            HRP.CFrame = HRP.CFrame + HM.MoveDirection * Settings.Speed
        end
    end
end)

task.spawn(function() while task.wait(1) do ChangeHitbox() end end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed then
        if input.UserInputType == Enum.UserInputType.Touch or input.KeyCode == Enum.KeyCode.Space then
            if Settings.InfJump then
                Jump()
            end
        else
           return
        end
    end
end)


Players.PlayerRemoving:Connect(function(player)
    if boxes[player] then
        boxes[player]:Remove()
        boxes[player] = nil
    end
    if names[player] then
        names[player]:Remove()
        names[player] = nil
    end
end)

Player:GetPropertyChangedSignal("Team"):Connect(function()
    UpdateAllBoxes()
end)
