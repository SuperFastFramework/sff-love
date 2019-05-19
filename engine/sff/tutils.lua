-- text utils -------------------------------------------------
-- implements drawable interface ------------------------------

--[[
local text = tutils({
	text="",								-- text to display
	x=2, y=2, centerx=false, centery=false,	-- positioning. center(x|y) overrides x and y fields
	fg=7, bg=2, sh=3,						-- foreground, background and shadow colors
	bordered=false, shadowed=false,			-- make the text bordered and|or shadowed
	blink=false, on_time=5, off_time=5,		-- make the text blink. on_time and off_time are for "blink" only
	font=sff.font, scale=1,					-- font & font size
	retro=false, retro_speed=5				-- retro effect of letter by letter. retro_speed lower is faster
})


"text" is the only mandatory argument
--]]
function tutils(args)
	local s={}
	s.private={}
	s.private.blink_tick =0
	s.private.retro_tick=0
	s.private.retro_letter_cnt=1
	s.private.retro_finished=false
	s.private.retro_text=""

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
	s._retro=args.retro or false
	s._retro_speed=args.retro_speed or 3
	s._blink=args.blink or false
	s._blink_on=args.on_time or 5
	s._blink_off=args.off_time or 5
	s._font=args.font or sff.font
	s._scale=args.scale or 1

	local maxWidth=CONF.width/s._scale
	local midHeight = CONF.height/2
	local fontHeightMid = 4/2 -- Font height in pixels / 2
	local cy = midHeight - fontHeightMid

	function s:draw()
 		love.graphics.push()
		love.graphics.scale(self._scale)
		love.graphics.setFont(self._font)

		local alignMode = "left"
		if self._centerx then alignMode = "center" end
		if self._centery then self._y = cy end

		local text = s.text
		if s._retro then
			if not s.private.retro_finished then
				local t = s.private.retro_tick
				local lc = s.private.retro_letter_cnt

				s.private.retro_text = string.sub(s.text, 1, lc)
				s.private.retro_tick = t+1
				if lc >= #s.text then s.private.retro_finished = true end

				if t % s._retro_speed == 0 then s.private.retro_letter_cnt = lc+1 end
			end

			text = s.private.retro_text
		end

		-- Blink related stuff
		local blinkOffCicle=false
		if self._blink then 
			self.private.blink_tick =self.private.blink_tick +1
			local offtime=self._blink_on+self._blink_off -- for internal use
			if(self.private.blink_tick >offtime) then self.private.blink_tick =0 end
			local blink_enabled_on = false
			if(self.private.blink_tick <self._blink_on)then
				blink_enabled_on = true
			end
			-- If it's supposed to blink, but it's on a off position then don't print anything
			if(not blink_enabled_on) then
				blinkOffCicle=true
			end
		end

		if not blinkOffCicle then
			if self._bordered then
				local xx =math.max(self._x,1)
				local yy =math.max(self._y,1)

				if(self._shadowed)then
					for i=-1, 1 do
						love.graphics.setColor(sff.palette[self._sh])
						love.graphics.printf(text, (xx +i)/self._scale, (self._y+2)/self._scale, maxWidth, alignMode)
					end
				end

				for i=-1, 1 do
					for j=-1, 1 do
						love.graphics.setColor(sff.palette[self._bg])
						love.graphics.printf(text, (xx +i)/self._scale, (yy +j)/self._scale, maxWidth, alignMode)
					end
				end
			elseif self._shadowed then
				love.graphics.setColor(sff.palette[self._sh])
				love.graphics.printf(text, self._x/self._scale, (self._y+1)/self._scale, maxWidth, alignMode)
			end

			love.graphics.setColor(sff.palette[self._fg])
			love.graphics.printf(text, self._x/self._scale, self._y/self._scale, maxWidth, alignMode)
		end

		love.graphics.pop()
    end

	return s
end
