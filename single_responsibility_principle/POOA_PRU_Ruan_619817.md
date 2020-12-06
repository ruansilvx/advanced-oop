
<center>

### **<p style="text-align: center;">Universidade Federal de São Carlos</p>**
#### <p style="text-align: center;">Programação Orientada a Objetos Avançada</p>
<br />
<br />
</center>

# <p style="text-align: center;">Princípio da Responsabilidade Única</p>


**Por** Ruan Willer Silveira Xavier<br />
**Criado em** 22 de novembro de 2020
<br />
<br />

<div align="justify">

Os princípios [**SOLID**](https://sites.google.com/site/unclebobconsultingllc/getting-a-solid-start) 
foram introduzidos por Robert C. Martin (mais conhecido como _Uncle Bob_)
como um conjunto práticas a serem consideradas ao lidar com Programação Orientada a Objetos e design de código, visando um código conciso, consistente e escalável.
<br />
</div>

<div align="center">
<br />

<p align="center">
  <img src="https://cms-assets.tutsplus.com/uploads/users/30/posts/19098/preview_image/1-SRP-retina.png" />
</p>

<div align="justify">

### **O que é o Princípio da Responsabilidade única?**
O **Princípio da Responsabilidade única** (do inglês _Single Responsibility Principle_) é o primeiro 
princípio do SOLID. Ele define uma classe deve ter apenas uma responsabilidade, ou seja, apenas uma
razão para ser modificada, a fim de evitar conflitos.

### **O sentido de responsabilidade**

>[_"A class should have one, and only one, reason to change."_](https://drive.google.com/file/d/0ByOwmqah_nuGNHEtcU5OekdDMkk/view)   
>> Uma classe deve ter uma, e apenas uma, razão para mudar.

Nesse contexto, responsabilidade quer dizer uma razão ou motivo para mudar. A motivação para que uma classe realize alguma ação deve ser única. A classe deve ser especialista na responsabilidade a qual foi designada.  


### **Analisando o problema**
É comum durante o desenvolvimento surgirem classes que realizam várias ações, mesmo que elas não tenham qualquer correlação. O princípio defende que esse tipo de classe gera diversos problemas. O acoplamento nessas classes pode gerar conflitos entre as responsabilidades, cumprir uma responsabilidade poderia comprometer a realização de outra. Além disso, a classe  teria manutenção cara.
Qualquer modificação em uma das responsabilidades causaria reanálise e novos testes, mesmo que a mudança tenha sido em apenas uma parte dela.

Um exemplo dessa situação é a interface `ImagemInternet`. Ela define uma série de métodos para baixar e armazenar imagens da internet.

``` dart
// Exemplo de uma interface ruim
abstract class ImagemInternet {
  void baixar(String link);
  void comprimir();
  void salvar();
}
```
Embora os métodos sejam operações referentes ao objetivo da classe (baixar e armazenar imagens), eles deixam a classe com muitas responsabilidades. A primeira responsabilidade é o gerenciamento da conexão. A segunda é o processamento da imagem. A terceira é o gerenciamento de armazenamento local. 

Digamos que o algoritmo de compressão precise ser modificado. Além da complexidade da mudança, o acoplamento nos leva a testar e validar novamente toda a classe.

A solução para esse exemplo é a separação dessas responsabilidades.

``` dart
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
```
Dessa forma, o código é mais escalável (para qualquer nova responsabilidade não relacionada às já existentes, basta criar uma nova interface), mais simples, menos propenso a erros e facilita testes. 


### **Na prática**
Mais exemplo da aplicação do Princípio da Resposabilidade Única é o caso das classe `Personagem` e `Equipamento`. Um personagem possui um equipamento e pode se movimentar. Um equipamento possui peso, durabilidade e uma determinada quantidade de itens que pode guardar.

``` dart
enum Peso {leve, medio, pesado}

abstract class Equipamento {
  Equipamento(this.peso, this.durabilidade, this.espaçosItem);

  Peso peso;
  int durabilidade;
  int espacosItem;
  int itens = 0;

  void diminuirDurabilidade();
  void guardarItem();
  void removerItem();
}

class ArmaduraComum extends Equipamento {
  ArmaduraComum() : super(Peso.medio, 50, 3);
}

class Personagem {
  Equipamento equipamento = ArmaduraComum();

  void movimentar(bool pular);
}
```

Esse exemplo demonstra claras violações ao princípio. Primeiramente, a classe `Equipamento` possui mais responsabilidades do que deveria, possui métodos para manipulação da durabilidade e também gerencia armazenagem de itens. Além disso, o método `movimentar()` também possui responsabilidades demais, sendo responsável por andar e pular. O que mostra que o Princípio da Responsabilidade Única não se limita apenas a classes.

Agora, aplicando o princípio ao exemplo:
``` dart
enum Peso {leve, medio, pesado}

class Inventario {
  Inventario(this.espacosItem);

  int espacosItem;
  int itens = 0;

  void guardarItem();
  void removerItem();
}

abstract class Equipamento {
  Equipamento(this.peso, this.durabilidade);
  Peso peso;
  int durabilidade;

  void diminuirDurabilidade();
}

class ArmaduraComum extends Equipamento {
  ArmaduraComum() : super(Peso.medio, 50);
}

class Personagem {
  Equipamento equipamento = ArmaduraComum();
  Inventario inventario = Inventario(3);

  void andar();
  void pular();
}
```
É notável a diferença, visto que os equipamentos não lidam mais com itens. Essa responsabilidade foi movida para a nova classe `Inventario`. A função `movimentar()` também já não existe mais. Ela deu lugar a dois novos métodos `andar()` e `pular()`.

### **Concluindo**
O Princípio da Responsabilidade Única é um dos princípios SOLID mais simples de entender, mas também um dos mais difíceis de se aplicar corretamente. Nem sempre será possível desacoplar totalmente uma classe ou método. Além disso, a necessidade da aplicação do princípio nem sempre será óbvia. Entretanto, se aplicado corretamente, deixará o código mais limpo, resistente a inconsistências e mais testável.

### **Referências**
- [SOLID](https://en.wikipedia.org/wiki/SOLID)
- [Getting a SOLID start](https://sites.google.com/site/unclebobconsultingllc/getting-a-solid-start)
- [O que é SOLID: O guia completo para você entender os 5 princípios da POO](https://medium.com/desenvolvendo-com-paixao/o-que-%C3%A9-solid-o-guia-completo-para-voc%C3%AA-entender-os-5-princ%C3%ADpios-da-poo-2b937b3fc530)
- [SRP: The Single Responsibility Principle](https://drive.google.com/file/d/0ByOwmqah_nuGNHEtcU5OekdDMkk/view)
<br />
</div>



