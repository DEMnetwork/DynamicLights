execute as @a[scores={sc=2}] at @s if score s0 svals matches 0 run function dynamiclights:settings/extatogglei
execute as @a[scores={sc=2}] at @s if score s0 svals matches 1 run function dynamiclights:settings/extatoggleo
scoreboard players enable @s sc
scoreboard players set @s settings 0
scoreboard players set @s sc 0
function dynamiclights:settings/syncs
tellraw @s {"text":"Settings/Extensions/","bold":true,"underlined":true,"color":"gold"}
tellraw @s {"text":"[..]","bold":true,"underlined":true,"color":"dark_red","clickEvent":{"action":"run_command","value":"/trigger sc set -2"},"hoverEvent":{"action":"show_text","contents":[{"text":"Back to Settings"}]}}
tellraw @s ["",{"text":"[Toggle Extension Usage]","bold":true,"underlined":true,"color":"dark_green","clickEvent":{"action":"run_command","value":"/trigger sc set 2"}},{"text":" (Disabled: ","color":"dark_green"},{"score":{"name":"s0","objective":"svals"},"bold":true,"color":"dark_green"},{"text":")","italic":false,"color":"dark_green"}]