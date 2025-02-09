//
// © 2024-present https://github.com/cengiz-pz
//

package org.godotengine.plugin.android.share;

import android.app.Activity;
import android.content.ClipData;
import android.content.Intent;
import android.net.Uri;
import android.util.Log;
import android.view.View;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.core.content.FileProvider;

import org.godotengine.godot.Dictionary;
import org.godotengine.godot.Godot;
import org.godotengine.godot.plugin.GodotPlugin;
import org.godotengine.godot.plugin.UsedByGodot;
import org.godotengine.plugin.android.share.model.SharedData;

import java.io.File;

public class SharePlugin extends GodotPlugin {
	private static final String CLASS_NAME = SharePlugin.class.getSimpleName();
	private static final String LOG_TAG = "godot::" + CLASS_NAME;
	private static final String FILE_PROVIDER = ".sharefileprovider";
	private static final String MIME_TYPE_TEXT = "text/plain";
	private static final String MIME_TYPE_IMAGE = "image/*";

	private Activity activity;
	private String authority;

	public SharePlugin(Godot godot) {
		super(godot);
	}

	@UsedByGodot
	public void share(Dictionary data) {
		Log.d(LOG_TAG, "share() called");

		SharedData sharedData = new SharedData(data);
		Intent shareIntent = new Intent(android.content.Intent.ACTION_SEND);
		shareIntent.putExtra(android.content.Intent.EXTRA_SUBJECT, sharedData.getSubject());
		shareIntent.putExtra(android.content.Intent.EXTRA_TEXT, sharedData.getContent());

		String mime_type = sharedData.getMimeType();
		String path = sharedData.getImagePath();
		if (path != null && !path.isEmpty()) {
			File f = new File(path);

			Uri uri;
			try {
				uri = FileProvider.getUriForFile(activity, authority, f);
			} catch (IllegalArgumentException e) {
				Log.e(LOG_TAG, String.format("The selected file can't be shared: %s", path), e);
				return;
			}

			if (mime_type == null) {
				// override mime type if none has been provided by the user
				mime_type = MIME_TYPE_IMAGE;
			}
			shareIntent.setClipData(ClipData.newRawUri("", uri));
			shareIntent.putExtra(Intent.EXTRA_STREAM, uri);
			shareIntent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
		}

		if (mime_type != null) {
			shareIntent.setType(mime_type);
		} else {
			shareIntent.setType(MIME_TYPE_TEXT);
		}

		activity.startActivity(Intent.createChooser(shareIntent, sharedData.getTitle()));
	}

	@NonNull
	@Override
	public String getPluginName() {
		return CLASS_NAME;
	}

	@Nullable
	@Override
	public View onMainCreate(Activity activity) {
		this.activity = activity;
		this.authority = activity.getPackageName() + FILE_PROVIDER;
		return super.onMainCreate(activity);
	}
}
