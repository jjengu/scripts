local Scripts = {
    [6361937392] = "https://raw.githubusercontent.com/jjengu/scripts/refs/heads/main/private/stfobtb/script.lua",
    [6356763358] = "https://raw.githubusercontent.com/jjengu/scripts/refs/heads/main/private/stfobtb/script.lua",
    [11515893037] = "https://raw.githubusercontent.com/jjengu/scripts/refs/heads/main/private/stfobtb/script.lua"
}
local URL = Scripts[game.PlaceId]

if URL then
    loadstring(game:HttpGet(URL))()
end
