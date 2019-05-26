require("engine.base.helpers")

function sff()
    local sff = {}
    sff.G = {} -- Globals
    sff.fonts = {}
    sff.palettes = {}
    sff.sprite = {}
    sff.graphics = {}
    sff.gamepad = {}
  
    sff.directions={}
    sff.directions.UP=0
    sff.directions.DOWN=1
    sff.directions.LEFT=2
    sff.directions.RIGHT=3

    -- ******** --
    -- Palettes --
    -- ******** --
    sff.palettes.arne16 = {
        {0/255,   0/255,   0/255,  1},
        {73/255,  60/255,  43/255,  1},
        {190/255, 38/255,  51/255,  1},
        {224/255, 111/255, 139/255, 1},
        {157/255, 157/255, 157/255, 1},
        {164/255, 100/255, 34/255,  1},
        {235/255, 137/255, 49/255,  1},
        {247/255, 226/255, 107/255, 1},
        {255/255, 255/255, 255/255, 1},
        {27/255,  38/255,  50/255,  1},
        {47/255,  72/255,  78/255,  1},
        {68/255,  137/255, 26/255,  1},
        {163/255, 206/255, 39/255,  1},
        {0/255,   87/255,  132/255, 1},
        {49/255,  162/255, 242/255, 1},
        {178/255, 220/255, 239/255, 1}
    }

    sff.palettes.pico8 = {
        {0/255 , 0/255, 0/255, 1},
        {95/255, 87/255, 80/255, 1},
        {130/255, 117/255, 154/255, 1},
        {192/255, 193/255, 197/255, 1},
        {255/255, 240/255, 231/255, 1},
        {125/255, 41/255, 83/255, 1},
        {255/255, 7/255, 78/255, 1},
        {255/255, 118/255, 166/255, 1},
        {169/255, 82/255, 56/255, 1},
        {255/255, 161/255, 8/255, 1},
        {254/255, 235/255, 44/255, 1},
        {255/255, 202/255, 168/255, 1},
        {0/255, 133/255, 81/255, 1},
        {0/255, 227/255, 57/255, 1},
        {34/255, 46/255, 83/255, 1},
        {44/255, 171/255, 254/255, 1}
    }

    -- ***** --
    -- Fonts --
    -- ***** --
    sff.fonts.pico8     = love.graphics.newFont("engine/fonts/pico8.ttf",     4)
    sff.fonts.pentagram = love.graphics.newFont("engine/fonts/Pentagram.ttf", 16)
    sff.fonts.quiver    = love.graphics.newFont("engine/fonts/Quiver.ttf",    16)
    sff.fonts.teatable  = love.graphics.newFont("engine/fonts/Teatable.ttf",  16)
    sff.fonts.trollmini = love.graphics.newFont("engine/fonts/Trollmini.ttf", 16)
    sff.fonts.pressStart2p = love.graphics.newFont("engine/fonts/PressStart2P.ttf", 16)


    -- ******* --
    -- Sprites --
    -- ******* --
    sff.sprite.sheet  = love.graphics.newImage('assets/sheet.png') -- all sprites must be here
    sff.sprite.sheetW = 256
    sff.sprite.sheetH = 256
    sff.sprite.pxUnit = 8           -- 8 pixels is the minimum unit

    -- Returns a Quad containing the sprite area
    sff.sprite.getQuad = function(idx, w, h) -- w and h in blocks (i.e. value multiplied by s.pxUnit)
        local u = sff.sprite.pxUnit
        local cols = sff.sprite.sheetW / u -- Number of columns in sheet
        
        local col = (idx%cols)
        if col == 0 then 
            col = cols
        end
        
        local row = math.ceil( (idx*u) / sff.sprite.sheetW )
        col=col-1   -- make first colum be 0 instead of 1
        row=row-1   -- make first row   be 0 instead of 1
        
        return love.graphics.newQuad(
            col*u, row*u,
            w*u, h*u,
            sff.sprite.sheetW, sff.sprite.sheetH
        )
    end


    -- ******** --
    -- Graphics --
    -- ******** --
    sff.graphics.pset = function(x,y)
        love.graphics.rectangle("fill",x,y, 1, 1)
    end


    -- ******* --
    -- Gamepad --
    -- ******* --
    sff.gamepad.clear = function()
        sff.gamepad.enter     = false
        sff.gamepad.a         = false
        sff.gamepad.b         = false
        sff.gamepad.up        = false
        sff.gamepad.down      = false
        sff.gamepad.left      = false
        sff.gamepad.right     = false
        sff.gamepad.aCallback     = function() end
        sff.gamepad.bCallback     = function() end
        sff.gamepad.enterCallback = function() end
    end


    -- *************** --
    -- Engine Defaults --
    -- *************** --
    sff.font = sff.fonts.pico8
    sff.palette = sff.palettes.arne16
    

    return sff
end