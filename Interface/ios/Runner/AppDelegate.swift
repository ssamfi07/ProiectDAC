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

    GoogleMaps API KEY
    GMSServices.providedAPIKei("AIzaSyA5nQkXBljiXQzX-9ZXbzHWOhYU1gydFa4")

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
