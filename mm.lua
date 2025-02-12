-- maht murder script i made in like 7 minutes i dont plan on updating or anything
local Question = game.Workspace.Map.Functional.Screen.SurfaceGui.MainFrame.MainGameContainer.MainTxtContainer.QuestionText
local Event = game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("GameEvent")
local CurrentAnswer = "idk yet 🤔"
local AutoSubmit = false

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Math Murder",
   Icon = 0,
   LoadingTitle = "Loading Math Murder Script",
   LoadingSubtitle = "By Jengu",
   Theme = "Default",
   Discord = {
      Enabled = true,
      Invite = "5etqc3KUfM",
      RememberJoins = true
   },
})

local MainTab = Window:CreateTab("Main", 4483362458)
local AnswerSection = MainTab:CreateSection("Current Answer: " .. CurrentAnswer)

local AutoSubmitToggle = MainTab:CreateToggle({
    Name = "Auto Submit Answer",
    CurrentValue = AutoSubmit,
    Flag = "AutoSubmit", 
    Callback = function(v)
        AutoSubmit = v
    end,
})

local Solve = function(expression)
    expression = expression:gsub("x", "*"):gsub("=", "")
    return loadstring("return " .. expression) and loadstring("return " .. expression)() or "Waiting.."
end

Question:GetPropertyChangedSignal("Text"):Connect(function()
    CurrentAnswer = tostring(Solve(Question.Text))
    AnswerSection:Set("Current Answer: " .. CurrentAnswer)

    if AutoSubmit then
        task.wait(1)
        Event:FireServer("submitAnswer", CurrentAnswer)
    end
end)
