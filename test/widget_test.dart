import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:tienda_regalos/features/cart/cart_provider.dart';
import 'package:tienda_regalos/features/favorites/favorites_provider.dart';
import 'package:tienda_regalos/main.dart';

void main() {
  testWidgets('flujo de compra desde inicio hasta confirmación', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CartProvider()),
          ChangeNotifierProvider(create: (_) => FavoritesProvider()),
        ],
        child: const TiendaRegalosApp(),
      ),
    );

    expect(find.text('Detalles que cuentan historias'), findsOneWidget);
    await tester.tap(find.text('COMENZAR'));
    await tester.pumpAndSettle();
    expect(find.text('Explora por categoría'), findsOneWidget);

    await tester.ensureVisible(find.text('Ramo Primavera'));
    await tester.tap(find.text('Ramo Primavera'));
    await tester.pumpAndSettle();
    expect(find.text('Dedicatoria:'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField).first, 'Alex');
    await tester.tap(find.text('Continuar'));
    await tester.pumpAndSettle();
    expect(find.text('Para: Alex'), findsOneWidget);
    expect(find.text('Total:'), findsOneWidget);

    await tester.tap(find.text('Finalizar pedido'));
    await tester.pumpAndSettle();
    expect(find.text('PEDIDO LISTO'), findsOneWidget);
    expect(find.text('FOLIO 00000000'), findsOneWidget);
  });
}
