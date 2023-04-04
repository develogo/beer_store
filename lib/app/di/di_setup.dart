import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'di_setup.config.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt', // default
  preferRelativeImports: true,
  asExtension: false,
)
Future<void> configureDependencies({String env = Environment.dev}) async =>
    $initGetIt(getIt, environment: env);
