import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controllers/theme_controller.dart';
import 'controllers/translator_controller.dart';
import 'firebase_options.dart';
import 'screens/history_screen.dart';
import 'screens/translator_screen.dart';
import 'services/connectivity_service.dart';
import 'services/history_service.dart';
import 'services/translation_service.dart';
import 'theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint('Firebase init failed: $e');
  }
  runApp(const TranslatorApp());
}

class TranslatorApp extends StatelessWidget {
  const TranslatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<TranslationService>(create: (_) => TranslationService()),
        Provider<HistoryService>(create: (_) => HistoryService()),
        Provider<ConnectivityService>(create: (_) => ConnectivityService()),
        ChangeNotifierProvider<TranslatorController>(
          create: (ctx) => TranslatorController(
            translationService: ctx.read<TranslationService>(),
            historyService: ctx.read<HistoryService>(),
            connectivityService: ctx.read<ConnectivityService>(),
          ),
        ),
        ChangeNotifierProvider<ThemeController>(
          create: (_) => ThemeController(),
        ),
      ],
      child: Consumer<ThemeController>(
        builder: (context, themeController, _) {
          return MaterialApp(
            title: 'Translator App',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeController.isDark
                ? ThemeMode.dark
                : ThemeMode.light,
            home: const MyHomePage(title: 'Translator'),
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final themeController = context.watch<ThemeController>();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () => themeController.toggle(),
            icon: Icon(
              themeController.isDark ? Icons.light_mode : Icons.dark_mode,
            ),
            tooltip: themeController.isDark ? 'Light mode' : 'Dark mode',
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: const [
          TranslatorScreen(),
          HistoryScreen(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) => setState(() => _selectedIndex = index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.translate),
            label: 'Translate',
          ),
          NavigationDestination(
            icon: Icon(Icons.history),
            label: 'History',
          ),
        ],
      ),
    );
  }
}
