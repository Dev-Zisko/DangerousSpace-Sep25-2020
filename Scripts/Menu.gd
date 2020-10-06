extends CanvasLayer

signal start_game

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func show_message(message):
	$messageLabel.text = message
	$messageLabel.show()
	$messageTimer.start()

func game_over():
	show_message("Game Over")
	yield($messageTimer, "timeout")
	$enterButton.show()
	$messageLabel.text = "Dangerous Space"
	$messageLabel.show()

func update_score(score):
	$scoreLabel.text = str(score)

func _on_messageTimer_timeout():
	$messageLabel.hide()


func _on_enterButton_pressed():
	$enterButton.hide()
	emit_signal("start_game")
