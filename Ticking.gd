extends Node

var SpawnerTick : int = 0
var LastSpawnerTick :int = 0
var Enemy_0 = preload("res://enemy_0.tscn")
var limit :bool = false
@onready var player = get_tree().get_first_node_in_group("player")

func _ready():
	SpawnerTicking()

func SpawnerTicking():
	LastSpawnerTick = SpawnerTick
	await get_tree().create_timer(0.5).timeout
	SpawnerTick += 1
	if ((Ticking.SpawnerTick %10 == 0) && (limit == false)):
		var SpawnEnemy_0 = Enemy_0.instantiate()
		var get_spawner = get_tree().get_nodes_in_group("EnemySpawners")
		for spawner in get_spawner:
			spawner.add_child(SpawnEnemy_0)
			SpawnEnemy_0.position.x = randf_range(5,1000) / player.position.x
			SpawnEnemy_0.position.y = randf_range(5,1000) / player.position.y
		#var spawner = get_tree().get_first_node_in_group("EnemySpawners")
		#spawner.add_child(SpawnEnemy_0)
		#if SpawnEnemy_0:
			#limit = true
		#SpawnEnemy_0.position.x = randf_range(0.5,50)
		#SpawnEnemy_0.position.y = randf_range(0.5,50)
	SpawnerTicking()
