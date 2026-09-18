extends Node2D
## Level controller: remembers the player's start point, respawns the player
## when they touch spikes, and shows a "Level Complete" banner at the goal.

@onready var player: CharacterBody2D = $Player
@onready var win_label: Label = $UI/WinLabel

var _start_position: Vector2
var _completed: bool = false


func _ready() -> void:
	# The player's authored position in the scene is the respawn point.
	_start_position = player.global_position
	win_label.visible = false

	# Any body entering the spikes respawns; entering the goal wins.
	$Spikes.body_entered.connect(_on_spikes_body_entered)
	$Goal.body_entered.connect(_on_goal_body_entered)


func _on_spikes_body_entered(body: Node) -> void:
	if body == player:
		_respawn()


func _respawn() -> void:
	player.velocity = Vector2.ZERO
	player.global_position = _start_position


func _on_goal_body_entered(body: Node) -> void:
	if body == player and not _completed:
		_completed = true
		win_label.visible = true
