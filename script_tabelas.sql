
-- Criação da tabela dimensão Categoria
CREATE TABLE Dim_Categoria(

	ID_Categoria INT PRIMARY KEY,
	NomeCategoria VARCHAR(30) NOT NULL
);

-- Criação da tabela dimensão SubCategoria
CREATE TABLE Dim_SubCategoria(

	ID_SubCategoria INT PRIMARY KEY,
	NomeSubCategoria VARCHAR(30) NOT NULL,
	ID_Categoria INT,
	FOREIGN KEY (ID_Categoria) REFERENCES Dim_Categoria (ID_Categoria)
);

-- Criação da tabela dimensão Produto
CREATE TABLE Dim_Produto(

	ID_Produto INT PRIMARY KEY,
	NomeProduto VARCHAR(40) NOT NULL,
	Marca VARCHAR(30) NOT NULL,
	SKU VARCHAR(10) NOT NULL,
	ID_SubCategoria INT,
	FOREIGN KEY (ID_SubCategoria) REFERENCES Dim_SubCategoria (ID_SubCategoria)
);

-- Criação da tabela dimensão Variação Produto
CREATE TABLE Dim_VariacaoProduto(

	ID_VariacaoProduto INT PRIMARY KEY,
	TipoVariacao VARCHAR(30) NOT NULL,
	DescVariacao VARCHAR(35) NOT NULL,
	ID_Produto INT,
	FOREIGN KEY (ID_Produto) REFERENCES Dim_Produto (ID_Produto)
);

-- Criação da tabela dimensão Endereço
CREATE TABLE Dim_Endereco(

	ID_Endereco INT PRIMARY KEY,
	Cidade VARCHAR(40) NOT NULL,
	Estado VARCHAR(40) NOT NULL,
	Pais VARCHAR(40) NOT NULL,
	Regiao VARCHAR(40) NOT NULL
);

-- Criação da tabela dimensão Cliente
CREATE TABLE Dim_Cliente(

	ID_Cliente INT PRIMARY KEY,
	NomeCliente VARCHAR(60) NOT NULL,
	Email VARCHAR(50) NOT NULL,
	PrimeiraCompra TIMESTAMP NOT NULL,
	Canal VARCHAR(30) NOT NULL,
	TipoCliente VARCHAR(15) NOT NULL,
	ID_Endereco INT,
	FOREIGN KEY (ID_Endereco) REFERENCES Dim_Endereco (ID_Endereco)
);

-- Criação da tabela dimensão Vendedor
CREATE TABLE Dim_Vendedor(

	ID_Vendedor INT PRIMARY KEY,
	NomeVendedor VARCHAR(40) NOT NULL,
	NomeLoja VARCHAR(30) NOT NULL,
	TipoVendedor VARCHAR(30) NOT NULL,
	Ranking VARCHAR(20) NOT NULL
);

-- Criação da tabela dimensão Tempo
CREATE TABLE Dim_Tempo(

	ID_Tempo INT PRIMARY KEY,
	DataCompleta DATE NOT NULL,
	Ano INT NOT NULL,
	Mes INT NOT NULL,
	NomeMes VARCHAR(20),
	Dia INT NOT NULL,
	NomeDia VARCHAR(20) NOT NULL,
	FimSemana BOOLEAN NOT NULL,
	Turno VARCHAR(15)
);

-- Criação da tabela dimensão Pedido
CREATE TABLE Dim_Pedido(

	ID_Pedido INT PRIMARY KEY,
	Status VARCHAR(20) NOT NULL,
	TipoFrete VARCHAR(20) NOT NULL,
	Canal VARCHAR(30) NOT NULL
);

-- Criação da tabela dimensão Campanha
CREATE TABLE Dim_Campanha(

	ID_Campanha INT PRIMARY KEY,
	NomeCampanha VARCHAR(30) NOT NULL,
	TipoCampanha VARCHAR(20) NOT NULL,
	Canal VARCHAR(20) NOT NULL,
	InicioCampanha DATE NOT NULL,
	FimCampanha DATE NOT NULL,
	CustoCampanha DECIMAL(10,2) NOT NULL
);

-- Criação da tabela fato Vendas
CREATE TABLE FatoVendas (
    ID_Venda INT PRIMARY KEY,
    ID_Pedido INT,
    ID_Produto INT,
    ID_VariacaoProduto INT,
    ID_Cliente INT,
    ID_Vendedor INT,
    ID_Tempo INT,
    ID_Campanha INT,
    QuantidadeVendida INT,
    PrecoUnitario DECIMAL(10, 2),
    ValorDesconto DECIMAL(10, 2),
    -- Coluna calculada
    ValorTotalItem DECIMAL(10, 2) GENERATED ALWAYS AS (QuantidadeVendida * PrecoUnitario - ValorDesconto) STORED,
    CustoTotalItem DECIMAL(10, 2),
    MargemDeLucro DECIMAL(10, 2),

    FOREIGN KEY (ID_Pedido) REFERENCES Dim_Pedido(ID_Pedido),
    FOREIGN KEY (ID_Produto) REFERENCES Dim_Produto(ID_Produto),
    FOREIGN KEY (ID_VariacaoProduto) REFERENCES Dim_VariacaoProduto(ID_VariacaoProduto),
    FOREIGN KEY (ID_Cliente) REFERENCES Dim_Cliente(ID_Cliente),
    FOREIGN KEY (ID_Vendedor) REFERENCES Dim_Vendedor(ID_Vendedor),
    FOREIGN KEY (ID_Tempo) REFERENCES Dim_Tempo(ID_Tempo),
    FOREIGN KEY (ID_Campanha) REFERENCES Dim_Campanha(ID_Campanha)
);


