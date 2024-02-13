extends Node2D

@onready var BulletInit = preload("res://bullet.tscn")
@onready var marker = $"../player/Aim/AimCross"
@onready var aim = $"../player/Aim"
@onready var player = $"../player"

func getBulletDir(bullet, whos):
	var out = get_global_mouse_position() - bullet.global_position
	return (out / 100)

func Spawn(where, byWho, damage):
	var BULLET = BulletInit.instantiate()
	add_child(BULLET)
	BULLET.global_position = where
	BULLET.velo = getBulletDir(BULLET, byWho)
	BULLET.shootedBy = byWho
	BULLET.damage = damage
