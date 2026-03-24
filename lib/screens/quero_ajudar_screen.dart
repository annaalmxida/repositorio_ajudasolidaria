import 'package:flutter/material.dart';
import '../app_state.dart';
import '../models/oferta_ajuda.dart';

class QueroAjudarScreen extends StatefulWidget {
  const QueroAjudarScreen({super.key});

  @override
  State<QueroAjudarScreen> createState() => _QueroAjudarScreenState();
}

class _QueroAjudarScreenState extends State<QueroAjudarScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeCtrl = TextEditingController();
  final _telefoneCtrl = TextEditingController();
  final _bairroCtrl = TextEditingController();
  String? _transporte;
  bool _disponivelAgora = true;

  static const _habilidadesOpcoes = [
    'Primeiros socorros',
    'Transporte de pessoas',
    'Triagem',
    'Cozinha / alimentacao',
    'Limpeza e desentulhamento',
    'Apoio emocional / psicologico',
    'Gestao / coordenacao',
    'Comunicacao / divulgacao',
  ];

  static const _transporteOpcoes = [
    'A pe',
    'Carro',
    'Moto',
    'Caminhonete',
    'Barco',
  ];

  final Set<String> _habilidadesSelecionadas = {};

  @override
  void dispose() {
    _nomeCtrl.dispose();
    _telefoneCtrl.dispose();
    _bairroCtrl.dispose();
    super.dispose();
  }

  void _registrar() {
    if (!_formKey.currentState!.validate()) return;
    final appState = AppStateProvider.of(context);
    appState.adicionarOferta(OfertaAjuda(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      nome: _nomeCtrl.text.trim(),
      telefone: _telefoneCtrl.text.trim(),
      bairroAtuacao: _bairroCtrl.text.trim(),
      habilidades: _habilidadesSelecionadas.toList(),
      transporte: _transporte ?? 'A pe',
      disponivelAgora: _disponivelAgora,
    ));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Oferta de ajuda registrada! Obrigado!'),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quero Ajudar')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nomeCtrl,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'Seu nome *',
                prefixIcon: Icon(Icons.person_outline),
              ),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Nome e obrigatorio' : null,
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _telefoneCtrl,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Telefone *',
                prefixIcon: Icon(Icons.phone_outlined),
                hintText: '(00) 00000-0000',
              ),
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Telefone e obrigatorio';
                if (v.replaceAll(RegExp(r'\D'), '').length < 10) {
                  return 'Minimo 10 digitos';
                }
                return null;
              },
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _bairroCtrl,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'Bairro de atuacao *',
                prefixIcon: Icon(Icons.location_on_outlined),
              ),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Bairro e obrigatorio' : null,
            ),
            const SizedBox(height: 20),
            Text(
              'Habilidades',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[400]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: _habilidadesOpcoes.map((h) {
                  return CheckboxListTile(
                    title: Text(h, style: const TextStyle(fontSize: 14)),
                    value: _habilidadesSelecionadas.contains(h),
                    dense: true,
                    onChanged: (v) {
                      setState(() {
                        if (v == true) {
                          _habilidadesSelecionadas.add(h);
                        } else {
                          _habilidadesSelecionadas.remove(h);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 14),
            DropdownButtonFormField<String>(
              initialValue: _transporte,
              decoration: const InputDecoration(
                labelText: 'Meio de transporte',
                prefixIcon: Icon(Icons.directions_car_outlined),
              ),
              items: _transporteOpcoes
                  .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                  .toList(),
              onChanged: (v) => setState(() => _transporte = v),
            ),
            const SizedBox(height: 14),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[400]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: SwitchListTile(
                title: const Text('Disponivel agora?'),
                subtitle: const Text('Posso ajudar imediatamente'),
                value: _disponivelAgora,
                onChanged: (v) => setState(() => _disponivelAgora = v),
                secondary: Icon(
                  Icons.access_time,
                  color: _disponivelAgora ? Colors.green : Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 28),
            FilledButton.icon(
              onPressed: _registrar,
              icon: const Icon(Icons.volunteer_activism),
              label: const Text('Registrar oferta'),
              style: FilledButton.styleFrom(
                backgroundColor: Colors.green[700],
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
