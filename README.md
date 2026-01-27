O Projeto Assédio Sexual e Importunação Sexual em Ambientes acadêmicos: Um Estudo de caso investiga o assédio sexual no ambiente acadêmico, abordando-o como uma manifestação de abuso de poder e superioridade.

Pontos Principais
- Objetivo: Desenvolver ferramentas quantitativas para identificar indícios de assédio e importunação sexual em instituições de ensino.

- Metodologia: Pesquisa exploratória e descritiva envolvendo toda a comunidade acadêmica (alunos, professores, técnicos e terceirizados).

- Entregas: Criação de um questionário especializado e de um sistema computacional para análise estatística dos dados coletados.

- Técnicas Utilizadas: O trabalho fundamenta-se em psicometria e métodos estatísticos avançados (análise fatorial, de conglomerados e regressão linear).

Nota Importante: Para fins de demonstração/teste dos modelos, o repositório utiliza dados de segurança e criminalidade da Secretaria de Segurança de MG (link: https://www.seguranca.mg.gov.br/), uma vez que a base original do estudo acadêmico possui restrições de privacidade e não foi liberado em tempo hábil para aplicação.

Ao executar os modelos (arquivos com extensão R) no RStudio (link: https://www.r-project.org/), seguir as orientações:
- Modelo 'scriptfinal.R': base de dados: BD_VIOLENCIA_MG_2022-3.xlsx
- Modelo 'scriptfinal_com_interface.R': base de dados: BD_PROCESSADO_PARA_SHINY.csv
  
Durante a execução do 'scriptfinal.R', aplica-se Análise Fatorial e Clusterização para reduzir o número de variáveis e agrupar os registros em 3 categorias: 1 cidades com baixíssima criminalidade, 2 cidades com um nível médio de criminalidade, 3 cidades com alto nível de criminalidade. No final, nota-se a geração de um dataframe 'BD_PROCESSADO_PARA_SHINY.csv' que será usado em 'scriptfinal_com_interface.R'. 

