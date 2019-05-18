require("states.game.main")
require("engine.sff.tutils")

function menu()
    local s={}
    sff.gamepad.clear()

    local tick = 0
    local swing = 0
    local gamepadImg = love.graphics.newImage("assets/gamepad.png")
    local texts={}

    local title = tutils({
        text=CONF.gameTitle, y=5,
        fg=9, bg=2, sh=3,
        bordered=true, shadowed=true, centerx=true,
        font=sff.fonts.teatable
    })

    local subtitle = tutils({
        text=CONF.subTitle,
        fg=9, bg=2, sh=3, y=20,
        bordered=false, shadowed=true,
        font=sff.fonts.teatable, centerx=true, scale=0.8,
        blink=false
    })

    local enterToStart = tutils({
        text="Press enter to start",
        fg=9, bg=2, sh=3, y=80,
        bordered=false, shadowed=false,
        font=sff.fonts.teatable, centerx=true, scale=0.7,
        blink=true, on_time=20, off_time=6
    })

    add(texts, title)
    add(texts, enterToStart)
    add(texts, subtitle)

    sff.gamepad.enterCallback = function()
        -- switch state
        sff.curstate = game()
    end

    function s:update(dt)
        swing = math.sin(tick)*1
        tick = tick+0.1
    end

    function s:draw()
        love.graphics.setColor(sff.palette[11])
        love.graphics.rectangle("fill", 0, 0, CONF.width, CONF.height)

        -- gamepad img
        love.graphics.setColor(sff.palette[9])
        love.graphics.draw(gamepadImg, (CONF.width/2)+swing-49, CONF.height-25)

        for i = 1, #texts do
            texts[i]:draw()
        end
    end

    function s:drawHud()
    end

    return s
end