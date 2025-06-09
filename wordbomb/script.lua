local WordList = loadstring(game:HttpGet("https://raw.githubusercontent.com/jjengu/scripts/refs/heads/main/wordbomb/words.lua"))()
local WordList_Two = loadstring(game:HttpGet("https://raw.githubusercontent.com/jjengu/scripts/refs/heads/main/wordbomb/words_two.lua"))()
local IsOnMobile = table.find({Enum.Platform.IOS, Enum.Platform.Android}, game:GetService("UserInputService"):GetPlatform())

local Player = game:GetService("Players").LocalPlayer
local Games = game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Games")

local GameID = "-1"
local UsedWords = {}
local Typing = false
local TypingActive = false
local CStatus = "Waiting For Next Round.."
local LastWord = ""
local TypeBox

local Settings = {
    WordList = true,
    AutoType = false,
    LetterTypeDelay = 0.1,
    WordTypeDelay = 0.5,
    AutoJoin = false
}

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Pstrw/Reuploaded-Librarys/main/Venyx/source.lua"))()
local Venyx = Library.new("jengu.lol   I   word bomb", 5013109572)

local Tabs = {Main = Venyx:addPage("Main", 5012544693)}
local Sections = {Status_Section = Tabs.Main:addSection("Status"), Cheat_Section = Tabs.Main:addSection("Cheats")}

local UpdateStatus = function(ns)
    Sections.Status_Section:updateButton(CStatus, ns)
    CStatus = ns
end

local CheckInput = function(value)
    if type(tonumber(value)) == "number" then
        return true
    else
        return false
    end
end

local GetTurn = function()
    for _, v in pairs(getgc()) do
        if type(v) == "function" and debug.getinfo(v).name == "updateInfoFrame" then
            for __, vv in ipairs(debug.getupvalues(v)) do
                if type(vv) == "table" and vv.PlayerID ~= nil then
                    return vv.PlayerID
                end
            end
        end
    end
end

local GetLetters = function()
    for _, v in pairs(getgc()) do
        if type(v) == "function" and debug.getinfo(v).name == "updateInfoFrame" then
            for __, vv in pairs(debug.getupvalues(v)) do
                if type(vv) == "table" and vv.Prompt ~= nil then
                    return vv.Prompt
                end
            end
        end
    end
    return ""
end

local FindWord = function(l)
    if not l or l == "" then
        return nil
    end
    UpdateStatus("Searching For Word Containing: " .. string.upper(l))
    local lowerL = string.lower(l)
    local WordListToUse = Settings.WordList and WordList or WordList_Two 
    for _, v in pairs(WordListToUse) do
        if v ~= nil then
            local lowerV = string.lower(v)
            if string.find(lowerV, lowerL) and not table.find(UsedWords, v) and v ~= LastWord then
                table.insert(UsedWords, v)
                UpdateStatus("Found usable word: " .. string.upper(v))
                return string.upper(v)
            end
        end
    end
    UpdateStatus("No Valid Word Found.")
    return nil
end

local TypeWord = function(word)
    if Typing then return end

    Typing = true
    UpdateStatus("Typing Word: " .. string.upper(word))

    for i = 1, #word do
        Games.GameEvent:FireServer(GameID, "TypingEvent", string.upper(string.sub(word, 1, i)), false)
        task.wait(Settings.LetterTypeDelay)
    end

    task.wait()

    Games.GameEvent:FireServer(GameID, "TypingEvent", string.upper(word), true)

    UpdateStatus("Finished Typing: " .. string.upper(word))
    Typing = false
end

local TryTyping = function()
    if not Settings.AutoType then
        TypingActive = false
        return
    end

    if TypingActive then
        return
    end

    TypingActive = true

    while GetTurn() ~= Player.UserId do
        if not Settings.AutoType then
            TypingActive = false
            return
        end
        task.wait(0.5)
    end

    if not Settings.AutoType then
        TypingActive = false
        return
    end

    local Word, attempts = nil, 0
    repeat
        task.wait()
        Word = FindWord(GetLetters())
        attempts = attempts + 1
        if not Settings.AutoType then
            TypingActive = false
            return
        end
    until Word or attempts >= 5

    if Word then
        LastWord = Word
        task.wait(Settings.WordTypeDelay)
        if not Typing then
            TypeWord(Word)
        end
        task.wait(Settings.WordTypeDelay)

        if GetTurn() == Player.UserId and Settings.AutoType then
            UpdateStatus("Turn is still mine, retrying...")
            LastWord = ""
            TypingActive = false 
            TryTyping()
        end
    end

    TypingActive = false
