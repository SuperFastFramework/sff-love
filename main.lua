require("engine.sff")
require("engine.base.gamepad")
require("states.splash_screen.main")
gamera = require("engine.base.gamera.gamera")

require("states.game.main")

function love.load()
    --if arg[#arg] == "-debug" then require("mobdebug").start() end     -- allow debugging
    love.graphics.setDefaultFilter("nearest", "nearest") -- avoid blurry pixel art
    sff = sff()

    camera = gamera.new(0, 0, 2000, 2000) -- set world dimensions
    camera:setScale(CONF.cameraZoom)
    camera:setPosition(-1*(CONF.windowWidth/CONF.cameraZoom),-1*(CONF.windowHeight/CONF.cameraZoom))

    --sff.curstate=splash_screen()
    sff.curstate=game()
end

function love.update(dt)
    sff.curstate:update(dt)
end

function love.draw(dt)
    love.graphics.setColor(1, 1, 1, 1)
    camera:draw(function() sff.curstate:draw(dt) end)
end

