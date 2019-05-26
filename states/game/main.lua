require("engine.sff.collision")
require("states.game.entities.hero")
require("states.game.entities.car")
require("states.game.entities.mage")
require("states.game.entities.dialogBox")
require("engine.sff.explosions")

function game()
    local s = {}
    local ents = {}
    local hud = {}
    sff.gamepad.clear()
    love.graphics.setFont(sff.fonts.teatable)

    --local h = car(60,60,ents)
    local h = hero(60,60, ents)
    local m = mage(80, 60, ents)
    local dialogBox = dialogBox(hud)
    dialogBox:setText("Test text hello one two...\nhouse cat mother")

    local paused = false
    sff.gamepad.enterCallback = function() paused = not paused end
    -- sff.gamepad.aCallback     =
    -- sff.gamepad.bCallback     =

    local explosions = explosions(ents)
    explosions:multiexplode(20,20)

    function s:update(dt)
        if not paused then
            for i = 1, #ents do
                ents[i]:update(dt)
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

        -- TODO: sort by Y value
        for i = 1, #ents do
            ents[i]:draw()
        end
    end

    function s:drawHud()
        for i = 1, #hud do
            hud[i]:draw()
        end

        if paused then
            love.graphics.push()
            love.graphics.setFont(sff.fonts.teatable)
            love.graphics.setColor(sff.palette[8])
            love.graphics.scale(5)
            love.graphics.printf("PAUSE", 0, 0, CONF.width, "center")
            love.graphics.pop()
        end
    end

    return s
end