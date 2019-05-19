require("engine.sff")
require("engine.base.gamepad")
require("states.splash_screen.main")
gamera = require("engine.base.gamera.gamera")

require("states.game.main")

function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest") -- avoid blurry pixel art
    sff = sff()

    local worldWidth = 2000
    local worldHeight = 2000

    camera = gamera.new(0, 0, worldWidth, worldHeight)
    camera:setScale(CONF.cameraZoom)
    camera:setPosition(-1*(CONF.windowWidth/CONF.cameraZoom),-1*(CONF.windowHeight/CONF.cameraZoom))

    cameraHud = gamera.new(0, 0, worldWidth, worldHeight)
    cameraHud:setScale(CONF.cameraZoom)
    cameraHud:setPosition(0,0)

    if CONF.env == "release" then
        sff.curstate=splash_screen()
    else
        if arg[#arg] == "-debug" then require("mobdebug").start() end -- allow debugging
        io.stdout:setvbuf("no")

        sff.curstate=menu()
        --sff.curstate=game()
    end
end

function love.update(dt)
    sff.curstate:update(dt)
end

function love.draw()
    love.graphics.setColor(1, 1, 1, 1)
    camera:draw(function() sff.curstate:draw() end)
    cameraHud:draw(function() sff.curstate:drawHud() end)
end

