--[[ 
    4 directional buttons (arrows)
    2 action buttons A and B (A = a||z,  B = s||x)
    Start = enter key
]]--
function love.keypressed( key )
    if key == "return" then
        sff.gamepad.enter = true
        sff.gamepad.enterCallback()
    end

    -- A button
    if key == "a" or key == "z" then
        sff.gamepad.a = true
        sff.gamepad.aCallback()
    end

    -- B button
    if key == "s" or key == "x" then
        sff.gamepad.b = true
        sff.gamepad.bCallback()
    end


    if key == "up" then
        sff.gamepad.up = true
    end

    if key == "down" then
        sff.gamepad.down = true
    end

    if key == "left" then
        sff.gamepad.left = true
    end

    if key == "right" then
        sff.gamepad.right = true
    end
end

function love.keyreleased( key )
    if key == "return" then
        sff.gamepad.enter = false
    end

    -- A button
    if key == "a" or key == "z" then
        sff.gamepad.a = false
    end

    -- B button
    if key == "s" or key == "x" then
        sff.gamepad.b = false
    end


    if key == "up" then
        sff.gamepad.up = false
    end

    if key == "down" then
        sff.gamepad.down = false
    end

    if key == "left" then
        sff.gamepad.left = false
    end

    if key == "right" then
        sff.gamepad.right = false
    end
end
