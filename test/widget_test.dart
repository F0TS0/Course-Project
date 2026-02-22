import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:translator_app/theme/app_theme.dart';

void main() {
  testWidgets('MaterialApp with theme loads', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: Scaffold(
          body: NavigationBar(
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
        ),
      ),
    );

    expect(find.text('Translate'), findsOneWidget);
    expect(find.text('History'), findsOneWidget);
  });
}
