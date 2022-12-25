import 'package:flutter/material.dart';

import 'core/themes/theme_data.dart';
import 'features/user_repos/screens/repos_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Github repos',
      theme: ThemeConfig.themeFromSeed,
      home: const ReposScreen(),
    );
  }
}
