require("engine.sff.collision")
require("engine.sff.explosions")

function game()
    local s = {}
    local ents = {}
    local hud = {}
    --local explosions = explosions(ents)
    sff.gamepad.clear()

    local paused = false
    local pausedMsg = tutils({
        text="Paused",
        y=50, centerx=true,
        fg=7, bg=2, sh=3,
        bordered=true, shadowed=true,
        font=sff.fonts.teatable, scale=1,
    })

    sff.gamepad.enterCallback = function() paused = not paused end
    -- sff.gamepad.aCallback     =
    -- sff.gamepad.bCallback     =

    function s:update(dt)
        if not paused then
            for i = 1, #ents do
                ents[i]:update(dt)
            end
        end
    end


    function s:draw()
        love.graphics.setColor(sff.palette[16])
        love.graphics.rectangle("fill", 0, 0, CONF.width, CONF.height)
        love.graphics.setColor(sff.palette[9])

        for i = 1, #ents do
            ents[i]:draw()
        end
    end

    function s:drawHud()
        for i = 1, #hud do
            hud[i]:draw()
        end

        love.graphics.printf("No game code yet...",0,0,CONF.width, "center")

        if paused then
            pausedMsg:draw()
        end
    end

    return s
end