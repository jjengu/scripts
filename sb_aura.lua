getgenv().Settings = {
    Aura = true,
    Cooldown = 0.2,
    Distance = 15,
    Connections = {}
}

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local RunService = game:GetService("RunService")
local SlapEvent = game:GetService("ReplicatedStorage"):WaitForChild("b")


RunService.Stepped:Connect(function()
    local Character = Player.Character
    if Settings.Aura and Character and Character:FindFirstChild("HumanoidRootPart") then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= Player and player.Character and player.Character:FindFirstChild("Head") and player.Character:FindFirstChild("HumanoidRootPart") then
                local distance = (Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
                local Reversed = player.Character:FindFirstChild("Reversed")
                local Mirage = player.Character:FindFirstChild("Mirage")
                local Ragdolled = player.Character:FindFirstChild("Ragdolled")
                
                if not (Reversed and Reversed.Value) and not (Mirage and Mirage.Value) and not (Ragdolled and Ragdolled.Value) then
                    if distance <= Settings.Distance then
                        if not Settings.Connections[player.Name] or tick() - Settings.Connections[player.Name] > Settings.Cooldown then
                            SlapEvent:FireServer(player.Character.Head)
                            Settings.Connections[player.Name] = tick()
                        end
                    end
                end
            end
        end
    end
end)

local function createGui(parent) local ScreenGui1,Frame2,TextLabel3,TextLabel4,UIPadding5,TextLabel6,UIPadding7,Script8=Instance.new("ScreenGui",parent),Instance.new("Frame"),Instance.new("TextLabel"),Instance.new("TextLabel"),Instance.new("UIPadding"),Instance.new("TextLabel"),Instance.new("UIPadding"),Instance.new("Script") ScreenGui1.Name,ScreenGui1.ZIndexBehavior="1938636",Enum.ZIndexBehavior.Sibling Frame2.Parent,Frame2.AnchorPoint,Frame2.Size,Frame2.BackgroundTransparency,Frame2.Position,Frame2.BorderColor3,Frame2.Name,Frame2.BorderSizePixel,Frame2.BackgroundColor3=ScreenGui1,Vector2.new(0,1),UDim2.new(1,0,0.0299748722,0),0.5,UDim2.new(0,0,0.99999994,0),Color3.new(0,0,0),"4647537",0,Color3.new(0,0,0) TextLabel3.Parent,TextLabel3.TextWrapped,TextLabel3.TextColor3,TextLabel3.BorderColor3,TextLabel3.Text,TextLabel3.Font,TextLabel3.BackgroundTransparency,TextLabel3.TextSize,TextLabel3.Size,TextLabel3.Name,TextLabel3.BorderSizePixel,TextLabel3.BackgroundColor3=Frame2,true,Color3.new(1,1,1),Color3.new(0,0,0),"Made with ❤️ by jengu",Enum.Font.SourceSans,1,17,UDim2.new(1,0,1,0),"352646",0,Color3.new(1,1,1) TextLabel4.Parent,TextLabel4.TextWrapped,TextLabel4.TextColor3,TextLabel4.BorderColor3,TextLabel4.Text,TextLabel4.TextSize,TextLabel4.Font,TextLabel4.BackgroundTransparency,TextLabel4.TextXAlignment,TextLabel4.Size,TextLabel4.Name,TextLabel4.BorderSizePixel,TextLabel4.BackgroundColor3=Frame2,true,Color3.new(1,1,1),Color3.new(0,0,0),"11:16 PM",17,Enum.Font.SourceSans,1,Enum.TextXAlignment.Left,UDim2.new(1,0,1,0),"57453735",0,Color3.new(1,1,1) UIPadding5.Parent,UIPadding5.Name,UIPadding5.PaddingLeft=TextLabel4,"32524",UDim.new(0,6) TextLabel6.Parent,TextLabel6.RichText,TextLabel6.TextColor3,TextLabel6.BorderColor3,TextLabel6.Text,TextLabel6.TextSize,TextLabel6.TextWrapped,TextLabel6.Font,TextLabel6.BackgroundTransparency,TextLabel6.TextXAlignment,TextLabel6.Name,TextLabel6.Size,TextLabel6.BorderSizePixel,TextLabel6.BackgroundColor3=Frame2,true,Color3.new(1,1,1),Color3.new(0,0,0),"@Jengu  I  67 Players",17,true,Enum.Font.SourceSans,1,Enum.TextXAlignment.Right,"90205",UDim2.new(1,0,1,0),0,Color3.new(1,1,1) UIPadding7.Parent,UIPadding7.Name,UIPadding7.PaddingRight=TextLabel6,"2145600",UDim.new(0,6) Script8.Parent,Script8.Name=Frame2,"7774811" spawn(function() local script,aa,aaa,aaaa=Script8,Script8.Parent["57453735"],Script8.Parent["90205"],game.Players.LocalPlayer.Name local bb=function() aaa.Text=aaaa==game.Players.LocalPlayer.DisplayName and "@"..game.Players.LocalPlayer.Name.."  I  "..#game.Players:GetPlayers().." Players" or game.Players.LocalPlayer.DisplayName.." (@"..game.Players.LocalPlayer.Name..")  I  "..#game.Players:GetPlayers().." Players" end local bbb=function() while true do local d,h,a=os.date("*t",os.time()),d.hour%12==0 and 12 or d.hour%12,d.hour>=12 and "PM" or "AM" aa.Text=string.format("%02d:%02d %s",h,d.min,a) task.wait(60-d.sec) end end bb() task.spawn(bbb) game.Players.PlayerAdded:Connect(bb) game.Players.PlayerRemoving:Connect(bb) end) end createGui(game.CoreGui)
