package com.example.copy_paste;

import android.Manifest;
import android.content.pm.PackageManager;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.drawable.BitmapDrawable;
import android.net.Uri;
import android.os.Bundle;
import android.util.SparseArray;
import android.widget.TextView;


import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

import com.google.android.gms.vision.Detector;
import com.google.android.gms.vision.Frame;
import com.google.android.gms.vision.text.TextBlock;
import com.google.android.gms.vision.text.TextRecognizer;

import java.io.File;
import java.net.URI;
import java.net.URISyntaxException;

import io.flutter.Log;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

import static android.net.Uri.*;

public class MainActivity extends FlutterActivity {

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        System.out.println("///================================");

        checkNeedPermissions();
        TextView textView = null;
        final String channel = "demo.copy_paste.com";
        super.onCreate(savedInstanceState);
//        GeneratedPluginRegistrant.registerWith(new FlutterEngine(this));


        new MethodChannel(getFlutterEngine().getDartExecutor().getBinaryMessenger(), channel).setMethodCallHandler(new MethodChannel.MethodCallHandler(){
            String text = "";
            @Override
            public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
                String path = call.arguments();


                System.out.println(path);
                System.out.println("///================================");

                if(call.method.equals("GOT_FILE")){
                    System.out.println("111111111111111111111111111111111111");
                    System.out.println(path);
                        BitmapFactory.Options bmOptions = new BitmapFactory.Options();
                        Bitmap bitmap = BitmapFactory.decodeFile(path,bmOptions);
                        TextRecognizer _textRecognizer = new TextRecognizer.Builder(getApplicationContext()).build();
                    if(_textRecognizer.isOperational()){
                        Frame frame = new Frame.Builder().setBitmap(bitmap).build();
                                final SparseArray<TextBlock> items = _textRecognizer.detect(frame);
                                            StringBuilder str = new StringBuilder();
                                            for (int i =0; i<items.size(); ++i){
                                                TextBlock bloc = items.valueAt(i);
                                                str.append(bloc.getValue());
                                            }
                        text = str.toString();
                        System.out.println("2222222222222222222222222222222222222");

                        System.out.println(text);

                        System.out.println("2222222222222222222222222222222222222");

                        System.out.println(str.toString());
//                        result.success(text);



//
//                            @Override
//                            public void release() {
//
//                            }
//
//                            @Override
//                            public void receiveDetections(@NonNull Detector.Detections<TextBlock> detections) {
//                                final SparseArray<TextBlock> items = detections.getDetectedItems();
//                                if(items.size() >0){
//                                    textView.post(new Runnable() {
//                                        public void run(){
//                                            StringBuilder str = new StringBuilder();
//                                            for (int i =0; i<items.size(); ++i){
//                                                TextBlock bloc = items.valueAt(i);
//                                                str.append(bloc.getValue());
//                                                str.append("\n");
//                                            }
//                                            text = str.toString();
//                                        }
//                                    });
//                                }
//
//                            }
//                        });
                    }else{
                        Log.w("Activity no avalable","Error in _textRecognizer");
                    }
                }
                if(call.method.equals("GET_TEXT")){
                    result.success(text);

                    System.out.println("000000000000000000000000000000000000");

                }

            }
        });
    }


    private void checkNeedPermissions() {
        //Above 6.0 needs to apply for permission dynamically
        if (ContextCompat.checkSelfPermission(this, Manifest.permission.CAMERA)
                != PackageManager.PERMISSION_GRANTED
                || ContextCompat.checkSelfPermission(this, Manifest.permission.WRITE_EXTERNAL_STORAGE)
                != PackageManager.PERMISSION_GRANTED
                || ContextCompat.checkSelfPermission(this, Manifest.permission.READ_EXTERNAL_STORAGE)
                != PackageManager.PERMISSION_GRANTED
                || ContextCompat.checkSelfPermission(this, Manifest.permission.RECORD_AUDIO)
                != PackageManager.PERMISSION_GRANTED
        ) {
            //Apply for multiple permissions together
            ActivityCompat.requestPermissions(this, new String[]{
                    Manifest.permission.CAMERA,
                    Manifest.permission.WRITE_EXTERNAL_STORAGE,
                    Manifest.permission.READ_EXTERNAL_STORAGE,
                    Manifest.permission.RECORD_AUDIO
            }, 1);
        }
    }

}
