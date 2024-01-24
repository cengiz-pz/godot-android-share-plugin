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

import org.godotengine.godot.Godot;
import org.godotengine.godot.plugin.GodotPlugin;
import org.godotengine.godot.plugin.UsedByGodot;

import java.io.File;

public class GodotAndroidSharePlugin extends GodotPlugin {
    private static final String CLASS_NAME = GodotAndroidSharePlugin.class.getSimpleName();
    private static final String LOG_TAG = "godot::" + CLASS_NAME;
    private static final String FILE_PROVIDER = ".sharefileprovider";
    private static final String MIME_TYPE_TEXT = "text/plain";
    private static final String MIME_TYPE_IMAGE = "image/*";

    private Activity activity;
    private String authority;

    public GodotAndroidSharePlugin(Godot godot) {
        super(godot);
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

    @UsedByGodot
    public void shareText(String title, String subject, String text) {
        Log.d(LOG_TAG, "shareText() called");

        Intent shareIntent = new Intent(android.content.Intent.ACTION_SEND);
        shareIntent.setType(MIME_TYPE_TEXT);
        shareIntent.putExtra(android.content.Intent.EXTRA_SUBJECT, subject);
        shareIntent.putExtra(android.content.Intent.EXTRA_TEXT, text);

        activity.startActivity(Intent.createChooser(shareIntent, title));
    }

    @UsedByGodot
    public void shareImage(String path, String title, String subject, String text) {
        Log.d(LOG_TAG, "shareImage() called with path " + path);

        File f = new File(path);

        Uri uri;
        try {
            uri = FileProvider.getUriForFile(activity, authority, f);
        } catch (IllegalArgumentException e) {
            Log.e(LOG_TAG, "The selected file can't be shared: " + path, e);
            return;
        }

        Intent shareIntent = new Intent(Intent.ACTION_SEND);
        shareIntent.setType(MIME_TYPE_IMAGE);
        shareIntent.putExtra(Intent.EXTRA_SUBJECT, subject);
        shareIntent.putExtra(Intent.EXTRA_TEXT, text);
        shareIntent.setClipData(ClipData.newRawUri("", uri));
        shareIntent.putExtra(Intent.EXTRA_STREAM, uri);
        shareIntent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);

        activity.startActivity(Intent.createChooser(shareIntent, title));
    }
}
