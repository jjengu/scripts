local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Pstrw/Reuploaded-Librarys/main/Venyx/source.lua"))()
local Notify = loadstring(game:HttpGet("https://raw.githubusercontent.com/jjengu/librarys/refs/heads/main/Notification/stfo_notif/source.lua"))()
local Venyx = Library.new("jenguxd the goat", 5013109572)

local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Player = game:GetService("Players").LocalPlayer
local Camera = workspace.CurrentCamera
local ContextActionService = game:GetService("ContextActionService")

local Enabled = false
local ToolCamera = true
local Speed = 1
local MaxZoom = 25
local Inventory = {}
local SelectedTool = nil

local Keybinds = {
    ["Forward"] = "W",
    ["Backward"] = "S",
    ["Left"] = "A",
    ["Right"] = "D",
    ["Up"] = "R",
    ["Down"] = "T"
}

local Forward, Backward, Left, Right, Down, Up = false, false, false, false, false, false
local Zoom = 10
local MinZoom = 5
local Yaw, Pitch = 0, 15
local Dragging = false
local LastMPos = Vector2.new()

local MovementKeys = {
    Enum.KeyCode.W, Enum.KeyCode.A, Enum.KeyCode.S, Enum.KeyCode.D,
    Enum.KeyCode.Up, Enum.KeyCode.Down, Enum.KeyCode.Left, Enum.KeyCode.Right
}

local Main = Venyx:addPage("Main", 5012544693)
local MainS = Main:addSection("Main")
local Settings = Main:addSection("Settings")
local KeybindSec = Main:addSection("Keybinds")

local BlockMovement = function(_, inputState)
    if inputState == Enum.UserInputState.Begin or inputState == Enum.UserInputState.Change then
        return Enum.ContextActionResult.Sink
    end
    return Enum.ContextActionResult.Pass
end

local BlockAllMovement = function(enable)
    for _, key in ipairs(MovementKeys) do
        local action = "BlockMove_" .. tostring(key)
        if enable then
            ContextActionService:BindAction(action, BlockMovement, false, key)
        else
            ContextActionService:UnbindAction(action)
        end
    end
end

local onInput = function(input, isPressed)
    if input.UserInputType == Enum.UserInputType.Keyboard then
        local keyName = input.KeyCode.Name:upper()
        for action, bindKey in pairs(Keybinds) do
            if keyName == bindKey:upper() then
                if action == "Forward" then Forward = isPressed end
                if action == "Backward" then Backward = isPressed end
                if action == "Left" then Left = isPressed end
                if action == "Right" then Right = isPressed end
                if action == "Up" then Up = isPressed end
                if action == "Down" then Down = isPressed end
            end
        end
    end
end

local UpdateToolList = function()
    Inventory = {}
    for _, tool in ipairs(Player.Backpack:GetChildren()) do
        if tool:IsA("Tool") then
            table.insert(Inventory, tool)
        end
    end
end

