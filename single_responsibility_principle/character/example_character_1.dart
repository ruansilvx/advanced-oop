enum Peso {leve, medio, pesado}

abstract class Equipamento {
  final Peso peso;
  final int durabilidade;
  final int espacosItem;
  int itens;

  void diminuirDurabilidade();

  void guardarItem() {
    if(itens < espacosItem) {
      itens = itens + 1;
      print("Item guardado.");
    } else {
      print("Não há mais espaço!");
    }
  }

  void removerItem() {
    if(itens > 0) {
      itens = itens - 1;
      print("Item removido.");
    } else {
      print("Não há mais itens!");
    }
  }
}

class ArmaduraComum extends Equipamento {
  ArmaduraComum() : super(peso = Peso.medio, durabilidade = 10, espacosItem = 2);

  void diminuirDurabilidade() {
    if(durabilidade - 2 > 0) {
      this.durabilidade = this.durabilidade - 2;
    } else {
      this.durabilidade = 0;
      print("Equipamento danificado.")
    }
  }
}

class ArmaduraFerro extends Equipamento {
  ArmaduraFerro() : super(peso = Peso.pesado, durabilidade = 12, espacosItem = 1);

  void diminuirDurabilidade() {
    if(durabilidade - 3 > 0) {
      this.durabilidade = this.durabilidade - 3;
    } else {
      this.durabilidade = 0;
      print("Equipamento danificado.")
    }
  }
}

class ArmaduraCouro extends Equipamento {
  ArmaduraCouro() : super(peso = Peso.leve, durabilidade = 8, espacosItem = 3);

  void diminuirDurabilidade() {
    if(durabilidade - 1 > 0) {
      this.durabilidade = this.durabilidade - 1;
    } else {
      this.durabilidade = 0;
      print("Equipamento danificado.")
    }
  }
}

class Personagem {
  Equipamento equipamento = ArmaduraComum();

  void equipar(Equipamento equipamento) {
    this.equipamento = equipamento;
  }

  void movimentar(bool pular) {
    if(equipamento.durabilidade > 0) {
      if(pular) {
        switch(equipamento.peso) {
          case Peso.leve:
            print("Pulando alto.")
          break;
          case Peso.pesado:
            print("Pulando baixo")
          break;
          default:
            print("Pulando normalmente.")
        }
      } else {
        switch(equipamento.peso) {
          case Peso.leve:
            print("Andando rapidamente")
          break;
          case Peso.pesado:
            print("Andando lentamente.")
          break;
          default:
            print("Andando normalmente.")
        }
      }
    }  
  } else {
    print("Não é seguro se movimentar com uma armadura danificada!");
  }
}

void main() {
  Personagem personagem = Personagem()
  personagem.equipar(ArmaduraFerro());
  personagem.movimentar(pular = false);
  personagem.equipamento.guardarItem();
  personagem.movimentar(pular = true);
}