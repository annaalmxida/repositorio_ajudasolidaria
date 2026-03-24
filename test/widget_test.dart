import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ajuda_solidaria/main.dart';
import 'package:ajuda_solidaria/app_state.dart';

void main() {
  testWidgets('App inicia sem crash', (WidgetTester tester) async {
    await tester.pumpWidget(
      MyApp(aceitouTermos: false, appState: AppState()),
    );
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
