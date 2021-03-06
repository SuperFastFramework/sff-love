function love.conf(t)
    CONF = {}
    CONF.gameTitle  = "Game Title"
    CONF.subTitle   = "Subtitle"
    CONF.version = 0.1
    CONF.width   = 128
    CONF.height  = 128
    CONF.cameraZoom = 5
    CONF.release = true

    --[[ Proceed with caution below this line ]]--
    CONF.windowWidth  = (CONF.width * CONF.cameraZoom)
    CONF.windowHeight = (CONF.height* CONF.cameraZoom)
    t.title = CONF.gameTitle -- Window title
    t.window.width = CONF.windowWidth
    t.window.height = CONF.windowHeight
    t.window.icon = "assets/ricon16.png"
    t.window.resizable = false
    t.window.fullscreen = false
    t.console = true    -- for logging to stdout
    t.version = "0.10.0"
    if CONF.release then
        CONF.env = "release"
    else
        CONF.env = "development"
    end
end