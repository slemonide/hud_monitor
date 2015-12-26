local EXAMPLES = true
local ID = 1

hud_monitor = {}
hud_monitor.text = {} -- contains all widgets
hud_monitor.text.all = {} -- widgets that all players see the same way
hud_monitor.text.user = {} -- personalized widgets

function hud_monitor.update(player) -- Updates monitor
	local monitor = {}
	for _,text in pairs(hud_monitor.text.all) do
		table.insert(monitor, text)
	end

	if hud_monitor.text.user[player] then
		for _,text in pairs(hud_monitor.text.user[player]) do
			table.insert(monitor, text)
		end
	end

	local monitor_print = ""
	for _,text in ipairs(monitor) do
		monitor_print = monitor_print .. text .. "\n"
		local SEPARATOR_LENGTH = 50
		local i = 0
		while i < SEPARATOR_LENGTH do
			monitor_print = monitor_print .. "-"
			i = i + 1
		end
		monitor_print = monitor_print .. "\n"
	end

	player:hud_get(ID)
	player:hud_change(ID, "text", monitor_print) -- Adds text
end

function hud_monitor.place(text, id, player)
	if player then
		if id then
			if not hud_monitor.text.user[player] then
				hud_monitor.text.user[player] = {}
			end
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
		name = "Prints useful information",
		hud_elem_type = "text",
		id = ID,
		position = {x=1, y=0.1},
		text = "",
		number = 0xFF0000,
		scale = {x=200, y=200},
--		item = 0,
--		size = {x=1, y=1},
		offset = { x = -130, y = 600}
	})
	hud_monitor.update(player) -- Update monitor for each new player
end)

if EXAMPLES then
	modpath = minetest.get_modpath("hud_monitor") -- Some examples
	dofile(modpath .. "/examples.lua")
end
