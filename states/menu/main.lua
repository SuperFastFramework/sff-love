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

    -- flux.to(middleBkg, 0.4, {y1 = 7, y2 = 8})
    -- :oncomplete(
    --     function()
    --         flux.to(textAlpha, 1, {a=1})
    --     end
    -- )

    sff.gamepad.enterCallback = function()
        -- flux.to(textAlpha, 0.3, {a=0})
        -- flux.to(middleBkg, 0.3, {y1 = 200, y2 = 200})
        -- :delay(0.3)
        -- :oncomplete(
        --     function()
        --
        --         -- switch state
                 sff.curstate = game()
        --     end
        -- )
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
        love.graphics.print(CONF.gameTitle, (CONF.width/2)-30, 15)

        -- press to start
        love.graphics.print("Press enter to start", (CONF.width/2)-50, 80)

        -- gamepad img
        love.graphics.draw(gamepadImg, (CONF.width/2)+swing-49, CONF.height-25)
    end

    return s
end