require("engine.sff.entity")
require("engine.base.helpers")

function dialogBox(parent)
    local e={}
    e.sprite = love.graphics.newImage("assets/dialogbox.png")
    e.dialogY = CONF.height - 49
    e.text = ""

    -- TODO: setText recibe un array con todas las líneas, y la navegación se resuelve en este objeto

    function e:setText(text)
        self.text = text
    end

    function e:update()

    end

    function e:draw()
        love.graphics.draw(self.sprite,0, self.dialogY)
        if string.len(self.text) > 0 then
            love.graphics.setColor(sff.palette[11])
            love.graphics.printf(self.text, 5, self.dialogY-1, CONF.width-5, "left")
        end
    end

    add(parent, e)
    return e
end

