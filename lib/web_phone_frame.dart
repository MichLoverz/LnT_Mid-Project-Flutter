import 'package:device_frame/device_frame.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

/// On web with a wide viewport (desktop browser), renders [child] inside a
/// phone bezel so the app looks like it is running on a device.
/// On mobile builds, or on narrow viewports (phone browser), [child] is
/// shown as-is so it fills the screen normally.
class WebPhoneFrame extends StatelessWidget {
  const WebPhoneFrame({super.key, required this.child});

  final Widget child;

  static const _frameBreakpoint = 600.0;

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) return child;

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < _frameBreakpoint) return child;

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            backgroundColor: const Color(0xFF1E1E24),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: DeviceFrame(
                  device: Devices.android.samsungGalaxyS20,
                  screen: child,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
