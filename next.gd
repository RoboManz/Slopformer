extends Area2D


func _ready() -> void:
	$AnimatedSprite2D.play("default")


func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		var currentSceneFile = get_tree().current_scene.scene_file_path
		var nextRoom = currentSceneFile.to_int()+1	
		var nextRoomPath = "res://levels/world_one/room_" + str(nextRoom) + ".tscn"
		get_tree().change_scene_to_file.call_deferred(nextRoomPath)
