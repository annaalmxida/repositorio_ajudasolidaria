import 'package:flutter/widgets.dart';
import 'models/pedido.dart';
import 'models/oferta_ajuda.dart';

class AppState extends ChangeNotifier {
  final List<Pedido> pedidos = [];
  final List<OfertaAjuda> ofertas = [];

  void adicionarPedido(Pedido pedido) {
    pedidos.add(pedido);
    notifyListeners();
  }

  void adicionarOferta(OfertaAjuda oferta) {
    ofertas.add(oferta);
    notifyListeners();
  }

  void atualizarStatus(String id, String novoStatus) {
    final idx = pedidos.indexWhere((p) => p.id == id);
    if (idx != -1) {
      pedidos[idx].status = novoStatus;
      notifyListeners();
    }
  }
}

class AppStateProvider extends InheritedNotifier<AppState> {
  const AppStateProvider({
    super.key,
    required AppState state,
    required super.child,
  }) : super(notifier: state);

  static AppState of(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<AppStateProvider>();
    assert(provider != null, 'AppStateProvider nao encontrado no contexto');
    return provider!.notifier!;
  }
}