end

Sections.Status_Section:addButton(CStatus, function()
    return
end)

Sections.Cheat_Section:addToggle("Auto Join Round", false, function(value)
    Settings.AutoJoin = value
    UpdateStatus("Auto Join " .. (value and "Enabled" or "Disabled"))
    if value then
        for i = -1, -1000, -1 do
            Games.GameEvent:FireServer(i, "JoinGame")
        end 
    end
end)

Sections.Cheat_Section:addToggle("Auto Type Word", false, function(value)
    Settings.AutoType = value
    UpdateStatus("Auto Type " .. (value and "Enabled" or "Disabled"))
    
    if not value then
        TypingActive = false
    end
    
    if value then
        TryTyping()
    end
end)

Sections.Cheat_Section:addDropdown("WordList", {"WordList: One", "WordList: Two"}, function(text)
    if text == "WordList: One" then
        Settings.WordList = true
    else
	    Settings.WordList = false
    end
end)

Sections.Cheat_Section:addTextbox("Letter Type Delay", "Number", function(value)
    if CheckInput(value) then
        Settings.LetterTypeDelay = value
        UpdateStatus("Updated LetterTypeDelay To: " .. Settings.LetterTypeDelay)
    else
        UpdateStatus("Input a number value.")
    end
end)

Sections.Cheat_Section:addTextbox("Word Type Delay", "Number", function(value)
    if CheckInput(value) then
        Settings.WordTypeDelay = value
        UpdateStatus("Updated WordTypeDelay To: " .. Settings.WordTypeDelay)
    else
        UpdateStatus("Input a number value.")
    end
end)

Sections.Cheat_Section:addButton("Type Word", function()
    if GameID == "-1" then
        UpdateStatus("Please wait until a round starts or has occurred to use this.")
        return
    end
    while GetTurn() ~= Player.UserId do
        task.wait(0.5)
    end
    local Word, attempts = nil, 0
    repeat
        task.wait()
        Word = FindWord(GetLetters())
        attempts = attempts + 1
    until Word or attempts >= 5
    
    if Word then
        LastWord = Word 
        task.wait(Settings.WordTypeDelay)
        if not Typing then
            TypeWord(Word)
        end
        task.wait(Settings.WordTypeDelay)
        UpdateStatus("Finished typing word: " .. string.upper(Word))
        if GetTurn() == Player.UserId then
            TryTyping()
        end
    end
end)

Sections.Cheat_Section:addButton("Blurt Word", function()
    if GameID == "-1" then
        UpdateStatus("Please wait until a round starts or has occurred to use this.")
        return
    end
    local WordToBlurt = FindWord(GetLetters())
    game:GetService("ReplicatedStorage").Network.Chat.SendMessage:FireServer(GameID, WordToBlurt)
    UpdateStatus("Blurted: " .. WordToBlurt .. " (Only Others See Chat Message)")
end)

Venyx:SelectPage(Venyx.pages[1], true)

Games:WaitForChild("RegisterGame").OnClientEvent:Connect(function(int)
    GameID = int
    UsedWords = {}
    LastWord = ""
    UpdateStatus("Game Registered With ID: " .. int)
    if Settings.AutoJoin then
        Games.GameEvent:FireServer(int, "JoinGame")
    end
    task.wait(1)
    if Settings.AutoType then
        TryTyping()
    end
end)

Player.PlayerGui.GameUI.DescendantAdded:Connect(function(c)
    if c.Name == "Typebox" then
        if not IsOnMobile then
            TypeBox = Player.PlayerGui.GameUI.Container.GameSpace.DefaultUI.GameContainer.DesktopContainer.Typebar.Typebox
        else
            TypeBox = Player.PlayerGui.GameUI.Container.GameSpace.DefaultUI.GameContainer.Typebar.Typebox
        end
        TypeBox:GetPropertyChangedSignal("Visible"):Connect(function(v)
            if Settings.AutoType then
                TryTyping()
            end
        end)
    end
end)
