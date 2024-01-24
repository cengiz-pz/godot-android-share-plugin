extends Node

@onready var share: Share = $Share as Share
@onready var _label: RichTextLabel = $CanvasLayer/CenterContainer/VBoxContainer/RichTextLabel as RichTextLabel
@onready var _texture_rect: TextureRect = $CanvasLayer/CenterContainer/VBoxContainer/TextureRect as TextureRect


func _on_share_texture_button_pressed() -> void:
	_print_to_screen("Sharing texture")
	share.share_texture(_texture_rect.texture, "My Title", "My Subject", "My Content")


func _on_share_viewport_button_pressed() -> void:
	_print_to_screen("Sharing viewport")
	share.share_viewport(get_viewport(), "My Title", "My Subject", "My Content")


func _print_to_screen(a_message: String, a_is_error: bool = false) -> void:
	_label.add_text("%s\n\n" % a_message)
	if a_is_error:
		printerr(a_message)
	else:
		print(a_message)