local PickRandomTool = function()
    UpdateToolList()
    if #Inventory > 0 then
        return Inventory[math.random(1, #Inventory)]
    end
    Notify({
        Message = "No tools found in your backpack!",
        BackgroundColor = Color3.fromRGB(255, 85, 85),
        TextColor = Color3.fromRGB(255, 255, 255),
        TextFont = Enum.Font.SourceSansBold,
        Duration = 5
    })
    return nil
end

local EquipToolSafely = function(tool)
    local humanoid = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
    if not humanoid or not tool then return end
    pcall(function()
        humanoid:EquipTool(tool)
    end)
end

local OnCharacterAdded = function(character)
    local humanoid = character:WaitForChild("Humanoid")
    humanoid:UnequipTools()
    SelectedTool = nil
end

Player.CharacterAdded:Connect(OnCharacterAdded)
if Player.Character then
    OnCharacterAdded(Player.Character)
end

MainS:addToggle("Tool Fly", false, function(v)
    local humanoid = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end

    if v then
        humanoid:UnequipTools()
        SelectedTool = PickRandomTool()
        if not SelectedTool then
            return
        end
        Enabled = true
        BlockAllMovement(true)
        EquipToolSafely(SelectedTool)
    else
        Enabled = false
        BlockAllMovement(false)
        if SelectedTool then
            for i = 1, 5 do
                task.wait()
                pcall(function() SelectedTool:Activate() end)
            end
        end
    end
end)

MainS:addToggle("Tool POV", ToolCamera, function(v)
    ToolCamera = v
end)

Settings:addSlider("Fly Speed", Speed, 1, 10, function(v)
    Speed = v == 0 and 0 or v * 0.2
end)

Settings:addSlider("Max Zoom", MaxZoom, 5, 50, function(v)
    MaxZoom = v
end)

KeybindSec:addKeybind("Up Key", Enum.KeyCode.R, function() end, function(input)
    local kc = nil
    if typeof(input) == "Instance" and input.KeyCode then
        kc = input.KeyCode
    elseif typeof(input) == "EnumItem" then
        kc = input
    else
        return
    end
    Keybinds["Up"] = kc.Name
end)

KeybindSec:addKeybind("Down Key", Enum.KeyCode.T, function() end, function(input)
    local kc = nil
    if typeof(input) == "Instance" and input.KeyCode then
        kc = input.KeyCode
    elseif typeof(input) == "EnumItem" then
        kc = input
    else
        return
    end
    Keybinds["Down"] = kc.Name
end)

MainS:addButton("Infinite Yield", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
end)

Venyx:SelectPage(Venyx.pages[1], true)

UIS.InputBegan:Connect(function(i) onInput(i, true) end)
UIS.InputEnded:Connect(function(i) onInput(i, false) end)

UIS.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseWheel then
        Zoom = math.clamp(Zoom - input.Position.Z, MinZoom, MaxZoom)
    end
end)

UIS.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        Dragging = true
        LastMPos = UIS:GetMouseLocation()
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        Dragging = false
    end
end)

RunService.RenderStepped:Connect(function()
    if not Enabled or not ToolCamera or not SelectedTool then
        Camera.CameraType = Enum.CameraType.Custom
        return
    end

    Camera.CameraType = Enum.CameraType.Scriptable
    local hrp = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local Handle = SelectedTool and SelectedTool:FindFirstChild("Handle")
    if Handle then
        if Dragging then
            local MDelta = UIS:GetMouseLocation() - LastMPos
            Yaw = Yaw - MDelta.X * 0.3
            Pitch = math.clamp(Pitch - MDelta.Y * 0.3, -80, 80)
            LastMPos = UIS:GetMouseLocation()
        end

        local Center = Handle.Position
        local Rotation = CFrame.Angles(0, math.rad(Yaw), 0) * CFrame.Angles(math.rad(Pitch), 0, 0)
        local Offset = Rotation:VectorToWorldSpace(Vector3.new(0, 0, Zoom))
        Camera.CFrame = CFrame.new(Center + Offset, Center)
    end
end)

RunService.Heartbeat:Connect(function()
    if not Enabled or not SelectedTool then
        local hrp = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            Player.DevEnableMouseLock = true
        end
        return
    end

    local hrp = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    hrp.CFrame = CFrame.new(hrp.Position, hrp.Position + Vector3.new(0, 0, 1))
    Player.DevEnableMouseLock = false

    local camCFrame = Camera.CFrame
    local FVector = Vector3.new(camCFrame.LookVector.X, 0, camCFrame.LookVector.Z).Unit
    local RVector = Vector3.new(camCFrame.RightVector.X, 0, camCFrame.RightVector.Z).Unit
    local MVector = Vector3.new(0, 0, 0)

    if Forward then MVector = MVector + FVector end
    if Backward then MVector = MVector - FVector end
    if Right then MVector = MVector + RVector end
    if Left then MVector = MVector - RVector end

    if MVector.Magnitude > 0 then
        MVector = MVector.Unit * Speed
    end

    if SelectedTool then
        SelectedTool.Grip = SelectedTool.Grip * CFrame.new(MVector)

        if Up then
            SelectedTool.Grip = SelectedTool.Grip * CFrame.new(0, -0.5 * Speed, 0)
        end
        if Down then
            SelectedTool.Grip = SelectedTool.Grip * CFrame.new(0, 0.5 * Speed, 0)
        end
    end
end)

while task.wait(.03) do
    if Enabled then
        local humanoid = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
        if not humanoid then return end
        humanoid:UnequipTools()
        if SelectedTool then
            humanoid:EquipTool(SelectedTool)
        end
    end
end
