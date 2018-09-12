require("states.menu.main")
require("engine.sff.timer")

function splash_screen()
    local s={}
    sff.gamepad.clear()

    local ww = CONF.width
    local hh = CONF.height
    local midY = hh/2
    local midX = ww/2

    s.logo  = love.graphics.newImage("assets/splash/dino_pelado.png")
    s.logoScale = 2

    s.speech = love.audio.newSource("assets/splash/rs.ogg", "static")
    s.splash = love.audio.newSource("assets/splash/splash.ogg", "static")
    s.turettentin = love.audio.newSource("assets/splash/turettentin.ogg", "static")

    s.splash:setVolume(0.5)
    s.turettentin:setVolume(0.3)
    s.turettentin:play()


    local curFont = sff.fonts.pentagram
    love.graphics.setFont(curFont)

    local advance = function()  sff.curstate=menu()  end
    sff.gamepad.enterCallback = advance
    sff.gamepad.aCallback     = advance
    sff.gamepad.bCallback     = advance

    local updateables={}
    timer(updateables, 1, 40, 1, function() s.speech:play() end)
    s.tick = 0

    function s:update(dt)
        self.tick = self.tick + (5*dt)
        for i=1, #updateables do
            updateables[i]:update()
        end
    end

    function s:draw()
        love.graphics.setColor(sff.palette[11])
        love.graphics.rectangle("fill", 0,0,ww,hh)

        love.graphics.setColor(1,1,1,1)
        love.graphics.draw(self.logo, midX-40,  midY-50+(math.sin(self.tick)*2), 0, self.logoScale, self.logoScale)

        love.graphics.setColor(sff.palette[9])
        love.graphics.print("Rombosaur Studios", midX-50, hh-30+(math.cos(self.tick)))

        if self.tick >= 10 then
            self.splash:play()
            sff.curstate = menu()
        end
    end

    return s
end