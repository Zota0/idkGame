extends CharacterBody2D

var MaxAttack :float
var MaxSpeed :float
var MaxHP :float

var ATTACK :float
var SPEED :float
var HP :float
var Reach :float

var type = "normal"

@onready var playerGroup = get_tree().get_nodes_in_group("player")
@onready var player = playerGroup[0]
@onready var health_bar = $HealthBar
@onready var enemy_nav = $EnemyNav
var deltaTime :float

# Called when the node enters the scene tree for the first time.
func _ready():
	match(type):
		"normal":
			MaxAttack = 0.5
			MaxHP = 5
			MaxSpeed = 100
			Reach = 200
		"rare":
			MaxAttack = 1
			MaxHP = 15
			MaxSpeed = 150
			Reach = 200
		"very rare":
			MaxAttack = 2
			MaxHP = 20
			MaxSpeed = 200
			Reach = 200
		"boss":
			MaxAttack = 5
			MaxHP = 50
			MaxSpeed = 50
			Reach = 500

	health_bar.max_value = MaxHP
	ATTACK = MaxAttack
	HP = MaxHP
	SPEED = MaxSpeed
	FindPathTimer()

func FindPathTimer():
	await get_tree().create_timer(deltaTime * 100).timeout
	MakePath()
	FindPathTimer()

func _process(delta):
	health_bar.value = HP
	if HP <= 0:
		player.addKillToKillCount()
		queue_free()
	$'Sprite2D'.look_at(player.position)

func _physics_process(delta):
	var dir = to_local(enemy_nav.get_next_path_position()).normalized()
	velocity = dir * SPEED * delta * 100
	move_and_slide()
	deltaTime = delta

func MakePath():
	enemy_nav.target_position = player.global_position

func AddDamage(Value:float):
	print("Should `ADD DAMAGE` to: ",self," By:",Value)
	var lastHp = HP
	HP -= Value
	print("NOTE: Changed `HP` [",lastHp, " ->",HP," / ",MaxHP,"]")
