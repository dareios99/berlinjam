extends Button

var started = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _button_pressed():
	if !started:
		get_tree().root.start()
		started = true
		self.text = "STOP"
	else: 
		get_tree().root.stop()
		started = false
		self.text = "START!"
