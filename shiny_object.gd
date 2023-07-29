extends Area2D



@export_enum("diamond", "gold", "chest") var type_of_treasure:String = "diamond"




func collect_treasure(the_person:Person) -> void:
	the_person.receive_treasure(type_of_treasure)
	AudioManager.play_sound("treasure")
	get_parent().remove_child(self)
	self.queue_free()
	
	


func _on_body_entered(body: Node2D) -> void:
	if not body is Person:
		return
	else:
		collect_treasure(body)
