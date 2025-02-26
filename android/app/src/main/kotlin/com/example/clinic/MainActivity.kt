package com.example.clinic


import android.content.Intent
import android.net.Uri
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example.whatsapp/channel"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "sendToWhatsAppBusiness") {
                val phoneNumber = call.argument<String>("phoneNumber")
                val message = call.argument<String>("message")

                try {
                    val intent = Intent(Intent.ACTION_VIEW).apply {
                        data = Uri.parse("whatsapp://send?phone=$phoneNumber&text=${Uri.encode(message)}")
                        setPackage("com.whatsapp.w4b") // Target WhatsApp Business
                    }
                    startActivity(intent)
                    result.success("Success")
                } catch (e: Exception) {
                    result.error("ERROR", "Failed to launch WhatsApp Business", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }
}
