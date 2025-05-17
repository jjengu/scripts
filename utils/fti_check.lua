local count = 0
if getgenv().firetouchinterest then
    local TestingPart = Instance.new("Part", game.Workspace)
    TestingPart.Anchored = true
    TestingPart.CFrame = CFrame.new(900, 900, 900)
    TestingPart.Name = "TestingPart"

    local Connection
    Connection = TestingPart.Touched:Connect(function(t)
        local player = game.Players:GetPlayerFromCharacter(t.Parent)
        if player == game.Players.LocalPlayer then
            count += 1
        end
    end)

    task.wait()
    local hrp = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
    firetouchinterest(hrp, TestingPart, 0)
    firetouchinterest(hrp, TestingPart, 1)

    task.wait()

    Connection:Disconnect()
    TestingPart:Destroy()

    return count <= 1
else
    return false
end
