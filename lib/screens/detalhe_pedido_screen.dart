import 'package:flutter/material.dart';
import '../app_state.dart';

class DetalhePedidoScreen extends StatelessWidget {
  final String pedidoId;

  const DetalhePedidoScreen({super.key, required this.pedidoId});

  String _formatDate(DateTime dt) {
    final d = dt.day.toString().padLeft(2, '0');
    final m = dt.month.toString().padLeft(2, '0');
    final h = dt.hour.toString().padLeft(2, '0');
    final min = dt.minute.toString().padLeft(2, '0');
    return '$d/$m/${dt.year} as $h:$min';
  }

  @override
  Widget build(BuildContext context) {
    final appState = AppStateProvider.of(context);
    final idx = appState.pedidos.indexWhere((p) => p.id == pedidoId);

    if (idx == -1) {
      return Scaffold(
        appBar: AppBar(title: const Text('Detalhe')),
        body: const Center(child: Text('Pedido nao encontrado')),
      );
    }

    final pedido = appState.pedidos[idx];

    Color statusColor() {
      switch (pedido.status) {
        case 'em atendimento':
          return Colors.orange;
        case 'concluido':
          return Colors.green;
        default:
          return Colors.red;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhe do Pedido'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor().withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: statusColor().withValues(alpha: 0.5)),
              ),
              child: Text(
                pedido.status,
                style: TextStyle(
                  fontSize: 12,
                  color: statusColor(),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (pedido.riscoSaude)
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red[50],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.red[300]!),
              ),
              child: Row(
                children: [
                  Icon(Icons.medical_services, color: Colors.red[700]),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text(
                      'RISCO A SAUDE: Sintomas, agua contaminada ou ferimentos relatados.',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          Card(
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _InfoRow(
                    icone: Icons.category_outlined,
                    titulo: 'Tipo de ajuda',
                    valor: pedido.tipoAjuda,
                  ),
                  _InfoRow(
                    icone: Icons.person_outline,
                    titulo: 'Nome',
                    valor: pedido.nome,
                  ),
                  _InfoRow(
                    icone: Icons.phone_outlined,
                    titulo: 'Telefone',
                    valor: pedido.telefone,
                  ),
                  _InfoRow(
                    icone: Icons.location_on_outlined,
                    titulo: 'Bairro',
                    valor: pedido.bairro,
                  ),
                  _InfoRow(
                    icone: Icons.group_outlined,
                    titulo: 'Pessoas afetadas',
                    valor: '${pedido.quantidadePessoas}',
                  ),
                  _InfoRow(
                    icone: Icons.schedule,
                    titulo: 'Registrado em',
                    valor: _formatDate(pedido.criadoEm),
                    isLast: true,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          Card(
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.description_outlined, size: 18),
                      const SizedBox(width: 8),
                      Text(
                        'Descricao da situacao',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(pedido.descricao,
                      style: const TextStyle(height: 1.6, fontSize: 14)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          if (pedido.status == 'pendente')
            FilledButton.icon(
              onPressed: () =>
                  appState.atualizarStatus(pedidoId, 'em atendimento'),
              icon: const Icon(Icons.run_circle_outlined),
              label: const Text('Assumir atendimento'),
              style: FilledButton.styleFrom(
                backgroundColor: Colors.orange[700],
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(
                    fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
          if (pedido.status == 'em atendimento')
            FilledButton.icon(
              onPressed: () =>
                  appState.atualizarStatus(pedidoId, 'concluido'),
              icon: const Icon(Icons.check_circle_outline),
              label: const Text('Concluir atendimento'),
              style: FilledButton.styleFrom(
                backgroundColor: Colors.green[700],
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(
                    fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
          if (pedido.status == 'concluido')
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green[300]!),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle, color: Colors.green[700]),
                  const SizedBox(width: 10),
                  Text(
                    'Atendimento concluido',
                    style: TextStyle(
                      color: Colors.green[700],
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icone;
  final String titulo;
  final String valor;
  final bool isLast;

  const _InfoRow({
    required this.icone,
    required this.titulo,
    required this.valor,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icone, size: 18, color: Colors.grey[600]),
            const SizedBox(width: 10),
            Text(titulo,
                style: TextStyle(fontSize: 13, color: Colors.grey[600])),
            const Spacer(),
            Flexible(
              child: Text(
                valor,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
        if (!isLast) ...[
          const SizedBox(height: 8),
          Divider(height: 1, color: Colors.grey[200]),
          const SizedBox(height: 8),
        ],
      ],
    );
  }
}
