scoreboard players enable @s sc
scoreboard players set @s settings 0
scoreboard players set @s sc 0
function dynamiclights:settings/syncs
tellraw @s {"text":"Settings/","bold":true,"underlined":true,"color":"gold"}
tellraw @s {"text":"[Extensions]","bold":true,"color":"dark_gray","clickEvent":{"action":"run_command","value":"/trigger sc set 1"},"hoverEvent":{"action":"show_text","contents":[{"text":"Modify settings for extensions"}]}}
tellraw @s {"text":"[Save]","bold":true,"underlined":true,"color":"dark_green","clickEvent":{"action":"run_command","value":"/trigger sc set -1"},"hoverEvent":{"action":"show_text","contents":[{"text":"Save settings"}]}}