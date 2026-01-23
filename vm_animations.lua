local player = game.Players.LocalPlayer
local offsets = game:HttpGet("https://www.jengu.xyz/api/offsets.txt")
local health = string.match(offsets, "Humanoid::Health%s*=%s*(0x%x+)")
local animation = string.match(offsets, "Misc::AnimationId%s*=%s*(0x%x+)")

local onReset = function()
    if not player or not player.Character or not player.Character:FindFirstChild("Humanoid") then print("not found player") return end
    memory_write("float", player.Character.Humanoid.Address + health, 0)
end

local writeAnim = function(anim, id)
    id = "http://rblx.co/asset/?id=" .. tostring(id)
    local address = anim.Address + animation
    local pointer = memory_read("uintptr_t", address)
    for i = 1, #id do
        memory_write("byte", pointer + i - 1, string.byte(id, i))
    end
    memory_write("byte", pointer + #id, 0)
end

local onNinja = function()
    if not player or not player.Character or not player.Character:FindFirstChild("Humanoid") then print("not found player") return end
    writeAnim(player.Character.Animate.idle.Animation1, 656117400)
    writeAnim(player.Character.Animate.idle.Animation2, 656118341)
    writeAnim(player.Character.Animate.walk.WalkAnim, 656121766)
    writeAnim(player.Character.Animate.run.RunAnim, 656118852)
    writeAnim(player.Character.Animate.jump.JumpAnim, 656117878)
    writeAnim(player.Character.Animate.climb.ClimbAnim, 656114359)
    writeAnim(player.Character.Animate.fall.FallAnim, 656115606)
end

local onLevi = function()
    if not player or not player.Character or not player.Character:FindFirstChild("Humanoid") then print("not found player") return end
    writeAnim(player.Character.Animate.idle.Animation1, 616006778)
    writeAnim(player.Character.Animate.idle.Animation2, 616008087)
    writeAnim(player.Character.Animate.walk.WalkAnim, 616013216)
    writeAnim(player.Character.Animate.run.RunAnim, 616010382)
    writeAnim(player.Character.Animate.jump.JumpAnim, 616008936)
    writeAnim(player.Character.Animate.climb.ClimbAnim, 616003713)
    writeAnim(player.Character.Animate.fall.FallAnim, 616005863)
end

local onWere = function()
    if not player or not player.Character or not player.Character:FindFirstChild("Humanoid") then print("not found player") return end
    writeAnim(player.Character.Animate.idle.Animation1, 1083195517)
    writeAnim(player.Character.Animate.idle.Animation2, 1083214717)
    writeAnim(player.Character.Animate.walk.WalkAnim, 1083178339)
    writeAnim(player.Character.Animate.run.RunAnim, 1083216690)
    writeAnim(player.Character.Animate.jump.JumpAnim, 1083218792)
    writeAnim(player.Character.Animate.climb.ClimbAnim, 1083182000)
    writeAnim(player.Character.Animate.fall.FallAnim, 1083189019)
end

local onStylish = function()
    if not player or not player.Character or not player.Character:FindFirstChild("Humanoid") then print("not found player") return end
    writeAnim(player.Character.Animate.idle.Animation1, 616136790)
    writeAnim(player.Character.Animate.idle.Animation2, 616138447)
    writeAnim(player.Character.Animate.walk.WalkAnim, 616146177)
    writeAnim(player.Character.Animate.run.RunAnim, 616140816)
    writeAnim(player.Character.Animate.jump.JumpAnim, 616139451)
    writeAnim(player.Character.Animate.climb.ClimbAnim, 616133594)
    writeAnim(player.Character.Animate.fall.FallAnim, 616134815)
end

local onRobot = function()
    if not player or not player.Character or not player.Character:FindFirstChild("Humanoid") then print("not found player") return end
    writeAnim(player.Character.Animate.idle.Animation1, 616088211)
    writeAnim(player.Character.Animate.idle.Animation2, 616089559)
    writeAnim(player.Character.Animate.walk.WalkAnim, 616095330)
    writeAnim(player.Character.Animate.run.RunAnim, 616091570)
    writeAnim(player.Character.Animate.jump.JumpAnim, 616090535)
    writeAnim(player.Character.Animate.climb.ClimbAnim, 616086039)
    writeAnim(player.Character.Animate.fall.FallAnim, 616087089)
end

local onBubbly = function()
    if not player or not player.Character or not player.Character:FindFirstChild("Humanoid") then print("not found player") return end
    writeAnim(player.Character.Animate.idle.Animation1, 910004836)
    writeAnim(player.Character.Animate.idle.Animation2, 910009958)
    writeAnim(player.Character.Animate.walk.WalkAnim, 910034870)
    writeAnim(player.Character.Animate.run.RunAnim, 910025107)
    writeAnim(player.Character.Animate.jump.JumpAnim, 910016857)
    writeAnim(player.Character.Animate.fall.FallAnim, 910001910)
    writeAnim(player.Character.Animate.swimidle.SwimIdle, 910030921)
    writeAnim(player.Character.Animate.swim.Swim, 910028158)
end

local onCartoony = function()
    if not player or not player.Character or not player.Character:FindFirstChild("Humanoid") then print("not found player") return end
    writeAnim(player.Character.Animate.idle.Animation1, 742637544)
    writeAnim(player.Character.Animate.idle.Animation2, 742638445)
    writeAnim(player.Character.Animate.walk.WalkAnim, 742640026)
    writeAnim(player.Character.Animate.run.RunAnim, 742638842)
    writeAnim(player.Character.Animate.jump.JumpAnim, 742637942)
    writeAnim(player.Character.Animate.fall.FallAnim, 742637151)
    writeAnim(player.Character.Animate.climb.ClimbAnim, 742636889)
end

local onSuper = function()
    if not player or not player.Character or not player.Character:FindFirstChild("Humanoid") then print("not found player") return end
    writeAnim(player.Character.Animate.idle.Animation1, 616111295)
    writeAnim(player.Character.Animate.idle.Animation2, 616113536)
    writeAnim(player.Character.Animate.walk.WalkAnim, 616122287)
    writeAnim(player.Character.Animate.run.RunAnim, 616117076)
    writeAnim(player.Character.Animate.jump.JumpAnim, 616115533)
    writeAnim(player.Character.Animate.fall.FallAnim, 616108001)
    writeAnim(player.Character.Animate.climb.ClimbAnim, 616104706)
end

local onKnight = function()
    if not player or not player.Character or not player.Character:FindFirstChild("Humanoid") then print("not found player") return end
    writeAnim(player.Character.Animate.idle.Animation1, 657595757)
    writeAnim(player.Character.Animate.idle.Animation2, 657568135)
    writeAnim(player.Character.Animate.walk.WalkAnim, 657552124)
    writeAnim(player.Character.Animate.run.RunAnim, 657564596)
    writeAnim(player.Character.Animate.jump.JumpAnim, 658409194)
    writeAnim(player.Character.Animate.fall.FallAnim, 657600338)
    writeAnim(player.Character.Animate.climb.ClimbAnim, 658360781)
end

local onZombie = function()
    if not player or not player.Character or not player.Character:FindFirstChild("Humanoid") then print("not found player") return end
    writeAnim(player.Character.Animate.idle.Animation1, 616158929)
    writeAnim(player.Character.Animate.idle.Animation2, 616160636)
    writeAnim(player.Character.Animate.walk.WalkAnim, 616168032)
    writeAnim(player.Character.Animate.run.RunAnim, 616163682)
    writeAnim(player.Character.Animate.jump.JumpAnim, 616161997)
    writeAnim(player.Character.Animate.fall.FallAnim, 616157476)
    writeAnim(player.Character.Animate.climb.ClimbAnim, 616156119)
end

local onElder = function()
    if not player or not player.Character or not player.Character:FindFirstChild("Humanoid") then print("not found player") return end
    writeAnim(player.Character.Animate.idle.Animation1, 845397899)
    writeAnim(player.Character.Animate.idle.Animation2, 845400520)
    writeAnim(player.Character.Animate.walk.WalkAnim, 845403856)
    writeAnim(player.Character.Animate.run.RunAnim, 845386501)
    writeAnim(player.Character.Animate.jump.JumpAnim, 845398858)
    writeAnim(player.Character.Animate.fall.FallAnim, 845396048)
    writeAnim(player.Character.Animate.climb.ClimbAnim, 845392038)
end

local onMage = function()
    if not player or not player.Character or not player.Character:FindFirstChild("Humanoid") then print("not found player") return end
    writeAnim(player.Character.Animate.idle.Animation1, 707742142)
    writeAnim(player.Character.Animate.idle.Animation2, 707855907)
    writeAnim(player.Character.Animate.walk.WalkAnim, 707897309)
    writeAnim(player.Character.Animate.run.RunAnim, 707861613)
    writeAnim(player.Character.Animate.jump.JumpAnim, 707853694)
    writeAnim(player.Character.Animate.fall.FallAnim, 707829716)
    writeAnim(player.Character.Animate.climb.ClimbAnim, 707826056)
end


-- Generated by Matcha GUI Builder
local Mouse = game.Players.LocalPlayer:GetMouse()

-- Square1 (Square)
local Square1 = Drawing.new("Square")
Square1.Visible = true
Square1.Transparency = 1
Square1.ZIndex = 10
Square1.Color = Color3.fromHex("#212121")
Square1.Position = Vector2.new(208, 137)
Square1.Size = Vector2.new(384, 326)
Square1.Filled = true

-- Square3 (Square)
local Square3 = Drawing.new("Square")
Square3.Visible = true
Square3.Transparency = 1
Square3.ZIndex = 20
Square3.Color = Color3.fromHex("#323232")
Square3.Position = Vector2.new(208, 137)
Square3.Size = Vector2.new(384, 28)
Square3.Filled = true

-- sdfg (Text)
local sdfg = Drawing.new("Text")
sdfg.Visible = true
sdfg.Transparency = 1
sdfg.ZIndex = 30
sdfg.Color = Color3.fromHex("#FFFFFF")
sdfg.Position = Vector2.new(216, 140)
sdfg.Text = "FE R15 Animation Player"
sdfg.Size = 17
sdfg.Center = false
sdfg.Outline = true
sdfg.Font = Drawing.Fonts.UI

-- Button7 (Button)
local Button7 = Drawing.new("Square")
Button7.Visible = true
Button7.Transparency = 1
Button7.ZIndex = 50
Button7.Color = Color3.fromHex("#C83232")
Button7.Position = Vector2.new(475, 140)
Button7.Size = Vector2.new(60, 20)
Button7.Filled = true

local Button7_Text = Drawing.new("Text")
Button7_Text.Text = "Reset"
Button7_Text.Size = 17
Button7_Text.Center = true
Button7_Text.Outline = false
Button7_Text.Font = 0
Button7_Text.Color = Color3.fromHex("#ffffff")
Button7_Text.Position = Button7.Position + Vector2.new(60/2, 20/2)
Button7_Text.Visible = true
Button7_Text.ZIndex = 52

-- Button9 (Button)
local Button9 = Drawing.new("Square")
Button9.Visible = true
Button9.Transparency = 1
Button9.ZIndex = 60
Button9.Color = Color3.fromHex("#3232C8")
Button9.Position = Vector2.new(540, 140)
Button9.Size = Vector2.new(20, 20)
Button9.Filled = true

local Button9_Text = Drawing.new("Text")
Button9_Text.Text = "-"
Button9_Text.Size = 27
Button9_Text.Center = true
Button9_Text.Outline = false
Button9_Text.Font = 0
Button9_Text.Color = Color3.fromHex("#ffffff")
Button9_Text.Position = Button9.Position + Vector2.new(20/2, 20/2)
Button9_Text.Visible = true
Button9_Text.ZIndex = 62

-- Button10 (Button)
local Button10 = Drawing.new("Square")
Button10.Visible = true
Button10.Transparency = 1
Button10.ZIndex = 70
Button10.Color = Color3.fromHex("#C83232")
Button10.Position = Vector2.new(565, 140)
Button10.Size = Vector2.new(20, 20)
Button10.Filled = true

local Button10_Text = Drawing.new("Text")
Button10_Text.Text = "X"
Button10_Text.Size = 22
Button10_Text.Center = true
Button10_Text.Outline = false
Button10_Text.Font = 0
Button10_Text.Color = Color3.fromHex("#ffffff")
Button10_Text.Position = Button10.Position + Vector2.new(20/2, 20/2)
Button10_Text.Visible = true
Button10_Text.ZIndex = 72

-- Button14 (Button)
local Button14 = Drawing.new("Square")
Button14.Visible = true
Button14.Transparency = 1
Button14.ZIndex = 90
Button14.Color = Color3.fromHex("#3C3C3C")
Button14.Position = Vector2.new(345.5, 174)
Button14.Size = Vector2.new(109, 61)
Button14.Filled = true

local Button14_Text = Drawing.new("Text")
Button14_Text.Text = "Levitation"
Button14_Text.Size = 18
Button14_Text.Center = true
Button14_Text.Outline = false
Button14_Text.Font = 0
Button14_Text.Color = Color3.fromHex("#ffffff")
Button14_Text.Position = Button14.Position + Vector2.new(109/2, 61/2)
Button14_Text.Visible = true
Button14_Text.ZIndex = 92

-- Button15 (Button)
local Button15 = Drawing.new("Square")
Button15.Visible = true
Button15.Transparency = 1
Button15.ZIndex = 90
Button15.Color = Color3.fromHex("#3C3C3C")
Button15.Position = Vector2.new(220, 174)
Button15.Size = Vector2.new(109, 61)
Button15.Filled = true

local Button15_Text = Drawing.new("Text")
Button15_Text.Text = "Ninja"
Button15_Text.Size = 18
Button15_Text.Center = true
Button15_Text.Outline = false
Button15_Text.Font = 0
Button15_Text.Color = Color3.fromHex("#ffffff")
Button15_Text.Position = Button15.Position + Vector2.new(109/2, 61/2)
Button15_Text.Visible = true
Button15_Text.ZIndex = 92

-- Button17 (Button)
local Button17 = Drawing.new("Square")
Button17.Visible = true
Button17.Transparency = 1
Button17.ZIndex = 90
Button17.Color = Color3.fromHex("#3C3C3C")
Button17.Position = Vector2.new(470, 174)
Button17.Size = Vector2.new(109, 61)
Button17.Filled = true

local Button17_Text = Drawing.new("Text")
Button17_Text.Text = "Werewolf"
Button17_Text.Size = 18
Button17_Text.Center = true
Button17_Text.Outline = false
Button17_Text.Font = 0
Button17_Text.Color = Color3.fromHex("#ffffff")
Button17_Text.Position = Button17.Position + Vector2.new(109/2, 61/2)
Button17_Text.Visible = true
Button17_Text.ZIndex = 92

-- Button18 (Button)
local Button18 = Drawing.new("Square")
Button18.Visible = true
Button18.Transparency = 1
Button18.ZIndex = 90
Button18.Color = Color3.fromHex("#3C3C3C")
Button18.Position = Vector2.new(220, 245)
Button18.Size = Vector2.new(109, 61)
Button18.Filled = true

local Button18_Text = Drawing.new("Text")
Button18_Text.Text = "Stylish"
Button18_Text.Size = 18
Button18_Text.Center = true
Button18_Text.Outline = false
Button18_Text.Font = 0
Button18_Text.Color = Color3.fromHex("#ffffff")
Button18_Text.Position = Button18.Position + Vector2.new(109/2, 61/2)
Button18_Text.Visible = true
Button18_Text.ZIndex = 92

-- Button19 (Button)
local Button19 = Drawing.new("Square")
Button19.Visible = true
Button19.Transparency = 1
Button19.ZIndex = 90
Button19.Color = Color3.fromHex("#3C3C3C")
Button19.Position = Vector2.new(220, 315)
Button19.Size = Vector2.new(109, 61)
Button19.Filled = true

local Button19_Text = Drawing.new("Text")
Button19_Text.Text = "Cartoony"
Button19_Text.Size = 18
Button19_Text.Center = true
Button19_Text.Outline = false
Button19_Text.Font = 0
Button19_Text.Color = Color3.fromHex("#ffffff")
Button19_Text.Position = Button19.Position + Vector2.new(109/2, 61/2)
Button19_Text.Visible = true
Button19_Text.ZIndex = 92

-- Button20 (Button)
local Button20 = Drawing.new("Square")
Button20.Visible = true
Button20.Transparency = 1
Button20.ZIndex = 90
Button20.Color = Color3.fromHex("#3C3C3C")
Button20.Position = Vector2.new(220, 385)
Button20.Size = Vector2.new(109, 61)
Button20.Filled = true

local Button20_Text = Drawing.new("Text")
Button20_Text.Text = "Zombie"
Button20_Text.Size = 18
Button20_Text.Center = true
Button20_Text.Outline = false
Button20_Text.Font = 0
Button20_Text.Color = Color3.fromHex("#ffffff")
Button20_Text.Position = Button20.Position + Vector2.new(109/2, 61/2)
Button20_Text.Visible = true
Button20_Text.ZIndex = 92

-- Button21 (Button)
local Button21 = Drawing.new("Square")
Button21.Visible = true
Button21.Transparency = 1
Button21.ZIndex = 90
Button21.Color = Color3.fromHex("#3C3C3C")
Button21.Position = Vector2.new(345.5, 245)
Button21.Size = Vector2.new(109, 61)
Button21.Filled = true

local Button21_Text = Drawing.new("Text")
Button21_Text.Text = "Robot"
Button21_Text.Size = 18
Button21_Text.Center = true
Button21_Text.Outline = false
Button21_Text.Font = 0
Button21_Text.Color = Color3.fromHex("#ffffff")
Button21_Text.Position = Button21.Position + Vector2.new(109/2, 61/2)
Button21_Text.Visible = true
Button21_Text.ZIndex = 92

-- Button22 (Button)
local Button22 = Drawing.new("Square")
Button22.Visible = true
Button22.Transparency = 1
Button22.ZIndex = 90
Button22.Color = Color3.fromHex("#3C3C3C")
Button22.Position = Vector2.new(470, 245)
Button22.Size = Vector2.new(109, 61)
Button22.Filled = true

local Button22_Text = Drawing.new("Text")
Button22_Text.Text = "Bubbly"
Button22_Text.Size = 18
Button22_Text.Center = true
Button22_Text.Outline = false
Button22_Text.Font = 0
Button22_Text.Color = Color3.fromHex("#ffffff")
Button22_Text.Position = Button22.Position + Vector2.new(109/2, 61/2)
Button22_Text.Visible = true
Button22_Text.ZIndex = 92

-- Button23 (Button)
local Button23 = Drawing.new("Square")
Button23.Visible = true
Button23.Transparency = 1
Button23.ZIndex = 90
Button23.Color = Color3.fromHex("#3C3C3C")
Button23.Position = Vector2.new(345.5, 315)
Button23.Size = Vector2.new(109, 61)
Button23.Filled = true

local Button23_Text = Drawing.new("Text")
Button23_Text.Text = "SuperHero"
Button23_Text.Size = 18
Button23_Text.Center = true
Button23_Text.Outline = false
Button23_Text.Font = 0
Button23_Text.Color = Color3.fromHex("#ffffff")
Button23_Text.Position = Button23.Position + Vector2.new(109/2, 61/2)
Button23_Text.Visible = true
Button23_Text.ZIndex = 92

-- Button24 (Button)
local Button24 = Drawing.new("Square")
Button24.Visible = true
Button24.Transparency = 1
Button24.ZIndex = 90
Button24.Color = Color3.fromHex("#3C3C3C")
Button24.Position = Vector2.new(470, 315)
Button24.Size = Vector2.new(109, 61)
Button24.Filled = true

local Button24_Text = Drawing.new("Text")
Button24_Text.Text = "Knight"
Button24_Text.Size = 18
Button24_Text.Center = true
Button24_Text.Outline = false
Button24_Text.Font = 0
Button24_Text.Color = Color3.fromHex("#ffffff")
Button24_Text.Position = Button24.Position + Vector2.new(109/2, 61/2)
Button24_Text.Visible = true
Button24_Text.ZIndex = 92

-- Button25 (Button)
local Button25 = Drawing.new("Square")
Button25.Visible = true
Button25.Transparency = 1
Button25.ZIndex = 90
Button25.Color = Color3.fromHex("#3C3C3C")
Button25.Position = Vector2.new(345.5, 385)
Button25.Size = Vector2.new(109, 61)
Button25.Filled = true

local Button25_Text = Drawing.new("Text")
Button25_Text.Text = "Elder"
Button25_Text.Size = 18
Button25_Text.Center = true
Button25_Text.Outline = false
Button25_Text.Font = 0
Button25_Text.Color = Color3.fromHex("#ffffff")
Button25_Text.Position = Button25.Position + Vector2.new(109/2, 61/2)
Button25_Text.Visible = true
Button25_Text.ZIndex = 92

-- Button26 (Button)
local Button26 = Drawing.new("Square")
Button26.Visible = true
Button26.Transparency = 1
Button26.ZIndex = 90
Button26.Color = Color3.fromHex("#3C3C3C")
Button26.Position = Vector2.new(470, 385)
Button26.Size = Vector2.new(109, 61)
Button26.Filled = true

local Button26_Text = Drawing.new("Text")
Button26_Text.Text = "Mage"
Button26_Text.Size = 18
Button26_Text.Center = true
Button26_Text.Outline = false
Button26_Text.Font = 0
Button26_Text.Color = Color3.fromHex("#ffffff")
Button26_Text.Position = Button26.Position + Vector2.new(109/2, 61/2)
Button26_Text.Visible = true
Button26_Text.ZIndex = 92

local KeyNames = {
    [48] = "0",
    [49] = "1",
    [50] = "2",
    [51] = "3",
    [52] = "4",
    [53] = "5",
    [54] = "6",
    [55] = "7",
    [56] = "8",
    [57] = "9",
    [1] = "LeftMouse",
    [2] = "RightMouse",
    [4] = "MiddleMouse",
    [8] = "Backspace",
    [9] = "Tab",
    [13] = "Enter",
    [16] = "Shift",
    [17] = "Ctrl",
    [18] = "Alt",
    [19] = "Pause",
    [20] = "CapsLock",
    [27] = "Esc",
    [32] = "Space",
    [33] = "PageUp",
    [34] = "PageDown",
    [35] = "End",
    [36] = "Home",
    [37] = "Left",
    [38] = "Up",
    [39] = "Right",
    [40] = "Down",
    [45] = "Insert",
    [46] = "Delete",
    [65] = "A",
    [66] = "B",
    [67] = "C",
    [68] = "D",
    [69] = "E",
    [70] = "F",
    [71] = "G",
    [72] = "H",
    [73] = "I",
    [74] = "J",
    [75] = "K",
    [76] = "L",
    [77] = "M",
    [78] = "N",
    [79] = "O",
    [80] = "P",
    [81] = "Q",
    [82] = "R",
    [83] = "S",
    [84] = "T",
    [85] = "U",
    [86] = "V",
    [87] = "W",
    [88] = "X",
    [89] = "Y",
    [90] = "Z",
    [112] = "F1",
    [113] = "F2",
    [114] = "F3",
    [115] = "F4",
    [116] = "F5",
    [117] = "F6",
    [118] = "F7",
    [119] = "F8",
    [120] = "F9",
    [121] = "F10",
    [122] = "F11",
    [123] = "F12",
}


-- Intelligent Restore Button
local RestoreBtn = Drawing.new("Square")
RestoreBtn.Visible = false
RestoreBtn.Size = Vector2.new(30, 30)
RestoreBtn.Position = Vector2.new(50, 50)
RestoreBtn.Color = Color3.fromHex("#00FF00")
RestoreBtn.Filled = true
local RestoreBtn_Text = Drawing.new("Text")
RestoreBtn_Text.Visible = false
RestoreBtn_Text.Text = "+"
RestoreBtn_Text.Size = 20
RestoreBtn_Text.Center = true
RestoreBtn_Text.Outline = true
RestoreBtn_Text.Color = Color3.fromHex("#FFFFFF")
RestoreBtn_Text.Position = RestoreBtn.Position + Vector2.new(15, 5)
RestoreBtn_Text.ZIndex = RestoreBtn.ZIndex + 1

-- Input Handling
local dragging = nil
local dragStart = nil
local startPos = nil
local knobStartPos = nil
local lastMouse1 = false

while true do
    wait(0.01)
    if isrbxactive() then
        local mouse1 = ismouse1pressed()
        local mPos = Vector2.new(Mouse.X, Mouse.Y)

        -- Mouse Down (Just Pressed)
        if mouse1 and not lastMouse1 then
            if RestoreBtn.Visible and mPos.X >= RestoreBtn.Position.X and mPos.X <= RestoreBtn.Position.X + RestoreBtn.Size.X and
               mPos.Y >= RestoreBtn.Position.Y and mPos.Y <= RestoreBtn.Position.Y + RestoreBtn.Size.Y then
                -- Restore UI
                Square1.Visible = true
                Square3.Visible = true
                sdfg.Visible = true
                Button7.Visible = true
                Button7_Text.Visible = true
                Button9.Visible = true
                Button9_Text.Visible = true
                Button10.Visible = true
                Button10_Text.Visible = true
                Button14.Visible = true
                Button14_Text.Visible = true
                Button15.Visible = true
                Button15_Text.Visible = true
                Button17.Visible = true
                Button17_Text.Visible = true
                Button18.Visible = true
                Button18_Text.Visible = true
                Button19.Visible = true
                Button19_Text.Visible = true
                Button20.Visible = true
                Button20_Text.Visible = true
                Button21.Visible = true
                Button21_Text.Visible = true
                Button22.Visible = true
                Button22_Text.Visible = true
                Button23.Visible = true
                Button23_Text.Visible = true
                Button24.Visible = true
                Button24_Text.Visible = true
                Button25.Visible = true
                Button25_Text.Visible = true
                Button26.Visible = true
                Button26_Text.Visible = true
                RestoreBtn.Visible = false
                RestoreBtn_Text.Visible = false
            end
            -- Button Button7
            if Button7.Visible and mPos.X >= Button7.Position.X and mPos.X <= Button7.Position.X + Button7.Size.X and
               mPos.Y >= Button7.Position.Y and mPos.Y <= Button7.Position.Y + Button7.Size.Y then
                pcall(function() onReset() end)
            end
            -- Button Button9
            if Button9.Visible and mPos.X >= Button9.Position.X and mPos.X <= Button9.Position.X + Button9.Size.X and
               mPos.Y >= Button9.Position.Y and mPos.Y <= Button9.Position.Y + Button9.Size.Y then
                -- Intelligent Minimize
                Square1.Visible = false
                Square3.Visible = false
                sdfg.Visible = false
                Button7.Visible = false
                Button7_Text.Visible = false
                Button9.Visible = false
                Button9_Text.Visible = false
                Button10.Visible = false
                Button10_Text.Visible = false
                Button14.Visible = false
                Button14_Text.Visible = false
                Button15.Visible = false
                Button15_Text.Visible = false
                Button17.Visible = false
                Button17_Text.Visible = false
                Button18.Visible = false
                Button18_Text.Visible = false
                Button19.Visible = false
                Button19_Text.Visible = false
                Button20.Visible = false
                Button20_Text.Visible = false
                Button21.Visible = false
                Button21_Text.Visible = false
                Button22.Visible = false
                Button22_Text.Visible = false
                Button23.Visible = false
                Button23_Text.Visible = false
                Button24.Visible = false
                Button24_Text.Visible = false
                Button25.Visible = false
                Button25_Text.Visible = false
                Button26.Visible = false
                Button26_Text.Visible = false
                RestoreBtn.Visible = true
                RestoreBtn_Text.Visible = true
            end
            -- Button Button10
            if Button10.Visible and mPos.X >= Button10.Position.X and mPos.X <= Button10.Position.X + Button10.Size.X and
               mPos.Y >= Button10.Position.Y and mPos.Y <= Button10.Position.Y + Button10.Size.Y then
                -- Intelligent Close
                Square1:Remove()
                Square3:Remove()
                sdfg:Remove()
                Button7:Remove()
                Button7_Text:Remove()
                Button9:Remove()
                Button9_Text:Remove()
                Button10:Remove()
                Button10_Text:Remove()
                Button14:Remove()
                Button14_Text:Remove()
                Button15:Remove()
                Button15_Text:Remove()
                Button17:Remove()
                Button17_Text:Remove()
                Button18:Remove()
                Button18_Text:Remove()
                Button19:Remove()
                Button19_Text:Remove()
                Button20:Remove()
                Button20_Text:Remove()
                Button21:Remove()
                Button21_Text:Remove()
                Button22:Remove()
                Button22_Text:Remove()
                Button23:Remove()
                Button23_Text:Remove()
                Button24:Remove()
                Button24_Text:Remove()
                Button25:Remove()
                Button25_Text:Remove()
                Button26:Remove()
                Button26_Text:Remove()
                RestoreBtn:Remove()
                RestoreBtn_Text:Remove()
                return -- Stop the script loop
            end
            -- Button Button14
            if Button14.Visible and mPos.X >= Button14.Position.X and mPos.X <= Button14.Position.X + Button14.Size.X and
               mPos.Y >= Button14.Position.Y and mPos.Y <= Button14.Position.Y + Button14.Size.Y then
                pcall(function() onLevi() end)
            end
            -- Button Button15
            if Button15.Visible and mPos.X >= Button15.Position.X and mPos.X <= Button15.Position.X + Button15.Size.X and
               mPos.Y >= Button15.Position.Y and mPos.Y <= Button15.Position.Y + Button15.Size.Y then
                pcall(function() onNinja() end)
            end
            -- Button Button17
            if Button17.Visible and mPos.X >= Button17.Position.X and mPos.X <= Button17.Position.X + Button17.Size.X and
               mPos.Y >= Button17.Position.Y and mPos.Y <= Button17.Position.Y + Button17.Size.Y then
                pcall(function() onWere() end)
            end
            -- Button Button18
            if Button18.Visible and mPos.X >= Button18.Position.X and mPos.X <= Button18.Position.X + Button18.Size.X and
               mPos.Y >= Button18.Position.Y and mPos.Y <= Button18.Position.Y + Button18.Size.Y then
                pcall(function() onStylish() end)
            end
            -- Button Button19
            if Button19.Visible and mPos.X >= Button19.Position.X and mPos.X <= Button19.Position.X + Button19.Size.X and
               mPos.Y >= Button19.Position.Y and mPos.Y <= Button19.Position.Y + Button19.Size.Y then
                pcall(function() onCartoony() end)
            end
            -- Button Button20
            if Button20.Visible and mPos.X >= Button20.Position.X and mPos.X <= Button20.Position.X + Button20.Size.X and
               mPos.Y >= Button20.Position.Y and mPos.Y <= Button20.Position.Y + Button20.Size.Y then
                pcall(function() onZombie() end)
            end
            -- Button Button21
            if Button21.Visible and mPos.X >= Button21.Position.X and mPos.X <= Button21.Position.X + Button21.Size.X and
               mPos.Y >= Button21.Position.Y and mPos.Y <= Button21.Position.Y + Button21.Size.Y then
                pcall(function() onRobot() end)
            end
            -- Button Button22
            if Button22.Visible and mPos.X >= Button22.Position.X and mPos.X <= Button22.Position.X + Button22.Size.X and
               mPos.Y >= Button22.Position.Y and mPos.Y <= Button22.Position.Y + Button22.Size.Y then
                pcall(function() onBubbly() end)
            end
            -- Button Button23
            if Button23.Visible and mPos.X >= Button23.Position.X and mPos.X <= Button23.Position.X + Button23.Size.X and
               mPos.Y >= Button23.Position.Y and mPos.Y <= Button23.Position.Y + Button23.Size.Y then
                pcall(function() onSuper() end)
            end
            -- Button Button24
            if Button24.Visible and mPos.X >= Button24.Position.X and mPos.X <= Button24.Position.X + Button24.Size.X and
               mPos.Y >= Button24.Position.Y and mPos.Y <= Button24.Position.Y + Button24.Size.Y then
                pcall(function() onKnight() end)
            end
            -- Button Button25
            if Button25.Visible and mPos.X >= Button25.Position.X and mPos.X <= Button25.Position.X + Button25.Size.X and
               mPos.Y >= Button25.Position.Y and mPos.Y <= Button25.Position.Y + Button25.Size.Y then
                pcall(function() onElder() end)
            end
            -- Button Button26
            if Button26.Visible and mPos.X >= Button26.Position.X and mPos.X <= Button26.Position.X + Button26.Size.X and
               mPos.Y >= Button26.Position.Y and mPos.Y <= Button26.Position.Y + Button26.Size.Y then
                pcall(function() onMage() end)
            end
        end

        -- Mouse Up (Just Released)
        if not mouse1 and lastMouse1 then
            dragging = nil
        end

        -- Dragging Update
        if dragging and mouse1 then
            local delta = mPos - dragStart
            dragging.Position = startPos + delta
        end

        lastMouse1 = mouse1
    end
end
