class_name Waypoint
extends Area2D




func _on_body_entered(body: Node2D) -> void:
	if body is Guard:
		body.waypoint_reached(self)
