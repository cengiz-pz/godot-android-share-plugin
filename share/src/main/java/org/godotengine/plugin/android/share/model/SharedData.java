//
// © 2024-present https://github.com/cengiz-pz
//

package org.godotengine.plugin.android.share.model;

import org.godotengine.godot.Dictionary;

public class SharedData {
	private static String DATA_KEY_TITLE = "title";
	private static String DATA_KEY_SUBJECT = "subject";
	private static String DATA_KEY_CONTENT = "content";
	private static String DATA_KEY_IMAGE_PATH = "image_path";

	private Dictionary data;

	public SharedData(Dictionary data) {
		this.data = data;
	}

	public String getTitle() {
		return (String) data.get(DATA_KEY_TITLE);
	}

	public String getSubject() {
		return (String) data.get(DATA_KEY_SUBJECT);
	}

	public String getContent() {
		return (String) data.get(DATA_KEY_CONTENT);
	}

	public String getImagePath() {
		return (String) data.get(DATA_KEY_IMAGE_PATH);
	}
}
