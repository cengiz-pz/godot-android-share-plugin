@tool
class_name Share
extends Node

const PLUGIN_SINGLETON_NAME: String = "@pluginName@"

@onready var _temp_image_path: String = OS.get_user_data_dir() + "/tmp_share_img_path.png"

var _plugin_singleton: Object


func _ready() -> void:
	_update_plugin()


func _notification(a_what: int) -> void:
	if a_what == NOTIFICATION_APPLICATION_RESUMED:
		_update_plugin()


func _update_plugin() -> void:
	if _plugin_singleton == null:
		if Engine.has_singleton(PLUGIN_SINGLETON_NAME):
			_plugin_singleton = Engine.get_singleton(PLUGIN_SINGLETON_NAME)
		else:
			printerr("%s singleton not found!" % PLUGIN_SINGLETON_NAME)


func share_text(a_title: String, a_subject: String, a_content: String) -> void:
	if _plugin_singleton != null:
		_plugin_singleton.shareText(a_title, a_subject, a_content)
	else:
		printerr("%s plugin not initialized" % PLUGIN_SINGLETON_NAME)


func share_image(a_path: String, a_title: String, a_subject: String, a_content: String) -> void:
	if _plugin_singleton != null:
		_plugin_singleton.shareImage(a_path, a_title, a_subject, a_content)
	else:
		printerr("%s plugin not initialized" % PLUGIN_SINGLETON_NAME)


func share_texture(a_texture: Texture2D, a_title: String, a_subject: String, a_content: String) -> void:
	if _plugin_singleton != null:
		var __image: Image = a_texture.get_image()
		__image.save_png(_temp_image_path)
		_plugin_singleton.shareImage(_temp_image_path, a_title, a_subject, a_content)
	else:
		printerr("%s plugin not initialized" % PLUGIN_SINGLETON_NAME)


func share_viewport(a_viewport: Viewport, a_title: String, a_subject: String, a_content: String, a_flip_y: bool = false) -> void:
	if _plugin_singleton != null:
		var __image: Image = a_viewport.get_texture().get_image()
		if a_flip_y:
			__image.flip_y()
		__image.save_png(_temp_image_path)
		_plugin_singleton.shareImage(_temp_image_path, a_title, a_subject, a_content)
	else:
		printerr("%s plugin not initialized" % PLUGIN_SINGLETON_NAME)
