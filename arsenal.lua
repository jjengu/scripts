local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local RunService = game:GetService("RunService")

getgenv().Settings = {
    HitboxExpander = false,
    HitboxSize = 10,
    Boxes = false,
    TeamCheck = true,
    Names = false
}

local boxes = {}
local names = {}

local UILibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/twink"))()
local MainUI = UILibrary.Load("-# Made by jengu")
local FirstPage = MainUI.AddPage("Main")

local FirstToggle = FirstPage.AddToggle("Hitbox Expander", Settings.HitboxExpander, function(Value)
    Settings.HitboxExpander = Value
end)

local FirstSlider = FirstPage.AddSlider("Hitbox Size", {Min = 5, Max = 30, Def = Settings.HitboxSize}, function(Value)
    Settings.HitboxSize = Value
end)

local SecondToggle = FirstPage.AddToggle("Box Esp", Settings.Boxes, function(Value)
    Settings.Boxes = Value
end)

local ThirdToggle = FirstPage.AddToggle("Name Esp", Settings.Name, function(Value)
    Settings.Names = Value
end)

local FourthToggle = FirstPage.AddToggle("Team Check", Settings.TeamCheck, function(Value)
    Settings.TeamCheck = Value
end)

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
        local sRoot, visible = workspace.CurrentCamera:WorldToViewportPoint(rp.Position)
        local sHead = workspace.CurrentCamera:WorldToViewportPoint(head.Position)

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
        if player ~= Player and player.Character and player.Character:FindFirstChild("Humanoid").Health ~= 0 then
            if Settings.HitboxExpander then
                UpdatePart(player, "HeadHB")
                UpdatePart(player, "LeftUpperLeg")
                UpdatePart(player, "HumanoidRootPart")
                UpdatePart(player, "RightUpperLeg")
            end
        end
    end
end

RunService.RenderStepped:Connect(UpdateAllBoxes)
task.spawn(function()
    while task.wait(1) do
        ChangeHitbox()
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
