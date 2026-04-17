local allowedUsers = {
    [TU_USER_ID] = true
}

local player = game.Players.LocalPlayer

if not player or not allowedUsers[player.UserId] then
    return warn("Not Authorized")
end

-- Si pasa la validación carga el real
loadstring(game:HttpGet("https://cooprince593.github.io/Script-hub/main.lua"))()
