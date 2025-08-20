# Modelagem Banco de Dados TechNova E-commerce
## Cenário 

A TechNova E-commerce, uma grande empresa de tecnologia, contratou um analista de dados, para resolver uma limitação crítica: a falta de insights estratégicos sobre suas operações de vendas e marketing. A empresa precisava de um sistema que fosse além dos relatórios básicos de faturamento para responder a perguntas cruciais, como "Quais campanhas de marketing geram mais lucro?" e "Qual a performance de vendas de produtos específicos em diferentes regiões?".

O objetivo do projeto é construir um Data Warehouse usando a modelagem StarFlake-Schema, combinando os dois modelos de esquema para solucionar o problema da empresa. A estrutura permitirá à TechNova transformar dados operacionais em informações acionáveis, auxiliando a tomada de decisões de negócios.

## Componentes da modelagem
### Tabela de Fatos(FatosVenda)

É a tabela central e a maior do modelo. Ela armazena as métricas e eventos do negócio que precisam ser analisados. No nosso caso, cada linha na FatoVendas representa a venda de um único item.

Os atributos são majoritariamente valores numéricos (QuantidadeVendida, ValorTotalItem, MargemDeLucro) que podem ser agregados (somados, calculados a média, etc.).

Ela também contém chaves estrangeiras (FKs) que servem como "pontes", conectando-se às chaves primárias das tabelas de dimensão.

### Tabelas de Dimensão(Dim...)

São tabelas menores que contêm o contexto para a análise dos fatos. Elas fornecem as "lentes" pelas quais os dados da tabela de fatos podem ser vistos.

Cada dimensão representa uma entidade de negócio (cliente, produto, tempo, etc.) e contém atributos **descritivos** (NomeCliente, Marca, NomeDoMes) que são usados para filtrar e agrupar os dados nas análises.

A modelagem utiliza relacionamentos de um para muitos (1:N), onde uma linha em uma tabela de dimensão corresponde a várias linhas na tabela de fatos.

### Funcionamento da Estrutura

**Para Análise Rápida:** O Star-Schema é otimizado para consultas analíticas complexas. A sua estrutura simples de JOINs (entre a tabela de fatos e as dimensões) permite que as ferramentas de BI e SQL executem consultas de forma extremamente eficiente, mesmo em grandes volumes de dados.

**Hierarquia Snowflake:** Para evitar a redundância de dados e melhorar a organização, algumas dimensões (como as de produto e endereço) foram modeladas como um esquema Snowflake. Isso significa que uma dimensão se "ramifica" para outra. Por exemplo, a DimProduto se liga à DimSubcategoria, que por sua vez se liga à DimCategoria. Essa hierarquia permite uma análise granular, indo do nível mais alto (categoria) ao nível mais baixo (produto e variação).

A combinação da simplicidade do Star-Schema com a organização hierárquica do Snowflake fornece um modelo de dados robusto e escalável, capaz de fornecer à TechNova os insights estratégicos necessários para otimizar suas operações.

### Dicionário de Dados





