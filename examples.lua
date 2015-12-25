function sec_to_human(seconds) -- This is confusing
	local minutes_total = math.floor(seconds / 60)
	local seconds = seconds % 60 -- this is < 60
	local hours_total = math.floor(minutes_total / 60)
	local hours = minutes_total % 60
	local minutes = minutes_total % 60 -- this is < 60
	local days_total = math.floor(hours_total / 24)
	local days = hours_total % 24
	local string = days .. " days, " .. hours .. " hours,\n " .. minutes .. " minutes and " .. seconds .. " seconds"
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
		hud_monitor.place("You are standing on " .. node_name, "ground", player)

		-- Detect in what node the player stands
		local node_name = minetest.get_node(pos).name
		hud_monitor.place("You are in " .. node_name, "air", player)

		-- Writes how old the world is
		local age = sec_to_human(minetest.get_gametime())
		hud_monitor.place("This world is " .. age .. " old", "age", player)

		-- Write player's ip address
		local player_name = player:get_player_name()
		local ip = minetest.get_player_ip(player_name)
		hud_monitor.place("Your ip is " .. ip, "ip", player)

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
	minetest.after(0.5, print_player_data)
end
minetest.after(0.5, print_player_data)
