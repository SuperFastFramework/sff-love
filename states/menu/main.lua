require("states.game.main")

function menu()
    local s={}
    sff.gamepad.clear()

    local middleBkg={}
    middleBkg.margin = 20
    middleBkg.width  = CONF.width-(middleBkg.margin*2)
    middleBkg.height = CONF.height+5
    middleBkg.roundedCorners = 3
    middleBkg.y1 = CONF.height
    middleBkg.y2 = CONF.height+0.5

    local titleColor = sff.palette[9]
    local textAlpha = {}
    textAlpha.a = 1-- 0
    titleColor[4] = textAlpha.a

    local tick = 0
    local swing = 0
    local gamepadImg = love.graphics.newImage("assets/gamepad.png")
    love.graphics.setFont(sff.fonts.teatable)

    sff.gamepad.enterCallback = function()
        -- switch state
        sff.curstate = game()
    end

    function s:update(dt)
        swing = math.sin(tick)*1
        tick = tick+0.1
        titleColor[4] = textAlpha.a
    end

    function s:draw()
        love.graphics.setColor(sff.palette[11])
        love.graphics.rectangle("fill", 0, 0, CONF.width, CONF.height)

        -- title
        love.graphics.setColor(titleColor)
        love.graphics.printf(CONF.gameTitle, 0, 5, CONF.width, "center")

        -- gamepad img
        love.graphics.draw(gamepadImg, (CONF.width/2)+swing-49, CONF.height-25)

        -- subtitle
        local scale=0.7
        local w = CONF.width/scale
        love.graphics.scale(scale)
        love.graphics.printf(CONF.subTitle, 0, 25/scale, w, "center")

        -- press to start
        love.graphics.printf("Press enter to start", 0, 80/scale, w, "center")

        love.graphics.scale(1)
    end

    function s:drawHud()
    end

    return s
end