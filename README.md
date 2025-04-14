# -Construindo-seu-Primeiro-Projeto-L-gico-de-Banco-de-Dados
# Projeto E-commerce - Banco de Dados

Este projeto apresenta um modelo lógico de banco de dados para um sistema de **e-commerce**, com foco no gerenciamento de **clientes**, **pedidos**, **pagamentos** e **entregas**. O objetivo é criar um esquema lógico completo e realizar consultas complexas para obter informações detalhadas sobre o funcionamento do sistema.

## Descrição do Projeto

Este banco de dados foi desenvolvido para um cenário de e-commerce, incluindo funcionalidades como:

- **Gestão de Clientes** (Pessoa Física ou Jurídica)
- **Pedidos** de compra
- **Pagamentos** realizados pelos clientes
- **Entregas** com status e código de rastreio
- **Relacionamento entre Produtos, Fornecedores e Estoque**

## Estrutura do Banco de Dados

O banco de dados é composto pelas seguintes tabelas:

- **Cliente**: Representa os clientes, podendo ser Pessoa Física (PF) ou Pessoa Jurídica (PJ).
- **Conta**: Cada cliente possui uma conta associada.
- **Forma de Pagamento**: Relaciona os métodos de pagamento disponíveis para o cliente.
- **Pedido**: Contém informações sobre os pedidos realizados pelos clientes.
- **Entrega**: Relacionada aos pedidos, contém o status e código de rastreio da entrega.
- **Produto**: Representa os produtos disponíveis no e-commerce.
- **Fornecedor**: Fornecedores dos produtos.
- **Estoque**: Controle de estoque dos produtos.
- **Pedido_Produto**: Relaciona produtos aos pedidos.
- **Produto_Fornecedor**: Relaciona produtos aos fornecedores.

## Scripts SQL

### 1. **Criação do Banco de Dados**
O arquivo `script_criacao_banco.sql` contém os comandos SQL para criar as tabelas e relacionamentos do banco de dados. Também inclui a inserção de dados para realizar testes.

### 2. **Consultas Complexas**
O mesmo arquivo SQL contém exemplos de **consultas complexas** que podem ser usadas para extrair informações do banco, como:

- Quantos pedidos foram feitos por cada cliente.
- Relação de produtos e fornecedores.
- Controle de estoque de produtos.

## Como Rodar o Projeto

1. **Pré-requisitos**:
   - Ter um **SGBD** (Sistema de Gerenciamento de Banco de Dados) como MySQL ou PostgreSQL instalado.
   - Acesso ao terminal ou uma interface gráfica de banco de dados.

2. **Passos**:
   1. Baixe ou clone este repositório.
   2. Abra o seu **SGBD**.
   3. Crie um novo banco de dados (ex: `ecommerce_db`).
   4. Execute o script `script_criacao_banco.sql` para criar as tabelas e inserir os dados de exemplo.
   5. Após a criação do banco, execute as consultas desejadas para testar a funcionalidade do banco de dados.

## Consultas SQL de Exemplo

As consultas no arquivo `script_criacao_banco.sql` incluem:

- **Quantos pedidos foram feitos por cada cliente?**
- **Relação de produtos e fornecedores**.
- **Controle de estoque dos produtos**.

Exemplo de consulta para contar os pedidos por cliente:

```sql
SELECT c.nome, COUNT(p.pedido_id) AS total_pedidos
FROM Cliente c
LEFT JOIN Conta cnt ON c.cliente_id = cnt.cliente_id
LEFT JOIN Pedido p ON cnt.conta_id = p.conta_id
GROUP BY c.cliente_id;
