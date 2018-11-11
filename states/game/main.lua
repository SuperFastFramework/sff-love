require("engine.sff.collision")
require("states.game.entities.hero")
require("states.game.entities.mage")
require("states.game.entities.dialogBox")

function game()
    local s = {}
    local ents = {}
    sff.gamepad.clear()
    love.graphics.setFont(sff.fonts.teatable)

    local h = hero(60, 60, ents)
    local m = mage(80, 60, ents)
    local dialogBox = dialogBox(ents)
    dialogBox:setText("All this time I've been misguided...\nAlgol gato pardo")

    local paused = false
    sff.gamepad.enterCallback = function() paused = not paused end
    -- sff.gamepad.aCallback     =
    -- sff.gamepad.bCallback     =

    function s:update(dt)
        if not paused then
            for i = 1, #ents do
                ents[i]:update()
            end
        end

        if collides(h, m) then
            print("collides")
        end
    end


    function s:draw()
        love.graphics.setColor(sff.palette[16])
        love.graphics.rectangle("fill", 0, 0, CONF.width, CONF.height)
        love.graphics.setColor(sff.palette[9])

        if not paused then
            for i = 1, #ents do
                ents[i]:draw()
            end
        else
            love.graphics.printf("PAUSE", 0, 0, CONF.width, "center")
        end
    end

    return s
end