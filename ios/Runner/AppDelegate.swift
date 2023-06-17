import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  private let CHANNEL = "bluetooth_channel"

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        
        if let controller = window.rootViewController as? FlutterViewController {
            let channel = FlutterMethodChannel(name: CHANNEL, binaryMessenger: controller.binaryMessenger)
            channel.setMethodCallHandler { [weak self] call, result in
                if call.method == "enableBluetooth" {
                    self?.enableBluetooth(result: result)
                } else {
                    result(FlutterMethodNotImplemented)
                }
            }
        }
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    private func enableBluetooth(result: @escaping FlutterResult) {
        guard let centralManager = CBCentralManager(delegate: nil, queue: nil) else {
            result(FlutterError(code: "BLUETOOTH_UNAVAILABLE", message: "Bluetooth is not available on this device", details: nil))
            return
        }
        
        if centralManager.state == .poweredOn {
            result(nil)
        } else {
            centralManager.open { (success) in
                if success {
                    result(nil)
                } else {
                    result(FlutterError(code: "ENABLE_FAILED", message: "Failed to enable Bluetooth", details: nil))
                }
            }
        } 
    }
}
