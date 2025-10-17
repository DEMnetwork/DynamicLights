scoreboard players enable @a settings
execute as @a at @s unless entity @s[scores={settings=0}] run function dynamiclights:settings/home
execute as @a[scores={sc=1}] at @s run function dynamiclights:settings/ext
execute as @a[scores={sc=2}] at @s run function dynamiclights:settings/ext
execute as @a[scores={sc=-1}] at @s run function dynamiclights:settings/save
execute as @a[scores={sc=-2}] at @s run function dynamiclights:settings/home