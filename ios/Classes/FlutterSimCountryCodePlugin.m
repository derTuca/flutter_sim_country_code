#import "FlutterSimCountryCodePlugin.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>

@implementation FlutterSimCountryCodePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"flutter_sim_country_code"
            binaryMessenger:[registrar messenger]];
  FlutterSimCountryCodePlugin* instance = [[FlutterSimCountryCodePlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getSimCountryCode" isEqualToString:call.method]) {
    [self getSimCountryCode:result];
  } else {
    result(FlutterMethodNotImplemented);
  }
}

- (void)getSimCountryCode:(FlutterResult)result {
    CTCarrier *carrier = [[CTTelephonyNetworkInfo new] subscriberCellularProvider];
    if (carrier != nil) {
        NSString *countryCode = carrier.isoCountryCode;
        if (countryCode != nil) {
            result(countryCode);
            return;
        }
    }
    
    FlutterError *fError = [FlutterError errorWithCode:@"SIM_COUNTRY_CODE_ERROR" message:@"Error getting country" details:nil];
    result(fError);

}

@end
