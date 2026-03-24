import 'package:flutter/material.dart';
import '../app_state.dart';
import '../models/pedido.dart';

class PedirAjudaScreen extends StatefulWidget {
  const PedirAjudaScreen({super.key});

  @override
  State<PedirAjudaScreen> createState() => _PedirAjudaScreenState();
}

class _PedirAjudaScreenState extends State<PedirAjudaScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeCtrl = TextEditingController();
  final _telefoneCtrl = TextEditingController();
  final _bairroCtrl = TextEditingController();
  final _descricaoCtrl = TextEditingController();
  final _quantidadeCtrl = TextEditingController(text: '1');
  String? _tipoAjuda;
  bool _riscoSaude = false;

  static const _tiposAjuda = [
    'Alimentos e agua',
    'Abrigo',
    'Resgate',
    'Atendimento medico',
    'Limpeza / desentulhamento',
    'Apoio emocional',
    'Outros',
  ];

  @override
  void dispose() {
    _nomeCtrl.dispose();
    _telefoneCtrl.dispose();
    _bairroCtrl.dispose();
    _descricaoCtrl.dispose();
    _quantidadeCtrl.dispose();
    super.dispose();
  }

  void _enviar() {
    if (!_formKey.currentState!.validate()) return;
    final appState = AppStateProvider.of(context);
    appState.adicionarPedido(Pedido(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      nome: _nomeCtrl.text.trim(),
      telefone: _telefoneCtrl.text.trim(),
      bairro: _bairroCtrl.text.trim(),
      tipoAjuda: _tipoAjuda!,
      descricao: _descricaoCtrl.text.trim(),
      quantidadePessoas: int.parse(_quantidadeCtrl.text.trim()),
      riscoSaude: _riscoSaude,
    ));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Pedido registrado com sucesso!'),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pedir Ajuda')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red[50],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.red[200]!),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.red[700]),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Em risco imediato ligue 192 (SAMU) ou 193 (Bombeiros).',
                      style: TextStyle(color: Colors.red[800], fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _nomeCtrl,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'Nome completo *',
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
                labelText: 'Bairro *',
                prefixIcon: Icon(Icons.location_on_outlined),
              ),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Bairro e obrigatorio' : null,
            ),
            const SizedBox(height: 14),
            DropdownButtonFormField<String>(
              initialValue: _tipoAjuda,
              decoration: const InputDecoration(
                labelText: 'Tipo de ajuda *',
                prefixIcon: Icon(Icons.category_outlined),
              ),
              items: _tiposAjuda
                  .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                  .toList(),
              onChanged: (v) => setState(() => _tipoAjuda = v),
              validator: (v) =>
                  v == null ? 'Selecione o tipo de ajuda' : null,
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _descricaoCtrl,
              maxLines: 4,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                labelText: 'Descricao da situacao *',
                prefixIcon: Icon(Icons.description_outlined),
                alignLabelWithHint: true,
              ),
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Descricao e obrigatoria';
                if (v.trim().length < 15) return 'Minimo 15 caracteres';
                return null;
              },
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _quantidadeCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Pessoas afetadas *',
                prefixIcon: Icon(Icons.group_outlined),
              ),
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Campo obrigatorio';
                final n = int.tryParse(v.trim());
                if (n == null || n <= 0) return 'Informe um numero maior que 0';
                return null;
              },
            ),
            const SizedBox(height: 14),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[400]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: SwitchListTile(
                title: const Text('Risco a saude?'),
                subtitle: const Text('Sintomas / agua contaminada / ferimentos'),
                value: _riscoSaude,
                onChanged: (v) => setState(() => _riscoSaude = v),
                secondary: Icon(
                  Icons.medical_services_outlined,
                  color: _riscoSaude ? Colors.red : Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 28),
            FilledButton.icon(
              onPressed: _enviar,
              icon: const Icon(Icons.send),
              label: const Text('Enviar pedido'),
              style: FilledButton.styleFrom(
                backgroundColor: Colors.red[700],
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
