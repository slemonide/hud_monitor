# hud_monitor
This is a Minetest/Freeminer mod that gives api to place text on player's screen

## How to use
To add widget, use hud_monitor.place(text, id, player)
"text" is text you want to write on the player's screen
"id" is the id of your widged (you'll need it to change your widget)
"player" is the player who you want to see the widged. Leave this blank to make
all players see the widget

To change your widget, use hud_monitor.place(text, id, player) second time
using id you used the first time.

## Licensing
- Code: WTFPL

## Dependencies
- none
