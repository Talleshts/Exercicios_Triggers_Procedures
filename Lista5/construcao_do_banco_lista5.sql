CREATE TABLE cliente (
    idCliente INT NOT NULL AUTO_INCREMENT,
    avaliacaoCliente CHAR(1),
    PRIMARY KEY (idCliente)
);

CREATE TABLE pessoa (
    idPessoa INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(100),
    telFixo VARCHAR(100),
    telCelular VARCHAR(100),
    email VARCHAR(100),
    cpf VARCHAR(11),
    rg VARCHAR(15),
    idEndereco INT,
    PRIMARY KEY (idPessoa),
    FOREIGN KEY (idEndereco) REFERENCES endereco(idEndereco)
);

CREATE TABLE cidade (
    idCidade INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(100),
    uf CHAR(2),
    PRIMARY KEY (idCidade)
);

CREATE TABLE endereco (
    idEndereco INT NOT NULL AUTO_INCREMENT,
    logradouro VARCHAR(100),
    numero INT,
    complemento VARCHAR(50),
    bairro VARCHAR(30),
    cep CHAR(10),
    idCidade INT,
    PRIMARY KEY (idEndereco),
    FOREIGN KEY (idCidade) REFERENCES cidade(idCidade)
);

CREATE TABLE agendamento (
    idAgendamento INT NOT NULL AUTO_INCREMENT,
    idStatus INT,
    idTrabalhador INT,
    idCliente INT,
    data DATE,
    hora TIME,
    avaliacaoCliente CHAR(1),
    valorTotal DOUBLE,
    PRIMARY KEY (idAgendamento),
    FOREIGN KEY (idStatus) REFERENCES status(idStatus),
    FOREIGN KEY (idTrabalhador) REFERENCES trabalhador(idTrabalhador),
    FOREIGN KEY (idCliente) REFERENCES cliente(idCliente)
);

CREATE TABLE trabalhador (
    idTrabalhador INT NOT NULL AUTO_INCREMENT,
    PRIMARY KEY (idTrabalhador)
);

CREATE TABLE categoriatrabalhador (
    idTrabalhador INT,
    idCategoria INT,
    PRIMARY KEY (idTrabalhador, idCategoria),
    FOREIGN KEY (idTrabalhador) REFERENCES trabalhador(idTrabalhador),
    FOREIGN KEY (idCategoria) REFERENCES categoria(idCategoria)
);

CREATE TABLE horaextra (
    idTrabalhador INT,
    data DATETIME NOT NULL,
    tempoExtra INT,
    PRIMARY KEY (idTrabalhador, data),
    FOREIGN KEY (idTrabalhador) REFERENCES trabalhador(idTrabalhador)
);

CREATE TABLE categoria (
    idCategoria INT NOT NULL AUTO_INCREMENT,
    descricao VARCHAR(100),
    PRIMARY KEY (idCategoria)
);

CREATE TABLE status (
    idStatus INT NOT NULL AUTO_INCREMENT,
    descricao VARCHAR(100),
    PRIMARY KEY (idStatus)
);

CREATE TABLE agendamentoservico (
    idAgendamento INT,
    idServico INT,
    tempoExecucao INT,
    valorServico DOUBLE,
    PRIMARY KEY (idAgendamento, idServico),
    FOREIGN KEY (idAgendamento) REFERENCES agendamento(idAgendamento),
    FOREIGN KEY (idServico) REFERENCES servico(idServico)
);

CREATE TABLE servico (
    idServico INT NOT NULL AUTO_INCREMENT,
    descricao VARCHAR(100),
    tempoMedioExecucao INT,
    idCategoria INT,
    PRIMARY KEY (idServico),
    FOREIGN KEY (idCategoria) REFERENCES categoria(idCategoria)
);

CREATE TABLE custocategoria (
    idCategoria INT,
    ano INT,
    valor DOUBLE,
    PRIMARY KEY (idCategoria, ano),
    FOREIGN KEY (idCategoria) REFERENCES categoria(idCategoria)
);