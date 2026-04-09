extends CanvasLayer


const DURATION = 0.5


func fade_in() -> void:
	$ColorRect.show()
	var tween: Tween = create_tween()
	tween.tween_property($ColorRect, 'color', Color(0, 0, 0, 1), DURATION)
	await tween.finished


func fade_out() -> void:
	var tween: Tween = create_tween()
	tween.tween_property($ColorRect, 'color', Color(0, 0, 0, 0), DURATION)
	await tween.finished
	$ColorRect.hide()


## Changes to given packed scene.
func change_scene_packed(scene: PackedScene) -> void:
	await fade_in()
	get_tree().change_scene_to_packed(scene)
	get_tree().paused = false
	await fade_out()


## Changes to scene by given path.
func change_scene_path(path: String) -> void:
	await fade_in()
	get_tree().change_scene_to_file(path)
	get_tree().paused = false
	await fade_out()


## Changes to given scene instance.
## Useful if scene require some prior setup e.g. gameover menu having stats from gamemanager.
##
## Example:
##	func gameover() -> void:
##		var scene: Node = load('scenes/gameover/gameover.tscn').instantiate()
##		Transition.change_scene_instance(scene)
func change_scene_instance(scene: Node) -> void:
	await fade_in()
	get_tree().root.add_child(scene)
	get_tree().current_scene.queue_free()
	get_tree().current_scene = scene
	get_tree().paused = false
	await fade_out()


## Reloads current scene.
func reload_scene() -> void:
	await fade_in()
	get_tree().reload_current_scene()
	get_tree().paused = false
	await fade_out()
