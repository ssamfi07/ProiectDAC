import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    //GoogleMaps API KEY
//     GMSServices.providedAPIKei("AIzaSyA-a_9XCelULwZK7fDHSY8aC9i9gLykq14")

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
