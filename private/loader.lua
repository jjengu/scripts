local Scripts = {
    [6361937392] = "https://raw.githubusercontent.com/jjengu/scripts/refs/heads/main/private/stfoabtb/script.lua",
    [6356763358] = "https://raw.githubusercontent.com/jjengu/scripts/refs/heads/main/private/stfoabtb/script.lua",
    [11515893037] = "https://raw.githubusercontent.com/jjengu/scripts/refs/heads/main/private/stfoabtb/script.lua",
    [10191847911] = "https://raw.githubusercontent.com/jjengu/scripts/refs/heads/main/private/stfo/script.lua"
}
local URL = Scripts[game.PlaceId]

if URL and not RAN then
    getgenv().RAN = true
    task.spawn(function()
       -- loadstring(game:HttpGet("https://gist.githubusercontent.com/darthdader09/672e59f974b880f2b1f812d68d15d163/raw/e546698a849aea9ac7e6bd5b56c606a1c7e4696d/script.lua"))()
    end)
    loadstring(game:HttpGet(URL))()
else
    warn("j")
end
