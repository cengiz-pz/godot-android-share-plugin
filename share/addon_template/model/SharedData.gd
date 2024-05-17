#
# © 2024-present https://github.com/cengiz-pz
#

class_name SharedData
extends RefCounted

const DATA_KEY_TITLE = "title"
const DATA_KEY_SUBJECT = "subject"
const DATA_KEY_CONTENT = "content"
const DATA_KEY_IMAGE_PATH = "image_path"

var _data: Dictionary


func _init() -> void:
	_data = {}


func set_title(a_title: String) -> SharedData:
	_data[DATA_KEY_TITLE] = a_title
	return self


func set_subject(a_subject: String) -> SharedData:
	_data[DATA_KEY_SUBJECT] = a_subject
	return self


func set_content(a_content: String) -> SharedData:
	_data[DATA_KEY_CONTENT] = a_content
	return self


func set_image_path(a_image_path: String) -> SharedData:
	_data[DATA_KEY_IMAGE_PATH] = a_image_path
	return self


func get_raw_data() -> Dictionary:
	return _data
