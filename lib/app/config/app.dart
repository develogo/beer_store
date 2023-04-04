import 'package:device_frame/device_frame.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'routes/routers.dart';
import 'theme/app_colors.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Beer Store',
      routerConfig: router,
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
        iconTheme: const IconThemeData(color: AppColors.primaryColor),
      ),
      builder: (context, child) {
        if (!kIsWeb) {
          return child!;
        }
        return DeviceFrame(
          device: Devices.ios.iPhone13ProMax,
          isFrameVisible: true,
          orientation: Orientation.portrait,
          screen: Container(
            color: Colors.blue,
            child: child,
          ),
        );
      },
    );
  }
}
