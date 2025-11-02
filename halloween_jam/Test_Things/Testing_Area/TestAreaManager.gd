extends Node2D

var waves = [
	{
		"type1" : 2,
		"type2" : 2
	},
	{
		"type2" : 3,
		"type1" : 1
	}
]
var currentWave = 0
var enemiesAlive = 0

func _ready() -> void:
	if !Global.TestAreaFinished:
		StartWave(currentWave)

func StartWave(wave):
	Global.SpawnEnemies(waves[wave], self)
	for cnt in waves[wave].values():
		enemiesAlive += cnt

func _on_enemy_died():
	enemiesAlive -= 1
	if !enemiesAlive:
		if currentWave == waves.size():
			Global.TestAreaFinished = true
			Global.TestAreaDoors = true
		else:
			currentWave += 1
			StartWave(currentWave)
