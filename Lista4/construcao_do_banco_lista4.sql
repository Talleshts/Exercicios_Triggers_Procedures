CREATE TABLE Categoria (
    CodCategoria INT NOT NULL AUTO_INCREMENT,
    Descricao VARCHAR(100),
    PRIMARY KEY (CodCategoria)
);

CREATE TABLE PesoAnimal (
    CodAnimal INT NOT NULL,
    Data DATE NOT NULL,
    Peso DOUBLE,
    PRIMARY KEY (CodAnimal, Data),
    FOREIGN KEY (CodAnimal) REFERENCES Animal(CodAnimal)
);

CREATE TABLE DespesaAnimal (
    CodAnimal INT NOT NULL,
    CodDespesa INT NOT NULL AUTO_INCREMENT,
    Valor DOUBLE,
    PRIMARY KEY (CodDespesa),
    FOREIGN KEY (CodAnimal) REFERENCES Animal(CodAnimal),
    FOREIGN KEY (CodDespesa) REFERENCES Despesa(CodDespesa)
);

CREATE TABLE ReceitaAnimal (
    CodAnimal INT NOT NULL,
    CodReceita INT NOT NULL AUTO_INCREMENT,
    Valor DOUBLE,
    PRIMARY KEY (CodReceita),
    FOREIGN KEY (CodAnimal) REFERENCES Animal(CodAnimal),
    FOREIGN KEY (CodReceita) REFERENCES Receita(CodReceita)
);

CREATE TABLE Receita (
    CodReceita INT NOT NULL AUTO_INCREMENT,
    Descricao VARCHAR(100),
    PRIMARY KEY (CodReceita)
);

CREATE TABLE Despesa (
    CodDespesa INT NOT NULL AUTO_INCREMENT,
    Descricao VARCHAR(100),
    PRIMARY KEY (CodDespesa)
);

CREATE TABLE Animal (
    CodAnimal INT NOT NULL AUTO_INCREMENT,
    CodCategoria INT NOT NULL,
    Nome VARCHAR(100),
    Sexo CHAR(1),
    DataNascimento DATE,
    DataCompra DATE,
    ValorCompra DOUBLE,
    DataVenda DATE,
    ValorVenda DOUBLE,
    DataObtito DATE,
    Status VARCHAR(10),
    PRIMARY KEY (CodAnimal),
    FOREIGN KEY (CodCategoria) REFERENCES Categoria(CodCategoria)
);

CREATE TABLE AnimalPrejuizo (
    CodAnimal INT NOT NULL,
    ValorDespesa DOUBLE,
    ValorVenda DOUBLE,
    Prejuizo DOUBLE,
    PRIMARY KEY (CodAnimal),
    FOREIGN KEY (CodAnimal) REFERENCES Animal(CodAnimal)
);

CREATE TABLE Paricao (
    CodAnimal INT NOT NULL,
    NumCria INT NOT NULL,
    DataCria DATE,
    CodTipoParto INT NOT NULL,
    PRIMARY KEY (CodAnimal, NumCria),
    FOREIGN KEY (CodAnimal) REFERENCES Animal(CodAnimal),
    FOREIGN KEY (CodTipoParto) REFERENCES TipoParto(CodTipoParto)
);

CREATE TABLE TipoParto (
    CodTipoParto INT NOT NULL AUTO_INCREMENT,
    Descricao VARCHAR(100),
    PRIMARY KEY (CodTipoParto)
);

CREATE TABLE ProducaoAnimal (
    CodAnimal INT NOT NULL,
    Data DATE NOT NULL,
    LitrosLeite FLOAT,
    Tipo CHAR(1),
    PRIMARY KEY (CodAnimal, Data),
    FOREIGN KEY (CodAnimal) REFERENCES Animal(CodAnimal)
);

CREATE TABLE ProducaoMedia (
    CodAnimal INT NOT NULL,
    Ano INT NOT NULL,
    LtMediaDiaria DOUBLE,
    PRIMARY KEY (CodAnimal, Ano),
    FOREIGN KEY (CodAnimal) REFERENCES Animal(CodAnimal)
);

CREATE TABLE Lactacao (
    CodAnimal INT NOT NULL,
    NumLactacao INT NOT NULL,
    DataInicio DATE,
    DataFim DATE,
    PRIMARY KEY (CodAnimal, NumLactacao),
    FOREIGN KEY (CodAnimal) REFERENCES Animal(CodAnimal)
);

CREATE TABLE Cobricao (
    CodAnimal INT NOT NULL,
    Data DATE NOT NULL,
    Observacoes TEXT,
    CodTipoCobricao INT NOT NULL,
    PRIMARY KEY (CodAnimal, Data),
    FOREIGN KEY (CodAnimal) REFERENCES Animal(CodAnimal),
    FOREIGN KEY (CodTipoCobricao) REFERENCES TipoCobricao(CodTipoCobricao)
);

CREATE TABLE TipoCobricao (
    CodTipoCobricao INT NOT NULL AUTO_INCREMENT,
    Descricao VARCHAR(100),
    PRIMARY KEY (CodTipoCobricao)
);

CREATE TABLE PrecoLeite (
    Ano INT NOT NULL,
    Mes INT NOT NULL,
    Tipo CHAR(1),
    Custo DOUBLE,
    Valor DOUBLE,
    PRIMARY KEY (Ano, Mes, Tipo)
);