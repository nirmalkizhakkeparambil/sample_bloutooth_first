import 'package:blutooth_pj/ImagePage%20.dart';
import 'package:blutooth_pj/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:url_launcher/url_launcher.dart';

class home_page extends StatelessWidget {
  const home_page({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: home_butt(),
    );
  }
}

class home_butt extends StatefulWidget {
  @override
  State<home_butt> createState() => _home_buttState();
}

class _home_buttState extends State<home_butt> {
  static const platform = const MethodChannel('bluetooth_channel');

  Future<void> enableBluetooth() async {
    try {
      await platform.invokeMethod('enableBluetooth');
    } on PlatformException catch (e) {
      // Handle platform-specific errors here
      print('Failed to enable Bluetooth: ${e.message}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                        transitionDuration: Duration(milliseconds: 250),
                        transitionsBuilder:
                            (context, animation, animationTime, child) {
                          return ScaleTransition(
                            alignment: Alignment.topCenter,
                            scale: animation,
                            child: child,
                          );
                        },
                        pageBuilder: (context, animation, animationTime) {
                          return ImagePage();
                        }));
              },
              child: Text('IMAGES'),
            ),
            SizedBox(height: 16), // Adjust the spacing between buttons
            ElevatedButton(
              onPressed: () {
                enableBluetooth();
              },
              child: Text('BLUTOOTH'),
            ),
            SizedBox(height: 16), // Adjust the spacing between buttons
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                        transitionDuration: Duration(milliseconds: 250),
                        transitionsBuilder:
                            (context, animation, animationTime, child) {
                          return ScaleTransition(
                            alignment: Alignment.topCenter,
                            scale: animation,
                            child: child,
                          );
                        },
                        pageBuilder: (context, animation, animationTime) {
                          return profile();
                        }));
              },
              child: Text('PROFILE'),
            ),
          ],
        ),
      ),
    );
  }
}

// class BluetoothChannel {
//   static const MethodChannel _channel = MethodChannel('bluetooth_channel');

//   static Future<void> enableBluetooth() async {
//     try {
//       await _channel.invokeMethod('enableBluetooth');
//     } catch (e) {
//       print('Failed to enable Bluetooth: $e');
//     }
//   }
// }
