import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../routes.dart';

class ConfiguracoesScreen extends StatelessWidget {
  const ConfiguracoesScreen({super.key});

  Future<void> _redefinirTermos(BuildContext context) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Redefinir termos?'),
        content: const Text(
          'Isso fará o app exibir os Termos de Uso e LGPD novamente '
          'na próxima inicialização.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );
    if (ok == true && context.mounted) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('aceitouTermos', false);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Termos redefinidos. Reinicie o app.'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Configuracoes')),
      body: ListView(
        children: [
          const _SectionHeader(title: 'Privacidade'),
          ListTile(
            leading: const Icon(Icons.policy_outlined),
            title: const Text('Termos de Uso e LGPD'),
            subtitle: const Text('Rever os termos aceitos'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.pushNamed(context, AppRoutes.termos),
          ),
          ListTile(
            leading: const Icon(Icons.refresh),
            title: const Text('Redefinir aceite dos termos'),
            subtitle: const Text('Exibir tela de termos no próximo acesso'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _redefinirTermos(context),
          ),
          const Divider(),
          const _SectionHeader(title: 'Sobre'),
          const ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('Versão do aplicativo'),
            trailing: Text('1.0.0', style: TextStyle(color: Colors.grey)),
          ),
          const ListTile(
            leading: Icon(Icons.favorite_outline),
            title: Text('Ajuda Solidaria'),
            subtitle: Text('App de coordenacao de emergências'),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Text(
        title,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
