import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../routes.dart';

class TermosLgpdScreen extends StatelessWidget {
  const TermosLgpdScreen({super.key});

  Future<void> _aceitar(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('aceitouTermos', true);
    if (context.mounted) {
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Icon(Icons.shield_outlined, size: 48, color: theme.colorScheme.primary),
              const SizedBox(height: 12),
              Text(
                'Termos de Uso e LGPD',
                style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              Text(
                'Leia atentamente antes de continuar.',
                style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
              ),
              const SizedBox(height: 16),
              const Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [_Secao(
                        titulo: '1. Finalidade',
                        conteudo:
                            'O Ajuda Solidaria facilita a coordenacao de pedidos de socorro e ofertas de ajuda em '
                            'situacoes de emergencia e desastre. Os dados coletados sao utilizados exclusivamente '
                            'para esta finalidade.',
                      ),
                      _Secao(
                        titulo: '2. Minimizacao de dados (LGPD, art. 6)',
                        conteudo:
                            'Coletamos somente o estritamente necessario: nome, telefone, bairro e descricao da '
                            'necessidade ou oferta. Nao ha coleta automatica de localizacao, dados financeiros ou '
                            'informacoes sensiveis alem das informadas voluntariamente.',
                      ),
                      _Secao(
                        titulo: '3. Seus direitos',
                        conteudo:
                            'Voce pode consultar, corrigir, portar ou solicitar a eliminacao dos seus dados a '
                            'qualquer momento pelo e-mail: privacidade@ajudasolidaria.org',
                      ),
                      _Secao(
                        titulo: '4. Contato de emergencia (simulado)',
                        conteudo:
                            'Em risco imediato a vida ligue: 192 (SAMU) • 193 (Bombeiros) • 190 (Policia). '
                            'Este app NAO substitui os servicos de emergencia oficiais.',
                        destaque: true,
                      ),
                      _Secao(
                        titulo: '5. Armazenamento',
                        conteudo:
                            'Nesta versao os dados ficam armazenados localmente no dispositivo e nao sao '
                            'transmitidos a servidores externos. Ao desinstalar o app todos os dados sao removidos.',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () => _aceitar(context),
                  icon: const Icon(Icons.check_circle_outline),
                  label: const Text('Concordo e continuar'),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Secao extends StatelessWidget {
  final String titulo;
  final String conteudo;
  final bool destaque;

  const _Secao({
    required this.titulo,
    required this.conteudo,
    this.destaque = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: destaque ? const EdgeInsets.all(12) : EdgeInsets.zero,
      decoration: destaque
          ? BoxDecoration(
              color: Colors.red[50],
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.red[200]!),
            )
          : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titulo,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: destaque ? Colors.red[800] : theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            conteudo,
            style: theme.textTheme.bodyMedium?.copyWith(
              height: 1.6,
              color: destaque ? Colors.red[900] : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
