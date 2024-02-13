Config = {}

-- Debug Options
Config.Debug = false
function Debug(...)
    if Config.Debug then
        print(...)
    end
end

-- Cinematic Settings
Config.MaxDistance = 35.0 -- Max Distance Player Can Move Away from their Ped
Config.EnableEasing = true -- Default = true
Config.EnableDuration = 1000 -- Default = 1000