package com.example.to_do_list;

import android.Manifest;
import android.annotation.SuppressLint;
import android.content.pm.PackageManager;
import android.media.MediaPlayer;
import android.media.MediaRecorder;
import android.os.Bundle;
import android.os.Environment;
import android.util.Log;

import java.io.File;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;

import androidx.annotation.NonNull;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
    public String channel = "demo.message.com";
    final List<String> list = new ArrayList<String>();
    final List<String> fileNameList = new ArrayList<String>();
    final List<String> filePath = new ArrayList<String>();
    private MediaRecorder audioRecorder;
    MediaPlayer mediaPlayer;

    @SuppressLint("SimpleDateFormat")
    private static final SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy.MM.dd.HH.mm.ss");
    Timestamp timestamp = new Timestamp(System.currentTimeMillis());
    String fileName = sdf1.format(timestamp);

    @Override
    protected void onCreate(Bundle savedInstanceState) {

        checkNeedPermissions();
        String outPutFileName = Environment.getExternalStorageDirectory().getAbsolutePath() + "/"+ fileName +".3gp";
        audioRecorder = new MediaRecorder();
        mediaPlayer = new MediaPlayer();


        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(new FlutterEngine(this));
        new MethodChannel(getFlutterEngine().getDartExecutor().getBinaryMessenger(),channel).setMethodCallHandler(new MethodChannel.MethodCallHandler(){
            
            @Override
            public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
                
//                final String message = call.arguments();
//                if(call.method.equals("getMethod")){
//                    result.success(list);
//                }
//                if(call.method.equals("sendMessage")){
//                    list.add(message);
//
//                }
//                if(call.method.equals("deleteMessage")){
//                    list.remove(Integer.parseInt(message));
//                }
                if(call.method.equals("MIC_ON")){
                    fileNameList.add(fileName);
                    filePath.add(outPutFileName);
                    audioRecorder.setAudioSource(MediaRecorder.AudioSource.MIC);
                    audioRecorder.setOutputFormat(MediaRecorder.OutputFormat.THREE_GPP);
                    audioRecorder.setAudioEncoder(MediaRecorder.AudioEncoder.AAC);
                    audioRecorder.setOutputFile(outPutFileName);

                    try {
                        audioRecorder.prepare();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                    audioRecorder.start();

                }if(call.method.equals("MIC_OFF")){
                    result.success(fileNameList);
                    
                    audioRecorder.stop();
                    audioRecorder.reset();
                    audioRecorder.release();
                    audioRecorder = null;
                    System.out.println("MIC_OFF");
                }
                if(call.method.equals("PLAY")){

                    try{
                        mediaPlayer.setDataSource(outPutFileName);

                        mediaPlayer.prepare();
                    }catch(Exception e){
                        e.printStackTrace();
                    }
                    mediaPlayer.start();

                }if(call.method.equals("STOP")){
                    mediaPlayer.stop();
//                    mediaPlayer.reset();
//                    mediaPlayer.release();
//                    mediaPlayer = null;
                }
                System.out.println(filePath);
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
