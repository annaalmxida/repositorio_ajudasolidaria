import 'package:flutter/material.dart';
import '../app_state.dart';
import '../models/pedido.dart';
import '../routes.dart';

class PainelOcorrenciasScreen extends StatelessWidget {
  const PainelOcorrenciasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = AppStateProvider.of(context);
    final pedidos = List<Pedido>.from(appState.pedidos.reversed);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Painel de Ocorrencias'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Chip(
              label: Text('${pedidos.length}'),
              avatar: const Icon(Icons.list_alt, size: 16),
              backgroundColor:
                  Theme.of(context).colorScheme.primaryContainer,
            ),
          ),
        ],
      ),
      body: pedidos.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.inbox_outlined, size: 72, color: Colors.grey[300]),
                  const SizedBox(height: 16),
                  Text(
                    'Nenhuma ocorrencia registrada',
                    style: TextStyle(color: Colors.grey[600], fontSize: 16),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Os pedidos de ajuda aparecerao aqui',
                    style: TextStyle(color: Colors.grey[400], fontSize: 13),
                  ),
                ],
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: pedidos.length,
              separatorBuilder: (_, __) => const SizedBox(height: 6),
              itemBuilder: (context, index) =>
                  _PedidoCard(pedido: pedidos[index]),
            ),
    );
  }
}

class _PedidoCard extends StatelessWidget {
  final Pedido pedido;

  const _PedidoCard({required this.pedido});

  Color get _statusColor {
    switch (pedido.status) {
      case 'em atendimento':
        return Colors.orange;
      case 'concluido':
        return Colors.green;
      default:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () =>
            Navigator.pushNamed(context, AppRoutes.detalhe, arguments: pedido.id),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: pedido.riscoSaude ? Colors.red[50] : Colors.blue[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  pedido.riscoSaude
                      ? Icons.medical_services
                      : Icons.help_outline,
                  color: pedido.riscoSaude ? Colors.red[700] : Colors.blue[700],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${pedido.tipoAjuda} — ${pedido.bairro}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (pedido.riscoSaude)
                          Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: Icon(
                              Icons.warning_amber_rounded,
                              size: 16,
                              color: Colors.red[700],
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      pedido.descricao,
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        _StatusBadge(
                            status: pedido.status, color: _statusColor),
                        const SizedBox(width: 8),
                        Icon(Icons.group_outlined,
                            size: 14, color: Colors.grey[500]),
                        const SizedBox(width: 3),
                        Text(
                          '${pedido.quantidadePessoas} pessoa${pedido.quantidadePessoas > 1 ? 's' : ''}',
                          style:
                              TextStyle(fontSize: 11, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String status;
  final Color color;

  const _StatusBadge({required this.status, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 11,
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
