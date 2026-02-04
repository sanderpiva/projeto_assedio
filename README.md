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

## 📊 Análise Fatorial

A Análise Fatorial reduz a dimensionalidade das variáveis/colunas observando padrões, características em comum.
   
<br><br><br>

<p align="left">
  <img src="https://github.com/user-attachments/assets/8a4dff1e-ab7e-4a76-baa4-3dffe91fa02e" alt="Análise Fatorial 1" width="100%">
  <br>
  <b>foto 1:</b> Análise Fatorial considerando todas as variáveis
</p><br><br>

---

<p align="left">
  <img src="https://github.com/user-attachments/assets/1d58d312-00b9-4720-9e22-56c95ef79bbb" alt="Análise Fatorial 2" width="100%">
  <br>
  <b>foto 2:</b> Análise Fatorial considerando todas as variáveis, menos a variável alvo X14 Furto
</p><br><br>

---
## 📊 Clusterização

O algoritmo de clusterização reduz a dimensionalidade dos registros, segmentando-os em 3 grupos genéricos distintos:

1.  **Categoria 1:** Cidades com baixa criminalidade (Estável).
2.  **Categoria 2:** Cidades com alto nível de criminalidade (Crítica/Metrópole).
3.  **Categoria 3:** Cidades com baixa criminalidade, mas com vulnerabilidade (Vulnerabilidade Moderada).
4.  **Scores da Análise Fatorial:** São os dois indices.
5.  **X14_Furto:** É a variável alvo.
6.  **Perfil_cidade:** Coluna com as categorias citadas: 1, 2 e 3
7.  **Categoria_cidade:** São os rótulos determinados para as categorias: 1, 2 e 3
<br><br>

<p align="left">
  <img src="https://github.com/user-attachments/assets/6216338b-4e5f-4496-82ad-6b1bd241c2fc" alt="Dataframe parcial" width="100%">
  <br>
  <b>foto 3:</b> Dataframe parcial
</p><br><br>

---

<p align="left">
  <img src="https://github.com/user-attachments/assets/ce5d0283-d341-409d-9342-fc8081f6c463" alt="Dataframe final" width="100%">
  <br>
  <b>foto 4:</b> Dataframe final
</p><br><br>


### 2. Modelo: `scriptfinal_com_interface.R`
Este script, após a obtenção do dataframe final, fornece a interface visual para exploração dos resultados processados.

* **Base de dados necessária:** `BD_PROCESSADO_PARA_SHINY.csv`

---

### 📊 Utilizou-se o pacote shiny (R) para criar a interface. Veja prints:
<br>
<p align="left">
  <img src="https://github.com/user-attachments/assets/7efb6d47-5723-4fb2-8229-eb4951e6947f" alt="Análise Fatorial Completa" width="100%">
  <br>
  <b>Foto 1:</b> Interface do sistema.
</p><br><br>

---

<p align="left">
  <img src="https://github.com/user-attachments/assets/677c90d5-18d4-4dd6-a52d-82a7c28ee099" alt="Análise Fatorial Sem Alvo" width="100%">
  <br>
  <b>Foto 2:</b> Interface com a base de dados carregada.
</p><br><br>

---

<p align="left">
  <img src="https://github.com/user-attachments/assets/6f2ec6e4-dd76-47a6-b8e5-83090deb2c1f" alt="Dataframe Parcial" width="100%">
  <br>
  <b>Foto 3:</b> Resumo estatístico do modelo com R² de 0.97..
</p><br><br>

---

<p align="left">
  <img src="https://github.com/user-attachments/assets/0a4b6047-b2e2-4192-b631-a7f6b42e817d" alt="Dataframe Final" width="100%">
  <br>
  <b>Foto 4:</b> Gráfico ilustrativo Real vs. Previsto.
</p><br><br>

> [!IMPORTANT]
> **Configuração de Diretório:** Certifique-se de que os arquivos `.xlsx` e `.csv` estejam na mesma pasta onde você salvou os scripts `.R` para que a leitura dos dados ocorra sem erros.

---
**Desenvolvido como Estudo de Caso Acadêmico e Estatístico.**
