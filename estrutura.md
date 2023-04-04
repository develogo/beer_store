# Estrutura de pastas do projeto

A seguir é apresentada uma sugestão de estrutura de pastas para um projeto Flutter seguindo os princípios de Clean Architecture:

```
lib/
  common/
    localization/ # Arquivos de tradução do app
    models/       # Modelos de dados comuns
    widgets/      # Widgets comuns
  data/
    data_sources/ # Fontes de dados (APIs, Banco de Dados, etc.)
    models/       # Modelos de dados específicos da camada de dados
    repositories/ # Implementações dos repositórios
    utils/        # Funções utilitárias
  domain/
    entities/     # Entidades de domínio
    repositories/ # Interfaces dos repositórios
    usecases/     # Casos de uso (regras de negócio)
  presentation/
    pages/        # Telas da interface gráfica
    widgets/      # Widgets da interface gráfica
  app.dart        # Classe principal do aplicativo
  main.dart       # Ponto de entrada do aplicativo
  ```



A estrutura é organizada em camadas, onde a camada de apresentação (presentation) é separada das camadas de domínio (domain) e de dados (data). A camada de apresentação tem a responsabilidade de lidar com a interface gráfica do aplicativo, enquanto as camadas de domínio e de dados se preocupam com a lógica de negócio e a persistência de dados, respectivamente.

A pasta `common` contém arquivos, modelos e widgets que são compartilhados por todas as camadas do aplicativo. A pasta `data` é responsável por encapsular a lógica de acesso a dados, incluindo as fontes de dados (data_sources), modelos de dados específicos da camada de dados e as implementações dos repositórios. A pasta `domain` contém as entidades de domínio, as interfaces dos repositórios e os casos de uso (usecases). Por fim, a pasta `presentation` contém as telas e widgets da interface gráfica.

O arquivo `app.dart` é a classe principal do aplicativo, onde o tema, rotas e outros parâmetros são definidos. O arquivo `main.dart` é o ponto de entrada do aplicativo, onde a classe principal do aplicativo é iniciada.

Essa estrutura de pastas permite que o projeto seja organizado de forma clara e separada por responsabilidades, facilitando a manutenção e o desenvolvimento de novas funcionalidades.
