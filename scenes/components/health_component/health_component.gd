class_name HealthComponent
extends Node


signal healed(added_hp: int)
signal damaged(taken_dmg: int)
signal died

@export var initial_health: int = 100

@onready var health: int = initial_health
var _is_dead: bool = false


func heal(hp: int) -> void:
	if is_dead() || hp == 0:
		return
	elif hp < 0:
		damage(-hp)
		return
	health += hp
	healed.emit(hp)


func damage(dmg: int) -> void:
	if is_dead() || dmg == 0:
		return
	elif dmg < 0:
		heal(-dmg)
		return
	health -= dmg
	if is_dead(): died.emit()
	else: damaged.emit(dmg)


func is_dead() -> bool:
	_is_dead = _is_dead || health <= 0
	return _is_dead
