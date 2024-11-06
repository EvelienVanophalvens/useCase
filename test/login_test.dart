import 'package:demo/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'verify that the two input widgets are present on the login screen',
    (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home:Login()));

      var textfield = find.byType(TextFormField);

      expect(textfield, findsNWidgets(2));
    }
  );
}