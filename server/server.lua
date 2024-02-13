-- Commands
lib.addCommand('cinecam', {
    help = 'Start Cinematic Cam'
}, function(source, raw)
    TriggerClientEvent("complex-cinematic:startCinematic", source)
end)