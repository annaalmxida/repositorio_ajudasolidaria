class OfertaAjuda {
  final String id;
  final String nome;
  final String telefone;
  final String bairroAtuacao;
  final List<String> habilidades;
  final String transporte;
  final bool disponivelAgora;
  final DateTime criadoEm;

  OfertaAjuda({
    required this.id,
    required this.nome,
    required this.telefone,
    required this.bairroAtuacao,
    required this.habilidades,
    required this.transporte,
    required this.disponivelAgora,
    DateTime? criadoEm,
  }) : criadoEm = criadoEm ?? DateTime.now();
}
