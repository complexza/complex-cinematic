-- Commands
lib.addCommand('cinecam', {
    help = 'Start Cinematic Cam'
}, function(source, raw)
    TriggerClientEvent("complex-cinematic:startCinematic", source)
end)

local function sendLog(state, playerName)
    local textActive = 'Started'
    if not state then
        textActive = 'Stopped'
    end
    if Config.LogSystem == 'ox' then
        lib.logger(src, 'Cinematic Cam', playerName..' '..textActive..' Using Cinematic Cam')
    elseif Config.LogSystem == 'custom' then
        -- Custom Log System Here
    end
end

RegisterNetEvent('complex-cinematic:sendLog', function(state)
    local src = source
    local playerName = GetPlayerName(src)
    sendLog(state, playerName)
end)