local Freecam = exports['fivem-freecam']
local lastPosition = nil
local controlsShown = false

-- Functions
local function showControls()
    lib.hideTextUI()

    local textShow = {
        'Cinematic Cam Active  \n',
        'Move Around: [WASD]  \n',
        'Up & Down: [Q] & [E]  \n',
        'Slow Mode: [Left Alt]  \n',
        'Show / Hide Controls: [F6]  \n',
        'Exit Cinematic Cam: [F5]'
    }

    lib.showTextUI(table.concat(textShow), {
        position = "top-center",
        icon = 'fas fa-camera-retro',
        style = {
            borderRadius = 10,
            backgroundColor = '#212121',
            color = 'white'
        }
    })
end

local function hideControls()
    lib.hideTextUI()
    controlsShown = false
end

-- Threads
CreateThread(function()
    while true do
        if Freecam:IsActive() then
            local camPosition = Freecam:GetPosition()
            local distanceAway = #(lastPosition - camPosition)
            Debug('Distance Away from Ped: ', distanceAway)

            if distanceAway >= Config.MaxDistance then
                Freecam:SetActive(false)
                lib.notify({
                    title = 'Cinematic Cam',
                    description = 'You went too far from your ped! Disabling Cam.',
                    type = 'warning'
                })
                hideControls()
            end

            if IsDisabledControlJustPressed(0, 166) then
                Freecam:SetActive(false)
                lib.notify({
                    title = 'Cinematic Cam',
                    description = 'Cam Disabled!',
                    type = 'warning'
                })
                hideControls()
            end
            Wait(10)
        else
            Wait(250)
        end
    end
end)

CreateThread(function()
    while true do
        if Freecam:IsActive() and IsDisabledControlJustPressed(0, 167) then
            controlsShown = not controlsShown
            if controlsShown then
                showControls()
            else
                hideControls()
            end
        end
        Wait(10)
    end
end)

-- Events
RegisterNetEvent('complex-cinematic:startCinematic', function()
    local isFreeCamActive = Freecam:IsActive()
    if isFreeCamActive then
        lib.notify({
            title = 'Cinematic Cam',
            description = 'Cam Disabled!',
            type = 'warning'
        })
        Freecam:SetActive(false)
        hideControls()
        return
    end

    lastPosition = GetEntityCoords(cache.ped)

    Freecam:SetActive(true)
    Freecam:SetCameraSetting('ENABLE_EASING', Config.EnableEasing)
    Freecam:SetCameraSetting('EASING_DURATION', Config.EnableDuration)

    Freecam:SetKeyboardSetting('LOOK_SENSITIVITY_X', 5)
    Freecam:SetKeyboardSetting('LOOK_SENSITIVITY_Y', 5)
    Freecam:SetKeyboardSetting('BASE_MOVE_MULTIPLIER', 0.5)

    if not controlsShown then
        showControls()
        controlsShown = true
    end
end)
