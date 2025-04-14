-- Criação das tabelas
CREATE TABLE Cliente (
    cliente_id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    tipo_cliente ENUM('PF', 'PJ') NOT NULL,
    documento VARCHAR(20) UNIQUE NOT NULL
);

CREATE TABLE Conta (
    conta_id INT PRIMARY KEY AUTO_INCREMENT,
    cliente_id INT,
    agencia VARCHAR(10),
    numero_conta VARCHAR(20) UNIQUE,
    FOREIGN KEY (cliente_id) REFERENCES Cliente(cliente_id)
);

CREATE TABLE Forma_de_Pagamento (
    pagamento_id INT PRIMARY KEY AUTO_INCREMENT,
    conta_id INT,
    tipo_pagamento VARCHAR(50),
    FOREIGN KEY (conta_id) REFERENCES Conta(conta_id)
);

CREATE TABLE Pedido (
    pedido_id INT PRIMARY KEY AUTO_INCREMENT,
    conta_id INT,
    data_pedido DATE,
    valor_total DECIMAL(10, 2),
    FOREIGN KEY (conta_id) REFERENCES Conta(conta_id)
);

CREATE TABLE Entrega (
    entrega_id INT PRIMARY KEY AUTO_INCREMENT,
    pedido_id INT,
    status VARCHAR(50),
    codigo_rastreio VARCHAR(100),
    FOREIGN KEY (pedido_id) REFERENCES Pedido(pedido_id)
);

CREATE TABLE Produto (
    produto_id INT PRIMARY KEY AUTO_INCREMENT,
    nome_produto VARCHAR(255) NOT NULL,
    descricao TEXT,
    preco DECIMAL(10, 2)
);

CREATE TABLE Fornecedor (
    fornecedor_id INT PRIMARY KEY AUTO_INCREMENT,
    nome_fornecedor VARCHAR(255) NOT NULL,
    documento_fornecedor VARCHAR(20) UNIQUE NOT NULL
);

CREATE TABLE Estoque (
    estoque_id INT PRIMARY KEY AUTO_INCREMENT,
    produto_id INT,
    quantidade INT,
    FOREIGN KEY (produto_id) REFERENCES Produto(produto_id)
);

CREATE TABLE Pedido_Produto (
    pedido_id INT,
    produto_id INT,
    quantidade INT,
    PRIMARY KEY (pedido_id, produto_id),
    FOREIGN KEY (pedido_id) REFERENCES Pedido(pedido_id),
    FOREIGN KEY (produto_id) REFERENCES Produto(produto_id)
);

CREATE TABLE Produto_Fornecedor (
    produto_id INT,
    fornecedor_id INT,
    PRIMARY KEY (produto_id, fornecedor_id),
    FOREIGN KEY (produto_id) REFERENCES Produto(produto_id),
    FOREIGN KEY (fornecedor_id) REFERENCES Fornecedor(fornecedor_id)
);

-- Inserção de dados para testes
INSERT INTO Cliente (nome, tipo_cliente, documento) VALUES ('João Silva', 'PF', '123.456.789-00');
INSERT INTO Conta (cliente_id, agencia, numero_conta) VALUES (1, '1234', '567890123');
INSERT INTO Forma_de_Pagamento (conta_id, tipo_pagamento) VALUES (1, 'Cartão de Crédito');
INSERT INTO Produto (nome_produto, descricao, preco) VALUES ('Produto A', 'Descrição do Produto A', 50.00);
INSERT INTO Fornecedor (nome_fornecedor, documento_fornecedor) VALUES ('Fornecedor A', '00.000.000/0001-00');
INSERT INTO Produto_Fornecedor (produto_id, fornecedor_id) VALUES (1, 1);
INSERT INTO Estoque (produto_id, quantidade) VALUES (1, 100);

-- Consultas de exemplo
SELECT COUNT(*) AS total_pedidos_por_cliente FROM Pedido GROUP BY conta_id;
SELECT p.nome_produto, f.nome_fornecedor FROM Produto p JOIN Produto_Fornecedor pf ON p.produto_id = pf.produto_id JOIN Fornecedor f ON pf.fornecedor_id = f.fornecedor_id;

-- Consultas complexas de exemplo
-- Quantos pedidos foram feitos por cada cliente?
SELECT c.nome, COUNT(p.pedido_id) AS total_pedidos
FROM Cliente c
LEFT JOIN Conta cnt ON c.cliente_id = cnt.cliente_id
LEFT JOIN Pedido p ON cnt.conta_id = p.conta_id
GROUP BY c.cliente_id;

--Relação de produtos e fornecedores
SELECT p.nome_produto, f.nome_fornecedor
FROM Produto p
JOIN Produto_Fornecedor pf ON p.produto_id = pf.produto_id
JOIN Fornecedor f ON pf.fornecedor_id = f.fornecedor_id;

--Estoque de produtos
SELECT p.nome_produto, e.quantidade
FROM Produto p
JOIN Estoque e ON p.produto_id = e.produto_id;
