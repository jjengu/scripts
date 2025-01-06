getgenv().Settings = {
    Aimlock = false,
    AimKey = Enum.UserInputType.MouseButton2,
    FOVBool = true,
    FOV = 120,
    AimPart = "HumanoidRootPart",
    AimParts = {"Head"},
    Prediction = true,
}

local UILibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/jjengu/Reuploaded-Librarys/refs/heads/main/twnk_src.lua"))()
local MainUI = UILibrary.Load("-# Made by jengu")

local Pages = {
    Combat = MainUI.AddPage("Combat")
}

local Elements = {
    Pages.Combat.AddToggle("Aimlock", Settings.Aimlock, function(v)
        Settings.Aimlock = v
    end),

    Pages.Combat.AddSlider("FOV Range", {Min = 20, Max = 500, Default = Settings.FOV}, function(v)
        Settings.FOV = v
    end),

    Pages.Combat.AddToggle("FOV Circle", Settings.FOVBool, function(v)
        Settings.FOVBool = v
    end),

    Pages.Combat.AddDropdown("Aim Part", {Settings.AimPart, unpack(Settings.AimParts)}, function(v)
        Settings.AimPart = v
    end),

    Pages.Combat.AddToggle("Prediction", Settings.Prediction, function(v)
        Settings.Prediction = v
    end),
}

local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local FOVC = Drawing.new("Circle")
FOVC.Color = Color3.fromRGB(128, 0, 128)
FOVC.Thickness = 2
FOVC.Filled = false
FOVC.Transparency = 1

local LockedPlayer = nil

local GetClosest = function()
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

local LockCamera = function(player)
    if player and player.Character and player.Character:FindFirstChild(Settings.AimPart) then
        local part = player.Character[Settings.AimPart]
        local TPos = part.Position

        if Settings.Prediction then
            local humanoid = player.Character:FindFirstChild("Humanoid")
            if humanoid then
                local MoveDir = humanoid.MoveDirection
                if MoveDir.Magnitude > 0 then
                    TPos = TPos + (MoveDir * 2)
                end
            end
        end

        local CPos = Camera.CFrame.Position
        local NewCamCFrame = CFrame.new(CPos, TPos)

        Camera.CFrame = NewCamCFrame
    end
end

local UpdateCamera = function()
    local MLoc = UserInputService:GetMouseLocation()
    FOVC.Position = Vector2.new(MLoc.X, MLoc.Y)
    FOVC.Radius = Settings.FOV

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
