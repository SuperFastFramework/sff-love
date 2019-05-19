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
        blink=true, on_time=30, off_time=15
    })

    local mytext = tutils({
        text="This is a long text, for testing various stuff.",
        fg=9, bg=2, sh=3,
        y=50, centerx=true, centery=true,
        bordered=true, shadowed=false,
        font=sff.fonts.teatable, scale=0.7,
        blink=false, on_time=30, off_time=15,
        retro=true, retro_speed=7
    })

    add(texts, title)
    add(texts, enterToStart)
    add(texts, subtitle)
    add(texts, mytext)

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