

-- Config code --
-- Watermark text options --
watermarkTextOptions = {
    "Craft Roleplay discord.gg/zAmEH4umkU",
}

-- The x and y offset (starting at the top left corner) --
-- Default: 0.005, 0.001
offset = {x = 0.5, y = 0.01} -- Top center

-- Text RGB Color --
-- Default: Black
textColor = {r = 0, g = 0, b = 0} -- Black

-- Text transparency --
-- Default: 255 (fully opaque)
alpha = 255 -- Fully opaque

-- Text scale
-- Default: 0.4
-- NOTE: Number needs to be a float (so instead of 1 do 1.0)
scale = 0.6 -- Increased scale for larger text

-- Text Font --
-- 0 - 5 possible
-- Default: 1
font = 1 -- Change the font to 2 (you can experiment with different fonts)

-- Blinking effect options --
disappearDuration = 500 -- Set the duration to 5000 milliseconds (5 seconds)
isBlinkingEnabled = true -- Enable/disable blinking

-- Don't touch until you are an idiot \\\\
-- I didn't make Config yet coming in new Updates with modified versions xDD --

local lastToggleTime = GetGameTimer() -- Initialize lastToggleTime to the current time
local currentTextIndex = 1 -- Initialize currentTextIndex

Citizen.CreateThread(function()
    while true do
        Wait(1)

        local currentTime = GetGameTimer()

        -- Toggle text visibility when the disappearDuration is reached and blinking is enabled
        if isBlinkingEnabled then
            if currentTime >= lastToggleTime + disappearDuration then
                isTextVisible = not isTextVisible
                lastToggleTime = currentTime
            end
        else
            isTextVisible = true  -- Text remains constantly visible when blinking is disabled
        end

        if isTextVisible then
            local rgb = textColor

            SetTextColour(rgb.r, rgb.g, rgb.b, alpha)

            SetTextFont(font)
            SetTextScale(scale, scale)
            SetTextWrap(0.0, 1.0)
            SetTextCentre(true)

            SetTextEntry("STRING")
            AddTextComponentString(watermarkTextOptions[currentTextIndex])
            DrawText(offset.x, offset.y)
        end

        -- Move this block to the end of the loop
        currentTextIndex = currentTextIndex + 1

        if currentTextIndex > #watermarkTextOptions then
            currentTextIndex = 1
        end
    end
end)

