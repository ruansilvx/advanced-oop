// Exemplo de uma interface ruim
abstract class ImagemInternet {
  void baixar(String link);
  void comprimir();
  void salvar();
}

// Exemplo após aplicado o Princípio da Responsabilidade Única
abstract class ImagemRemoto {
  void baixar(String link);
}

abstract class ImagemCompresssao {
  void comprimir();
}

abstract class ImagemCache {
  void salvar();
}