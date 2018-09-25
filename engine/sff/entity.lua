-- entity -----------------------------------------------
-- implements drawable interface
function bbox(w,h,xoff1,yoff1,xoff2,yoff2)
    local bbox={}
    bbox.offsets={xoff1 or 0,yoff1 or 0,xoff2 or 0,yoff2 or 0}
    bbox.w=w
    bbox.h=h
    -- this values will be overwritten with setx(n) and sety(n)
    bbox.xoff1=bbox.offsets[1]
    bbox.yoff1=bbox.offsets[2]
    bbox.xoff2=bbox.offsets[3]
    bbox.yoff2=bbox.offsets[4]
    -----------------------------------------------------------
    -- public
    function bbox:setx(x)
        self.xoff1=x+self.offsets[1]
        self.xoff2=x+self.w-self.offsets[3]
    end
    function bbox:sety(y)
        self.yoff1=y+self.offsets[2]
        self.yoff2=y+self.h-self.offsets[4]
    end
    function bbox:printbounds()
        love.graphics.setColor(sff.palette[3])
        love.graphics.rectangle('line', self.xoff1, self.yoff1, self.w, self.h)
    end

    return bbox
end

function anim()
    local a={}
    a.list={}
    a.current=false
    a.tick=0
    -- private
    function a:_getCurQuad(one_shot, callback)
        local anim=self.current
        local aspeed=anim.speed
        local fq=anim.fr_cant
        local st=anim.first_fr
        local frame =st+math.floor(self.tick)

        self.tick=self.tick+aspeed
        if frame >= st+fq then
            frame = anim.first_fr
            if one_shot then
                self.tick = self.tick-aspeed
                callback()
            else
                self.tick=0
            end
        end

        return anim.quads[frame]
    end

    -- public
    function a:set_anim(idx)
        if self.currentidx == nil or idx ~= self.currentidx then
            self.tick=0 -- avoids sharing ticks between animations
        end

        self.current=self.list[idx]
        self.currentidx=idx

    end

    function a:addAnim(first_fr, fr_cant, speed, zoomw, zoomh, one_shot, callback)
        local a={}
        a.first_fr=first_fr
        a.fr_cant=fr_cant
        a.speed=speed
        a.w=zoomw
        a.h=zoomh
        a.callback=callback or function()end
        a.one_shot=one_shot or false
        a.pivotX = (zoomw*sff.sprite.pxUnit)/2
        a.pivotY = (zoomh*sff.sprite.pxUnit)/2

        a.quads={}
        local lastfrm = first_fr+fr_cant-1
        for i=first_fr, lastfrm do
            -- I'm using table.insert instead of "add(" due to not caring for the deletion of this quads. And I can't add the idx onto the quad...
            table.insert(a.quads, i, sff.sprite.getQuad(i, zoomw, zoomh) )
        end

        add(self.list, a)
    end

    -- this must be called in the _draw() function
    function a:draw(x,y,flipx,flipy)
        local anim=self.current
        if not anim then
            rectfill(0,117, 128,128, 8)
            print("err: obj without animation!!!", 2, 119, 10)
            return
        end

        local doFlipX = 1
        local doFlipY = 1
        if flipx then doFlipX = -1 end
        if flipy then doFlipY = -1 end

        love.graphics.draw(sff.sprite.sheet , self:_getCurQuad(self.current.one_shot, self.current.callback),
            x, y, 0, doFlipX, doFlipY, anim.pivotX, anim.pivotY)
    end

    return a
end

function entity(anim_obj)
    local e={}
    -- use setx(n) and sety(n) to set this values
    e.x=0
    e.y=0
    ---------------------------------------------
    e.anim_obj=anim_obj

    e.debugbounds, e.flipx, e.flipy = false
    e.bounds=nil

    -- private
    -- flickering---------\\
    -- all private here...
    e.flickerer={}
    e.flickerer.timer=0
    e.flickerer.duration=0          -- this value will be overwritten
    e.flickerer.slowness=3
    e.flickerer.is_flickering=false -- change this flag to start flickering
    function e.flickerer:flicker()
        if(self.timer > self.duration) then
            self.timer=0
            self.is_flickering=false
        else
            self.timer=self.timer+1
        end
    end
    -- end flickering ----//

    -- public:
    function e:setx(x)
        self.x=x
        if self.bounds ~= nil then self.bounds:setx(x) end
    end
    function e:sety(y)
        self.y=y
        if self.bounds ~= nil then self.bounds:sety(y) end
    end
    function e:setpos(x,y)
        self:setx(x)
        self:sety(y)
    end
    function e:set_anim(idx)
        self.anim_obj:set_anim(idx)
    end
    function e:set_bounds(bounds)
        self.bounds = bounds
        self:setpos(self.x, self.y)
    end
    function e:flicker(duration)
        if not self.flickerer.is_flickering then
            self.flickerer.duration=duration
            self.flickerer.is_flickering=true
            self.flickerer:flicker()
        end
        return self.flickerer.is_flickering
    end

    -- this must be called in the _draw() function
    function e:draw()
        if(self.flickerer.timer % self.flickerer.slowness == 0)then
            self.anim_obj:draw(self.x,self.y,self.flipx,self.flipy)
        end
        if self.flickerer.is_flickering then self.flickerer:flicker()  end
        if self.debugbounds             then self.bounds:printbounds() end
    end

    return e
end
-- end entity -------------------------------------------
