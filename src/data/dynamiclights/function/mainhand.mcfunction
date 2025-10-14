scoreboard players set @s hasLight 0
scoreboard players set @s hasWLight 0
execute as @s[nbt={SelectedItem:{id:"minecraft:torch"}}] run scoreboard players set @s hasLight 1
execute as @s[nbt={SelectedItem:{id:"minecraft:lantern"}}] run scoreboard players set @s hasLight 1
execute as @s[nbt={SelectedItem:{id:"minecraft:sea_pickle"}}] run scoreboard players set @s hasWLight 1