class Pedido {
  final String id;
  final String nome;
  final String telefone;
  final String bairro;
  final String tipoAjuda;
  final String descricao;
  final int quantidadePessoas;
  final bool riscoSaude;
  String status;
  final DateTime criadoEm;

  Pedido({
    required this.id,
    required this.nome,
    required this.telefone,
    required this.bairro,
    required this.tipoAjuda,
    required this.descricao,
    required this.quantidadePessoas,
    required this.riscoSaude,
    this.status = 'pendente',
    DateTime? criadoEm,
  }) : criadoEm = criadoEm ?? DateTime.now();
}
