package com.example.to_do_list;

import android.os.Bundle;

import androidx.annotation.NonNull;

import java.util.ArrayList;
import java.util.List;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
    public String channel = "demo.message.com";
    final List list = new ArrayList();
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(new FlutterEngine(this));
        new MethodChannel(getFlutterEngine().getDartExecutor().getBinaryMessenger(),channel).setMethodCallHandler(new MethodChannel.MethodCallHandler(){
            
            @Override
            public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
                
                final String message = call.arguments();
                if(call.method.equals("getMethod")){
                    result.success(list);
                }
                if(call.method.equals("sendMessage")){
                    list.add(message);
                    
                }
                if(call.method.equals("deleteMessage")){
                    list.remove(Integer.parseInt(message));
                }
                System.out.println(list);
            }
        });
    }
}
