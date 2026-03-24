import 'package:flutter/material.dart';
import '../routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajuda Solidaria'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      drawer: const _AppDrawer(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Como podemos ajudar?',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                'Selecione uma opcao abaixo',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.grey[600]),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  children: const [
                    _HomeCard(
                      titulo: 'Pedir Ajuda',
                      subtitulo: 'Registre um pedido de socorro',
                      icone: Icons.sos_rounded,
                      cor: Color(0xFFC62828),
                      rota: AppRoutes.pedirAjuda,
                    ),
                    _HomeCard(
                      titulo: 'Quero Ajudar',
                      subtitulo: 'Ofereca sua ajuda a comunidade',
                      icone: Icons.volunteer_activism,
                      cor: Color(0xFF2E7D32),
                      rota: AppRoutes.queroAjudar,
                    ),
                    _HomeCard(
                      titulo: 'Painel de Ocorrencias',
                      subtitulo: 'Veja os pedidos em aberto',
                      icone: Icons.dashboard_outlined,
                      cor: Color(0xFF1565C0),
                      rota: AppRoutes.painel,
                    ),
                    _HomeCard(
                      titulo: 'Configuracoes',
                      subtitulo: 'Preferencias do app',
                      icone: Icons.settings_outlined,
                      cor: Color(0xFF546E7A),
                      rota: AppRoutes.configuracoes,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HomeCard extends StatelessWidget {
  final String titulo;
  final String subtitulo;
  final IconData icone;
  final Color cor;
  final String rota;

  const _HomeCard({
    required this.titulo,
    required this.subtitulo,
    required this.icone,
    required this.cor,
    required this.rota,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => Navigator.pushNamed(context, rota),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: cor.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(icone, size: 36, color: cor),
              ),
              const SizedBox(height: 12),
              Text(
                titulo,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                subtitulo,
                style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AppDrawer extends StatelessWidget {
  const _AppDrawer();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Icon(Icons.favorite, color: Colors.white, size: 40),
                const SizedBox(height: 8),
                const Text(
                  'Ajuda Solidaria',
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  'v1.0.0',
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.75), fontSize: 13),
                ),
              ],
            ),
          ),
          _DrawerItem(
            icone: Icons.home_outlined,
            titulo: 'Inicio',
            onTap: () => Navigator.pop(context),
          ),
          _DrawerItem(
            icone: Icons.sos_rounded,
            titulo: 'Pedir Ajuda',
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, AppRoutes.pedirAjuda);
            },
          ),
          _DrawerItem(
            icone: Icons.volunteer_activism,
            titulo: 'Quero Ajudar',
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, AppRoutes.queroAjudar);
            },
          ),
          _DrawerItem(
            icone: Icons.dashboard_outlined,
            titulo: 'Painel de Ocorrencias',
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, AppRoutes.painel);
            },
          ),
          const Divider(),
          _DrawerItem(
            icone: Icons.settings_outlined,
            titulo: 'Configuracoes',
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, AppRoutes.configuracoes);
            },
          ),
        ],
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icone;
  final String titulo;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.icone,
    required this.titulo,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icone),
      title: Text(titulo),
      onTap: onTap,
    );
  }
}
