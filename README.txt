# hud_monitor
This is a Minetest/Freeminer mod that gives api to place text on player's screen

## How to use
To add monitor to the panel, use hud_monitor.place(text, id, player)
"text" is text you want to write on the player's screen
"id" is the id of monitor (you'll need it to change the monitor later)
"player" is the player that would see the monitor.
Leave this blank to make monitor visible to all players.

To change the monitor, use hud_monitor.place(text, id, player)
second time using id you used the first time.

## Licensing
- Code: WTFPL

## Dependencies
- none
