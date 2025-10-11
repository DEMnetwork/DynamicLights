execute as @a at @s run function dynamiclights:mainhand
execute as @a at @s run function dynamiclights:offhand
execute as @e[type=marker,tag=light] at @s if entity @p[distance=..1.5] run fill ~ ~ ~ ~ ~1 ~ light[level=15] replace air
execute as @e[type=marker,tag=light] at @s unless entity @p[distance=..1.5] run fill ~ ~ ~ ~ ~1 ~ air replace light[level=15]
execute as @e[type=marker,tag=light] at @s unless block ~ ~ ~ light[level=15] unless block ~ ~1 ~ light[level=15] run kill @s
execute as @e[type=marker,tag=wlight] at @s if entity @p[distance=..1.5] run fill ~ ~ ~ ~ ~1 ~ light[level=15,waterlogged=true] replace water
execute as @e[type=marker,tag=wlight] at @s unless entity @p[distance=..1.5] run fill ~ ~ ~ ~ ~1 ~ water replace light[level=15,waterlogged=true]
execute as @e[type=marker,tag=wlight] at @s unless block ~ ~ ~ light[level=15,waterlogged=true] unless block ~ ~1 ~ light[level=15,waterlogged=true] run kill @s