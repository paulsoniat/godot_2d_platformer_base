extends Node
class_name HealthComponent

var is_invulnerable := false

func set_invulnerable(value: bool):
	is_invulnerable = value

func take_damage(amount: int):
	if is_invulnerable:
		print("⚠️ No damage taken - invulnerable")
		return
