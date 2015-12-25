hud_monitor = {}
hud_monitor.text = {}

function hud_monitor.place(text, id)
	if id then
		hud_monitor.text[id] = text
	else
		table.insert(hud_monitor.text, text)
	end
end

minetest.register_on_joinplayer(function(player)
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
end)

hud_monitor.place('Merry Christmas!')

function update_hud()
	for _,player in ipairs(minetest.get_connected_players()) do
		local monitor = ""
		for _,text in pairs(hud_monitor.text) do
			monitor = monitor .. text .. "\n"			
			local SEPARATOR_LENGTH = 50
			local i = 0
			while i < SEPARATOR_LENGTH do
				monitor = monitor .. "-"
				i = i + 1
			end
			monitor = monitor .. "\n"
		end
		
		player:hud_change("1", "text", monitor)
	end
	minetest.after(1, update_hud)
end
minetest.after(1, update_hud)

function show_pos()
	for _,player in ipairs(minetest.get_connected_players()) do
		local pos = player:getpos()
		local fine_pos = ""
		for _,coord in pairs(pos) do
			fine_pos = fine_pos .. '\t' .. math.floor(coord)
		end
		hud_monitor.place("x\ty\tz\n" .. fine_pos, "pos")
	end
	minetest.after(1, show_pos)
end
minetest.after(1, show_pos)
