import 'package:flutter/material.dart';

import 'app/config/app.dart';
import 'app/di/di_setup.dart';

void main() {
  configureDependencies();
  runApp(const App());
}
