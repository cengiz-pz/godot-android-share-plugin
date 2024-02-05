@tool
extends EditorPlugin

const PLUGIN_NODE_TYPE_NAME = "Share"
const PLUGIN_PARENT_NODE_TYPE = "Node"
const PLUGIN_NAME: String = "@pluginName@"
const PLUGIN_VERSION: String = "@pluginVersion@"
const PLUGIN_PACKAGE: String = "@pluginPackage@"

var export_plugin: AndroidExportPlugin


func _enter_tree() -> void:
	add_custom_type(PLUGIN_NODE_TYPE_NAME, PLUGIN_PARENT_NODE_TYPE, preload("Share.gd"), preload("icon.png"))
	export_plugin = AndroidExportPlugin.new()
	add_export_plugin(export_plugin)


func _exit_tree() -> void:
	remove_custom_type(PLUGIN_NODE_TYPE_NAME)
	remove_export_plugin(export_plugin)
	export_plugin = null


class AndroidExportPlugin extends EditorExportPlugin:
	var _plugin_name = PLUGIN_NAME


	func _supports_platform(platform: EditorExportPlatform) -> bool:
		if platform is EditorExportPlatformAndroid:
			return true
		return false


	func _get_android_libraries(platform: EditorExportPlatform, debug: bool) -> PackedStringArray:
		if debug:
			return PackedStringArray(["%s/bin/debug/%s-%s-debug.aar" % [_plugin_name, _plugin_name, PLUGIN_VERSION]])
		else:
			return PackedStringArray(["%s/bin/release/%s-%s-release.aar" % [_plugin_name, _plugin_name, PLUGIN_VERSION]])


	func _get_name() -> String:
		return _plugin_name


	func _get_android_dependencies(platform: EditorExportPlatform, debug: bool) -> PackedStringArray:
		return PackedStringArray([
			"androidx.appcompat:appcompat:1.6.1"
		])


	func _get_android_manifest_application_element_contents(platform: EditorExportPlatform, debug: bool) -> String:
		var __contents: String = ""

		if platform is EditorExportPlatformAndroid:
			__contents += "<provider android:name=\"%s.ShareFileProvider\"\n" % PLUGIN_PACKAGE
			__contents += "\t\tandroid:exported=\"false\"\n"
			__contents += "\t\tandroid:authorities=\"%s.sharefileprovider\"\n" % get_option("package/unique_name")
			__contents += "\t\tandroid:grantUriPermissions=\"true\">\n"
			__contents += "\t<meta-data android:name=\"android.support.FILE_PROVIDER_PATHS\" android:resource=\"@xml/file_provider_paths\"/>\n"
			__contents += "</provider>\n"

		return __contents
