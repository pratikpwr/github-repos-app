import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/app.dart';
import 'src/core/app/bloc_providers.dart';
import 'src/core/app/injection_container.dart' as di;

void main() async {
  di.init();
  WidgetsFlutterBinding.ensureInitialized();

  final providers = getBlocProviders();
  runApp(
    providers.isNotEmpty
        ? MultiBlocProvider(
            providers: getBlocProviders(),
            child: const MyApp(),
          )
        : const MyApp(),
  );
}
