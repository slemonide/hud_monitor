hud_monitor = {}
hud_monitor.text = {} -- contains all widgets
hud_monitor.text.all = {} -- widgets that all players see the same way
hud_monitor.text.user = {} -- personalized widgets

function hud_monitor.update(player) -- Updates monitor
	local monitor = ""
	for _,text in pairs(hud_monitor.text.all) do
		monitor = monitor .. text .. "\n"			
		local SEPARATOR_LENGTH = 50
		local i = 0
		while i < SEPARATOR_LENGTH do
			monitor = monitor .. "-"
			i = i + 1
		end
		monitor = monitor .. "\n"
	end

	if hud_monitor.text.user[player] then
		for _,text in pairs(hud_monitor.text.user[player]) do
			monitor = monitor .. text .. "\n"			
			local SEPARATOR_LENGTH = 50
			local i = 0
			while i < SEPARATOR_LENGTH do
				monitor = monitor .. "-"
				i = i + 1
			end
			monitor = monitor .. "\n"
		end
	end

	player:hud_change("1", "text", monitor)
end

function hud_monitor.place(text, id, player)
	if player then
		if id then
			hud_monitor.text.user[player] = {} -- Need to fix this garbage
			hud_monitor.text.user[player][id] = text
		else
			table.insert(hud_monitor.text.user, text)
		end	
	else
		if id then
			hud_monitor.text.all[id] = text
		else
			table.insert(hud_monitor.text.all, text)
		end
	end

	for _,player in ipairs(minetest.get_connected_players()) do -- Update monitors
		hud_monitor.update(player)
	end
end

minetest.register_on_joinplayer(function(player) -- Holds place for the monitor
	player:hud_add({
		hud_elem_type = "text",
		id = "1",
		position = {x=1, y=0.1},
		text = "",
		number = 0xFF5533,
		item = 0,
		size = {x=1, y=1},
		offset = { x = -200, y = 0}
	})
	hud_monitor.update(player) -- Update monitor for each new player
end)
