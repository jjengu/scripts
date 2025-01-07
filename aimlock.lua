getgenv().Settings = {
    Aimlock = false,
    AimKey = Enum.UserInputType.MouseButton2,
    Boxes = false,
    Names = false,
    FOVBool = true,
    FOV = 120,
    Color = Color3.fromRGB(128, 0, 200),
    AimPart = "HumanoidRootPart",
    AimParts = {"Head"},
    Prediction = true,
    PredictionFactor = 1.5
}

local UILibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/jjengu/Reuploaded-Librarys/refs/heads/main/twnk_src.lua"))()
local MainUI = UILibrary.Load("-# Made by jengu")

local boxes = {}
local names = {}

local Pages = {
    Combat = MainUI.AddPage("Combat"),
    Visuals = MainUI.AddPage("Visuals")
}

local Elements = {
    Pages.Combat.AddToggle("Aimlock", Settings.Aimlock, function(v)
        Settings.Aimlock = v
    end),

    Pages.Combat.AddDropdown("Aim Part", {Settings.AimPart, unpack(Settings.AimParts)}, function(v)
        Settings.AimPart = v
    end),

    Pages.Combat.AddToggle("Prediction", Settings.Prediction, function(v)
        Settings.Prediction = v
    end),

    Pages.Combat.AddSlider("Prediction Factor", {Min = 1, Max = 5, Default = Settings.PredictionFactor}, function(v)
        Settings.PredictionFactor = v
    end),

    Pages.Visuals.AddToggle("Box ESP", Settings.Boxes, function(v)
        Settings.Boxes = v
    end),

    Pages.Visuals.AddToggle("Name ESP", Settings.Names, function(v)
        Settings.Names = v
    end),

    Pages.Visuals.AddSlider("FOV Range", {Min = 20, Max = 500, Default = Settings.FOV}, function(v)
        Settings.FOV = v
    end),

    Pages.Visuals.AddToggle("FOV Circle", Settings.FOVBool, function(v)
        Settings.FOVBool = v
    end),

    Pages.Visuals.AddColourPicker("Color Theme", Settings.Color, function(v)
        Settings.Color = v
    end)
}

local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local FOVC = Drawing.new("Circle")
FOVC.Color = Settings.Color
FOVC.Thickness = 2
FOVC.Filled = false
FOVC.Transparency = 1

local LockedPlayer = nil

local function CreateBox(player)
    local box = Drawing.new("Square")
    box.Visible = false
    box.Color = Settings.Color
    box.Thickness = 2
    box.Filled = false
    boxes[player] = box
end

local function CreateName(player)
    local nameTag = Drawing.new("Text")
    nameTag.Visible = false
    nameTag.Color = Settings.Color
    nameTag.Size = 16
    nameTag.Center = true
    nameTag.Outline = false
    nameTag.Text = player.Name
    names[player] = nameTag
end

local function RemoveESP(player)
    if boxes[player] then
        boxes[player]:Remove()
        boxes[player] = nil
    end
    if names[player] then
        names[player]:Remove()
        names[player] = nil
    end
end

local function UpdateBox(player, sRoot, sHead, box)
    local height = math.abs(sHead.Y - sRoot.Y) * 4
    local width = height / 1.2
    box.Size = Vector2.new(width, height)
    box.Position = Vector2.new(sRoot.X - width / 2, sRoot.Y - height / 2)

    box.Color = Settings.Color
    box.Visible = true
end

local function UpdateName(player, box, tag)
    tag.Color = Settings.Color

    local boxPosition = box.Position
    tag.Position = Vector2.new(boxPosition.X + box.Size.X / 2, boxPosition.Y - 20)
    tag.Visible = Settings.Names
end

local function UpdateBoxVis(player)
    if player ~= Player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") then
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
    else
        RemoveESP(player)
    end
end

local function UpdateBoxes()
    for _, player in ipairs(Players:GetPlayers()) do
        if Settings.Boxes then
            UpdateBoxVis(player)
        else
            RemoveESP(player)
        end
    end
end

local function GetClosest()
    local MLoc = UserInputService:GetMouseLocation()
    local CPlayer = nil
    local sDistance = Settings.FOV

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= Player and player.Character and player.Character:FindFirstChild(Settings.AimPart) then
            local character = player.Character
            local part = character:FindFirstChild(Settings.AimPart)

            if part then
                local partPos, onScreen = Camera:WorldToViewportPoint(part.Position)
                if onScreen then
                    local CDistance = (Vector2.new(partPos.X, partPos.Y) - MLoc).Magnitude

                    if CDistance < Settings.FOV and CDistance < sDistance then
                        CPlayer = player
                        sDistance = CDistance
                    end
                end
            end
        end
    end

    return CPlayer
end

local function LockCamera(player)
    if player and player.Character and player.Character:FindFirstChild(Settings.AimPart) then
        local part = player.Character[Settings.AimPart]
        local TPos = part.Position

        if Settings.Prediction then
            local humanoid = player.Character:FindFirstChild("Humanoid")
            if humanoid then
                local MoveDir = humanoid.MoveDirection
                if MoveDir.Magnitude > 0 then
                    TPos = TPos + (MoveDir * Settings.PredictionFactor)
                end
            end
        end

        local CPos = Camera.CFrame.Position
        local NewCamCFrame = CFrame.new(CPos, TPos)

        Camera.CFrame = NewCamCFrame
    end
end

local function UpdateCamera()
    local MLoc = UserInputService:GetMouseLocation()
    FOVC.Position = Vector2.new(MLoc.X, MLoc.Y)
    FOVC.Radius = Settings.FOV
    FOVC.Color = Settings.Color
    FOVC.Visible = Settings.FOVBool

    if Settings.Aimlock and UserInputService:IsMouseButtonPressed(Settings.AimKey) then
        if not LockedPlayer then
            LockedPlayer = GetClosest()
        end

        if LockedPlayer and LockedPlayer.Character:FindFirstChild("Humanoid").Health ~= 0 then
            LockCamera(LockedPlayer)
        end
    else
        LockedPlayer = nil
    end
end

RunService.RenderStepped:Connect(UpdateCamera)
RunService.RenderStepped:Connect(UpdateBoxes)
Players.PlayerRemoving:Connect(RemoveESP)
