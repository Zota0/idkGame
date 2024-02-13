extends CharacterBody2D

var HP :float = 100
@onready var MaxHP :float = HP
var SPEED :float = 650
var velo :Vector2 = Vector2(0,0)
@onready var bullet_gen = $"../bulletGen"
@onready var marker = $Aim/AimCross
var PlayerKillCount = 0
var ATTACK :float = 1
@onready var health_bar = $HealthBar
@onready var kill_count = $KillCount

func _ready():
	health_bar.max_value = MaxHP

func Inputed():
	if Input.is_action_just_released("ui_accept"):
		bullet_gen.Spawn(marker.global_position,self,ATTACK)
	if Input.is_action_pressed("up"):
		return "up"
	if Input.is_action_pressed("down"):
		return "down"
	if Input.is_action_pressed("right"):
		return "right"
	if Input.is_action_pressed("left"):
		return "left"

func addKillToKillCount():
	PlayerKillCount += 1
	print("Kill Count -> ",PlayerKillCount)

func _physics_process(delta):
	health_bar.value = HP
	velocity.abs()
	velocity = Vector2.ZERO
	match(Inputed()):
		"up": velocity.y -= SPEED
		"down": velocity.y += SPEED
		"left": velocity.x -= SPEED
		"right": velocity.x += SPEED
	lerp(velocity, velocity, delta)
	move_and_slide()

	$'Aim'.look_at(get_global_mouse_position())
	var kill_count_text = "KILL COUNT: " + str(PlayerKillCount)
	kill_count.text = kill_count_text

func AddDamage(Value:int):
	print("Should `ADD DAMAGE` to: ",self," By:",Value)
	var lastHp = HP
	HP -= Value
	print("NOTE: Changed `HP` for `player` [",lastHp, " ->",HP," / ",MaxHP,"]")
