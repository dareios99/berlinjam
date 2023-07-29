extends Area2D

@onready var img_diamond = preload("res://imgs/diamond.png")
@onready var img_gold = preload("res://imgs/diamond.png")
@onready var img_chest = preload("res://imgs/diamond.png")



@export_enum("diamond", "gold", "chest") var type_of_treasure:String = "diamond"

func _ready() -> void:
	match type_of_treasure:
		"diamond":
			$Sprite2D.texture = img_diamond
		"gold":
			$Sprite2D.texture = img_gold
		"chest":
			$Sprite2D.texture = img_chest



func collect_treasure(the_person:Criminal) -> void:
	the_person.receive_treasure(type_of_treasure)
	AudioManager.play_sound("treasure")
	self_delete.call_deferred()
	
	
func self_delete() -> void:
	get_parent().remove_child(self)
	self.queue_free()

func _on_body_entered(body: Node2D) -> void:
	if not body is Criminal:
		return
	else:
		collect_treasure(body)
