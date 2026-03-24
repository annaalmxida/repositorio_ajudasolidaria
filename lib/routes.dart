import 'package:flutter/material.dart';
import 'screens/termos_lgpd_screen.dart';
import 'screens/home_screen.dart';
import 'screens/pedir_ajuda_screen.dart';
import 'screens/quero_ajudar_screen.dart';
import 'screens/painel_ocorrencias_screen.dart';
import 'screens/detalhe_pedido_screen.dart';
import 'screens/configuracoes_screen.dart';

class AppRoutes {
  static const String termos = '/termos';
  static const String home = '/home';
  static const String pedirAjuda = '/pedir-ajuda';
  static const String queroAjudar = '/quero-ajudar';
  static const String painel = '/painel';
  static const String detalhe = '/detalhe';
  static const String configuracoes = '/configuracoes';

  static final Map<String, WidgetBuilder> staticRoutes = {
    termos: (_) => const TermosLgpdScreen(),
    home: (_) => const HomeScreen(),
    pedirAjuda: (_) => const PedirAjudaScreen(),
    queroAjudar: (_) => const QueroAjudarScreen(),
    painel: (_) => const PainelOcorrenciasScreen(),
    configuracoes: (_) => const ConfiguracoesScreen(),
  };

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    if (settings.name == detalhe) {
      final pedidoId = settings.arguments as String;
      return MaterialPageRoute(
        builder: (_) => DetalhePedidoScreen(pedidoId: pedidoId),
      );
    }
    return null;
  }
}