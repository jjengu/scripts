local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Pstrw/Reuploaded-Librarys/main/Venyx/source.lua"))()
local Venyx = Library.new("Tool Fly   |   _jengu#0", 5013109572)

local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Player = game:GetService("Players").LocalPlayer
local Camera = workspace.CurrentCamera
local ContextActionService = game:GetService("ContextActionService")

Player.Character:WaitForChild("Humanoid"):UnequipTools()

local Enabled = false
local ToolCamera = true
local Speed = 1
local Inventory = {}
local DisplayNames = {}
local SelectedTool = nil
local ToolName = nil

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
local MinZoom, MaxZoom = 5, 25
local Yaw, Pitch = 0, 15
local Dragging = false
local LastMPos = Vector2.new()

local dropdown

local MovementKeys = {
    Enum.KeyCode.W,
    Enum.KeyCode.A,
    Enum.KeyCode.S,
    Enum.KeyCode.D,
    Enum.KeyCode.Up,
    Enum.KeyCode.Down,
    Enum.KeyCode.Left,
    Enum.KeyCode.Right
}

local Main = Venyx:addPage("Main", 5012544693)
local ToolSection = Main:addSection("Tool Selection")
local MainS = Main:addSection("Main")

local BlockMovement = function(actionName, inputState, inputObject)
    if inputState == Enum.UserInputState.Begin or inputState == Enum.UserInputState.Change then
        return Enum.ContextActionResult.Sink
    end
    return Enum.ContextActionResult.Pass
end

local BlockAllMovement = function(enable)
    if enable then
        for _, key in ipairs(MovementKeys) do
            ContextActionService:BindAction("BlockMove_" .. tostring(key), BlockMovement, false, key)
        end
    else
        for _, key in ipairs(MovementKeys) do
            ContextActionService:UnbindAction("BlockMove_" .. tostring(key))
        end
    end
end

local onInput = function(input, isPressed)
    if input.UserInputType == Enum.UserInputType.Keyboard then
        local keyName = input.KeyCode.Name
        for action, bind in pairs(Keybinds) do
            if keyName == bind:upper() then
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
    DisplayNames = {}
    local Tools = Player.Backpack:GetChildren()
    for _, tool in ipairs(Tools) do
        if tool:IsA("Tool") then
            table.insert(Inventory, { Name = tool.Name, Instance = tool })
            table.insert(DisplayNames, tool.Name)
        end
    end
end

local PickRandomTool = function()
    UpdateToolList()
    if #Inventory > 0 then
        local randIndex = math.random(1, #Inventory)
        local toolData = Inventory[randIndex]
        ToolName = toolData.Name
        return toolData.Instance
    end
    return nil
end

local RebuildDropdown = function()
    if dropdown then
		pcall(function()
        	ToolSection:removeDropdown(dropdown)
		end)
    end
    dropdown = ToolSection:addDropdown("Tool Selection", DisplayNames, function(s)
        for _, item in ipairs(Inventory) do
            if item.Name == s then
                if Enabled then
                    for i = 1, 5 do
                        task.wait()
                        if SelectedTool then SelectedTool:Activate() end
                    end
                    task.wait()
                    local humanoid = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
                    if not humanoid then return end
                    humanoid:UnequipTools()
                    SelectedTool = item.Instance
                    humanoid:EquipTool(SelectedTool)
                else
                    SelectedTool = item.Instance
                end
                ToolName = s
                break
            end
        end
    end)
end

local OnCharacterAdded = function(character)
    local humanoid = character:WaitForChild("Humanoid")
    humanoid:UnequipTools()

    SelectedTool = PickRandomTool()
    if SelectedTool then
        humanoid:EquipTool(SelectedTool)
    end

    RebuildDropdown()
end

Player.CharacterAdded:Connect(OnCharacterAdded)
if Player.Character then
    OnCharacterAdded(Player.Character)
end


MainS:addToggle("Tool Fly", Enabled, function(v)
    Enabled = v
    BlockAllMovement(v)
    local humanoid = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end

    if v then
        if SelectedTool and SelectedTool.Parent ~= Player.Backpack then
            SelectedTool.Parent = Player.Backpack
        end
        if SelectedTool then
            humanoid:EquipTool(SelectedTool)
        end
    else
        if SelectedTool then
            for i = 1, 5 do
                task.wait()
                SelectedTool:Activate()
            end
        end
    end
end)

MainS:addToggle("Tool POV", ToolCamera, function(v)
    ToolCamera = v
end)

MainS:addButton("Infinite Yield", function(v)
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
    if not Enabled or not ToolCamera then
        Camera.CameraType = Enum.CameraType.Custom
        return
    end

    Camera.CameraType = Enum.CameraType.Scriptable
    local hrp = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local Handle = SelectedTool and SelectedTool.Handle
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
    if not Enabled then
        local hrp = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        Player.DevEnableMouseLock = true
        return
    end

    local hrp = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    hrp.CFrame = CFrame.new(hrp.Position, hrp.Position + Vector3.new(0, 0, 1))
    Player.DevEnableMouseLock = false

    local camCFrame = Camera.CFrame
    local FVector = Vector3.new(camCFrame.LookVector.X, 0, camCFrame.LookVector.Z)
    if FVector.Magnitude == 0 then return end
    FVector = FVector.Unit

    local RVector = Vector3.new(camCFrame.RightVector.X, 0, camCFrame.RightVector.Z)
    if RVector.Magnitude == 0 then return end
    RVector = RVector.Unit

    local MVector = Vector3.new(0, 0, 0)

    if Forward then
        MVector = MVector + FVector
    end
    if Backward then
        MVector = MVector - FVector
    end
    if Right then
        MVector = MVector + RVector
    end
    if Left then
        MVector = MVector - RVector
    end

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
