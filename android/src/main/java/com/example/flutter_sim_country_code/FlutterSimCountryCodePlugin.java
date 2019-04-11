package com.example.flutter_sim_country_code;

import android.content.Context;
import android.telephony.TelephonyManager;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** FlutterSimCountryCodePlugin */
public class FlutterSimCountryCodePlugin implements MethodCallHandler {

  private Registrar mRegistrar;

  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "flutter_sim_country_code");
    final FlutterSimCountryCodePlugin plugin = new FlutterSimCountryCodePlugin(registrar);
    channel.setMethodCallHandler(plugin);
  }

  private FlutterSimCountryCodePlugin(Registrar mRegistrar) {
    this.mRegistrar = mRegistrar;
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {

    if (call.method.equals("getSimCountryCode")) {
      getSimCountryCode(result);
    } else {
      result.notImplemented();
    }
  }

  private void getSimCountryCode(Result result) {
     TelephonyManager manager = (TelephonyManager) mRegistrar.activeContext().getSystemService(Context.TELEPHONY_SERVICE);
     if (manager != null) {
       String countryId = manager.getSimCountryIso();
       if (countryId != null) {
         result.success(countryId.toUpperCase());
       }
     }
     result.error("SIM_COUNTRY_CODE_ERROR", null, null);
  }
}
