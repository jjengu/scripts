local Scripts = {
    [6361937392] = "https://raw.githubusercontent.com/jjengu/scripts/refs/heads/main/private/stfoabtb/script.lua",
    [6356763358] = "https://raw.githubusercontent.com/jjengu/scripts/refs/heads/main/private/stfoabtb/script.lua",
    [11515893037] = "https://raw.githubusercontent.com/jjengu/scripts/refs/heads/main/private/stfoabtb/script.lua",
    [10191847911] = "https://raw.githubusercontent.com/jjengu/scripts/refs/heads/main/private/stfo/script.lua"
}
local URL = Scripts[game.PlaceId]

if URL and not RAN then
    getgenv().RAN = true
    loadstring(game:HttpGet(URL))()
else
    warn("🫚")
end
