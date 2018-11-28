require("engine.sff.entity")
require("engine.base.helpers")

function dialogBox(parent)
    local e={}
    e.sprite = love.graphics.newImage("assets/dialogbox.png")
    e.dialogY = CONF.height - 25
    e.text = ""

    -- TODO: setText recibe un array con todas las líneas, y la navegación se resuelve en este objeto
    function e:setText(text)
        self.text = text
    end

    function e:update()

    end

    function e:draw()
        love.graphics.draw(self.sprite, 1, self.dialogY)
        if string.len(self.text) > 0 then
            local scale = 0.2
            love.graphics.setFont(sff.fonts.pressStart2p)
            love.graphics.scale(scale)
            love.graphics.setColor(sff.palette[10])
            love.graphics.printf(self.text:upper(), 5/scale, (self.dialogY/scale)+5/scale, (CONF.width-5)/scale, "left")
        end
    end

    add(parent, e)
    return e
end

