function sec_to_human(seconds) -- This is confusing
	local minutes_total = math.floor(seconds / 60)
	local seconds = seconds % 60 -- this is < 60
	local hours_total = math.floor(minutes_total / 60)
	local hours = hours_total % 60
	local minutes = minutes_total % 60 -- this is < 60
	local days_total = math.floor(hours_total / 24)
	local days = days_total % 24

	-- day or days?
	local d_or_ds = ""
	if days == 1 then
		d_or_ds = " day "
	else
		d_or_ds = " days "
	end

	-- hour or hours?
	local h_or_hs = ""
	if hours == 1 then
		h_or_hs = " hour "
	else
		h_or_hs = " hours "
	end

	-- minute or minutes?
	local m_or_ms = ""
	if minutes == 1 then
		m_or_ms = " minute "
	else
		m_or_ms = " minutes "
	end

	-- second or seconds?
	local s_or_ss = ""
	if seconds == 1 then
		s_or_ss = " second"
	else
		s_or_ss = " seconds"
	end

	local string = ""
	if days ~= 0 then
		string = days .. d_or_ds
	end
	if hours ~= 0 then
		string = string .. hours .. h_or_hs
	end
	if minutes ~= 0 then
		string = string .. "\n" .. minutes .. m_or_ms .. "and "
	end

	local string = string .. seconds .. s_or_ss
	return string 
end

function print_player_data()
	for _,player in ipairs(minetest.get_connected_players()) do
		local pos = player:getpos()

		local light = minetest.get_node_light(pos) -- Light level
		if light then
			local text = "The light level is " .. light .. " SLU"
			hud_monitor.place(text, "light", player)
		end

		-- Detect on what node the player stands
		local below = {x=pos.x,y=pos.y-1,z=pos.z}
		local node_name = minetest.get_node(below).name
		hud_monitor.place("You are standing on:\n" .. node_name, "ground", player)

		-- Detect in what node the player stands
		local node_name = minetest.get_node(pos).name
		hud_monitor.place("You are in the " .. node_name, "air", player)

		-- Write player's ip address (only in multiplayer)
		if not minetest.is_singleplayer() then
			local player_name = player:get_player_name()
			local ip = minetest.get_player_ip(player_name)
			if not ip then return end
			hud_monitor.place("Your ip is " .. ip, "ip", player)
		end

		-- Shows player height above sea level
		local sea_level = minetest.get_mapgen_params().water_level
		local elevation_sea = math.ceil(pos.y - sea_level)
		local wording = {"above", "below"}
		local word = ""
		if elevation_sea == 0 then
			local text = "You are at the sea level."
			hud_monitor.place(text, "sea_level", player)
			break
		elseif elevation_sea > 0 then
			word = wording[1]
		else
			word = wording[2]
		end
		local text = "You are " .. math.abs(elevation_sea) .. " blocks " .. word .. " sea level"
		hud_monitor.place(text, "sea_level", player)
	end

	-- Writes how old the world is
	local age = sec_to_human(minetest.get_gametime())
	hud_monitor.place("This world is " .. age .. " old", "age")

	-- Show time only in singleplayer mode (to avoid timezones problems)
if minetest.is_singleplayer() then
	-- Shows real time
	local time = os.date("%T")
	hud_monitor.place("Real time is " .. time, "time")

	-- Shows real date
	local date = os.date("%D")
	hud_monitor.place("Real date is " .. date, "date")
end

	minetest.after(0.5, print_player_data)
end
minetest.after(0.5, print_player_data)

