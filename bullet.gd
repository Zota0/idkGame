extends RigidBody2D

@onready var player = $"../../player"
var not_used : bool = true
var velo :Vector2 = Vector2(0,0)
var shootedBy
var DeltaTime :float = 0.16
var damage :float = 0.0
var collision_count :int = 0

func CollisionLayerChange(whos):
	if whos == player:
		set_collision_layer_value(1, false)
		set_collision_layer_value(2, true)
	else:
		set_collision_layer_value(1, true)
		set_collision_layer_value(2, false)

func _ready():
	CollisionLayerChange(shootedBy)
	set_collision_layer_value(1, false)
	set_collision_layer_value(2, false)
	SelfDeteteTimer()

func SelfDeteteTimer(time:float = 15):
	await get_tree().create_timer(time).timeout
	queue_free()

func _on_body_entered(body):
	if body == player:
		print("NOTICE: Player got damage")
		player.AddDamage(damage)
		queue_free()
	elif body == null:
		print("ERROR: Body is null? wtf")
	elif body is StaticBody2D:
		queue_free()
	elif body is TileMap:
		SelfDeteteTimer(1)
	else:
		if body.has_method("AddDamage"):
			body.AddDamage(damage)
			queue_free()
		else:
			print("WARNING: Body has no damage function")

func _process(delta):
	#if Input.is_key_pressed(KEY_INSERT) && not_used == true:
		#print_debug(rotation)
		#not_used = false
	DeltaTime = delta
	
	var collision :KinematicCollision2D = move_and_collide(velo * delta * 100)
	if collision:
		if !(collision.get_collider() is CharacterBody2D):
			collision_count += 1
			var reflect = collision.get_remainder().bounce(collision.get_normal())
			velo = velo.bounce(collision.get_normal())
			move_and_collide(reflect)
			print(collision.get_collider())
	if collision_count >= 5:
		SelfDeteteTimer(0.25)
