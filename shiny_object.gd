extends Area2D



func collect_treasure(the_person:Person) -> void:
	# do something
	AudioManager.play_sound("treasure")
	get_parent().remove_child(self)
	self.queue_free()
	
	pass


func _on_body_entered(body: Node2D) -> void:
	if not body is Person:
		return
	else:
		collect_treasure(body)
