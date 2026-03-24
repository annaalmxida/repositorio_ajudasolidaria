import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_state.dart';
import 'routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final aceitouTermos = prefs.getBool('aceitouTermos') ?? false;
  final appState = AppState();
  runApp(MyApp(aceitouTermos: aceitouTermos, appState: appState));
}

class MyApp extends StatelessWidget {
  final bool aceitouTermos;
  final AppState appState;

  const MyApp({
    super.key,
    required this.aceitouTermos,
    required this.appState,
  });

  @override
  Widget build(BuildContext context) {
    final baseColorScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFFC93384),
      brightness: Brightness.light,
    );

    final customColorScheme = baseColorScheme.copyWith(
      primary: const Color(0xFFC93384),
      onPrimary: Colors.white,
      secondary: const Color(0xFFE44F9C),
      onSecondary: Colors.white,
      surface: Colors.white,
      background: const Color(0xFFFFFFFF),
      onBackground: Colors.black,
    );

    return AppStateProvider(
      state: appState,
      child: MaterialApp(
        title: 'Ajuda Solidaria',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: customColorScheme,
          useMaterial3: true,
          appBarTheme: AppBarTheme(
            centerTitle: true,
            elevation: 2,
            backgroundColor: customColorScheme.primary,
            foregroundColor: customColorScheme.onPrimary,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: customColorScheme.primary,
              foregroundColor: customColorScheme.onPrimary,
            ),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            border: OutlineInputBorder(),
          ),
          scaffoldBackgroundColor: customColorScheme.background,
        ),
        initialRoute: aceitouTermos ? AppRoutes.home : AppRoutes.termos,
        routes: AppRoutes.staticRoutes,
        onGenerateRoute: AppRoutes.generateRoute,
      ),
    );
  }
}