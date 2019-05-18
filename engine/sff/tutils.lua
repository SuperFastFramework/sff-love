-- text utils -------------------------------------------------
-- implements drawable interface ------------------------------

-- args:{
--   text="", x=2, y=2, fg=7, bg=2, sh=3,
--   bordered=false, shadowed=false, centerx=false, centery=false,
--   blink=false, on_time=5, off_time=5,
--	 font=sff.font, scale=1
-- }
-- "text" is the only mandatory argument
function tutils(args)
	local s={}
	s.private={}
	s.private.tick=0
	s.private.blink_speed=1

	s.text=args.text or ""
	s._x=args.x or 2
	s._y=args.y or 2
	s._fg=args.fg or 7
	s._bg=args.bg or 2
	s._sh=args.sh or 3 	-- shadow color
	s._bordered=args.bordered or false
	s._shadowed=args.shadowed or false
	s._centerx=args.centerx or false
	s._centery=args.centery or false
	s._blink=args.blink or false
	s._blink_on=args.on_time or 5
	s._blink_off=args.off_time or 5
	s._font=args.font or sff.font
	s._scale=args.scale or 1
	s._maxwidth=CONF.width/s._scale

	function s:draw()
 		love.graphics.push()
		love.graphics.scale(self._scale)
		love.graphics.setFont(self._font)

		local alignMode = "left"
		if self._centerx then alignMode = "center" end
		if self._centery then self._y = 64-(4/2) end

		-- Blink related stuff
		local blinkOffCicle=false
		if self._blink then 
			self.private.tick=self.private.tick+1
			local offtime=self._blink_on+self._blink_off -- for internal use
			if(self.private.tick>offtime) then self.private.tick=0 end
			local blink_enabled_on = false
			if(self.private.tick<self._blink_on)then
				blink_enabled_on = true
			end
			-- If it's supposed to blink, but it's on a off position then don't print anything
			if(not blink_enabled_on) then
				blinkOffCicle=true
			end
		end

		if not blinkOffCicle then
			if self._bordered then
				local xx =math.max(self._x/self._scale,1)
				local yy =math.max(self._y/self._scale,1)

				if(self._shadowed)then
					for i=-1, 1 do
						love.graphics.setColor(sff.palette[self._sh])
						love.graphics.printf(self.text, (xx +i)/self._scale, (self._y+2)/self._scale, self._maxwidth, alignMode)
					end
				end

				for i=-1, 1 do
					for j=-1, 1 do
						love.graphics.setColor(sff.palette[self._bg])
						love.graphics.printf(self.text, (xx +i)/self._scale, (yy +j)/self._scale, self._maxwidth, alignMode)
					end
				end
			elseif self._shadowed then
				love.graphics.setColor(sff.palette[self._sh])
				love.graphics.printf(self.text, self._x/self._scale, (self._y+1)/self._scale, self._maxwidth, alignMode)
			end

			love.graphics.setColor(sff.palette[self._fg])
			love.graphics.printf(self.text, self._x/self._scale, self._y/self._scale, self._maxwidth, alignMode)
		end

		love.graphics.pop()
    end

	return s
end
