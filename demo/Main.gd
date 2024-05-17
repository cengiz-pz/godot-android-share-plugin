#
# © 2024-present https://github.com/cengiz-pz
#

extends Node

@export var shared_title: String = "My Title"
@export var shared_subject: String = "My Subject"

@onready var share: Share = $Share as Share
@onready var _text_edit: TextEdit = $CanvasLayer/CenterContainer/VBoxContainer/VBoxContainer/TextEdit as TextEdit
@onready var _label: RichTextLabel = $CanvasLayer/CenterContainer/VBoxContainer/RichTextLabel as RichTextLabel
@onready var _texture_rect: TextureRect = $CanvasLayer/CenterContainer/VBoxContainer/TextureRect as TextureRect


func _on_share_texture_button_pressed() -> void:
	_print_to_screen("Sharing texture")
	share.share_texture(_texture_rect.texture, shared_title, shared_subject, _text_edit.text)


func _on_share_viewport_button_pressed() -> void:
	_print_to_screen("Sharing viewport")
	share.share_viewport(get_viewport(), shared_title, shared_subject, _text_edit.text)


func _print_to_screen(a_message: String, a_is_error: bool = false) -> void:
	_label.add_text("%s\n\n" % a_message)
	if a_is_error:
		printerr(a_message)
	else:
		print(a_message)
