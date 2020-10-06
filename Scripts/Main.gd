extends Node

var score
var speed = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()

func new_game():
	score = 0
	$PlayerMobile.start_game($SpawnPlayer.position)
	$TimerStart.start()
	$Menu.show_message("Lets go!")
	$Menu.update_score(score)


func _on_PlayerMobile_dead():
	$TimerScore.stop()
	$Menu.game_over()


func _on_TimerStart_timeout():
	$TimerScore.start()


func _on_TimerScore_timeout():
	score += 10
	$Menu.update_score(score)
