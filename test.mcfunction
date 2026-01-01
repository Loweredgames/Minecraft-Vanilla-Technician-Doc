# mcfunction template - esempi di sintassi e comandi
# File di esempio per mostrare le principali istruzioni mcfunction
# I commenti qui sotto spiegano la sintassi; rimuovili quando usi il file reale.

# --- Scoreboard: creazione e uso di obiettivi ---
scoreboard objectives add punti dummy "Punti giocatore"
scoreboard players set @a punti 0
scoreboard players add @p punti 5

# --- Selettori: esempi di filtri ---
# @a = tutti, @p = più vicino, @r = casuale, @s = esecutore, @e = entità
say Esempio selettori: @a, @p, @r, @s, @e
say Giocatori vicini: @a[distance=..10]                   # tutti entro 10 blocchi

# --- Eseguire comandi condizionali con `execute` ---
execute as @a[scores={punti=10..}] run tellraw @s ["",{"text":"Hai >= 10 punti!","color":"green"}]
execute if score @p punti matches 5..10 run say Hai tra 5 e 10 punti
execute unless entity @e[type=armor_stand,tag=marker] run summon armor_stand ~ ~ ~ {Tags:["marker"]}

# --- Salvataggio di risultati con `execute store` ---
# Esegue comando e salva risultato in scoreboard o storage
execute store result score @p punti run data get entity @p Health

# --- Operazioni su scoreboard ---
scoreboard players operation @a punti += @s altri_punti
# --- Gestione dei tag ---
tag @p add GiocatoreInGioco
tag @p list
tag @p remove GiocatoreInGioco

# --- Team ---
team add Blu
team join Blu @a[team=]

# --- Funzione chiamata da un altro file (namespace:path) ---
# Usare in datapack: `function mio_namespace:sub/cartella/azione`
function mynamespace:start_sequence

# --- Messaggi JSON: tellraw, title, actionbar ---
tellraw @a ["",{"text":"Benvenuto nel server!","color":"gold","bold":true}]
title @a title {"text":"Titolo Grande","color":"red"}
title @a subtitle {"text":"Sottotitolo","color":"yellow"}
title @p actionbar {"text":"Barra azione","color":"aqua"}

# --- Suoni e particelle ---
playsound minecraft:entity.player.levelup master @a ~ ~ ~ 1 1
particle minecraft:happy_villager ~ ~1 ~ 0.5 0.5 0.5 0.01 10 force

# --- Summon con NBT ---
summon zombie ~ ~1 ~ {CustomName:'"Zombo"',Health:40.0,Tags:["mob_esempio"]}

# --- Dati: data modify / data get / data merge ---
# Modifica un tag NBT su un'entità
data modify entity @e[type=zombie,limit=1,sort=nearest] CustomName set value "\"MostroModificato\""
# Legge un valore:
execute store result score @p punti run data get entity @p Inventory[0].Count

# --- Blocco e world edit base ---
setblock ~1 ~ ~ minecraft:diamond_block replace
fill ~2 ~ ~ ~5 ~2 ~5 minecraft:stone replace
clone ~ ~-1 ~ ~10 ~-1 ~10 ~20 ~ ~

# --- Items e inventario ---
give @p minecraft:diamond_sword
item replace entity @p weapon.mainhand with minecraft:diamond_sword
clear @p minecraft:stone 0

# --- Storage (datapack storage) ---
data get storage mynamespace:storage_key counter

# --- Loot table ---
loot give @p loot minecraft:chests/simple_dungeon

# --- Predicate (verifica condizioni tramite file predicate) ---
execute if predicate mynamespace:has_enough_points run say Predicate passato

# --- Avanzamenti e ricette ---
advancement grant @p only mynamespace:my_advancement
recipe give @p mynamespace:my_recipe

# --- Esempio avanzato: loop con schedule + funzione ---
# loop.mcfunction:
#   scoreboard players add @s loop_count 1
#   execute if score @s loop_count matches 1..10 run say Loop step
#   execute if score @s loop_count matches ..9 run schedule function mynamespace:loop 1s
# In questo file di esempio chiamiamo la funzione di loop
scoreboard objectives add loop_count dummy "Loop Count"
scoreboard players set @s loop_count 0
function mynamespace:loop

# --- Esempio uso `execute anchored/positioned` ---
execute as @e[type=armor_stand,tag=marker] at @s run summon firework_rocket ~ ~1 ~ {LifeTime:20}
execute positioned ~ ~5 ~ run say Eseguito 5 blocchi sopra

# --- Esempio `execute if entity` con selettore dettagliato ---
execute if entity @e[type=creeper,nbt={Powered:1b}] run say Creeper caricato vicino!

# --- Cleanup temporaneo / debug ---
say Fine del template mcfunction (rimuovi messaggi di debug)

# Note finali:
# - Usa commenti con `#` per annotare il file; non verranno eseguiti.
# - Rimuovi o modifica le righe di esempio prima di usare in produzione.