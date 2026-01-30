# ⚖️ Assédio e Importunação Sexual em Ambientes Acadêmicos

Este projeto investiga o assédio sexual no ambiente acadêmico como uma manifestação de abuso de poder, utilizando ferramentas quantitativas e estatísticas avançadas para identificação de indícios e padrões.

---

## 🎯 Objetivo e Metodologia
O estudo visa desenvolver mecanismos para apoiar instituições de ensino na identificação de casos de assédio e importunação.

* **Metodologia:** Pesquisa exploratória e descritiva envolvendo alunos, professores, técnicos e terceirizados.
* **Entregas:** Questionário especializado e sistema computacional para análise estatística.
* **Técnicas Estatísticas:** Fundamentado em Psicometria, incluindo Análise Fatorial, Clusterização e Regressão Linear.

> [!NOTE]
> **Sobre os Dados:** Devido a restrições de privacidade da base acadêmica original, este repositório utiliza dados de segurança pública para fins de teste.
> <br>
> 🔗 Fonte dos dados: [Secretaria de Segurança de MG](https://www.seguranca.mg.gov.br/)

---

## 💻 Instruções de Execução

Para replicar as análises, você precisará do [RStudio](https://www.r-project.org/) instalado. Siga a ordem de execução abaixo:

### 1. Modelo: `scriptfinal.R`
Este script realiza o processamento dos dados, aplicando Análise Fatorial para reduzir variáveis e Clusterização para agrupar os registros.

* **Base de dados necessária:** `BD_VIOLENCIA_MG_2022-3.xlsx`
* **Saída:** Gera o dataframe `BD_PROCESSADO_PARA_SHINY.csv`.

<br>

### 2. Modelo: `scriptfinal_com_interface.R`
Este script carrega a interface visual para exploração dos resultados processados.

* **Base de dados necessária:** `BD_PROCESSADO_PARA_SHINY.csv`

---

## 📊 Fluxo de Análise e Categorias

O algoritmo reduz a dimensionalidade das variáveis e segmenta os registros em 3 grupos distintos:

1.  **Categoria 1:** Cidades com baixíssima criminalidade.
2.  **Categoria 2:** Cidades com nível médio de criminalidade.
3.  **Categoria 3:** Cidades com alto nível de criminalidade.

> [!IMPORTANT]
> **Configuração de Diretório:** Certifique-se de que os arquivos `.xlsx` e `.csv` estejam na mesma pasta onde você salvou os scripts `.R` para que a leitura dos dados ocorra sem erros.

---
**Desenvolvido como Estudo de Caso Acadêmico e Estatístico.**
