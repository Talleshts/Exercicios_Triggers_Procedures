CREATE TABLE endereco( 
    idEndereco INT AUTO_INCREMENT PRIMARY KEY,
    cep INT,
    rua VARCHAR(255),
    numero INT,
    bairro VARCHAR(255),
    idCidade INT,
    FOREIGN KEY(idCidade) REFERENCES cidade(idCidade)
);

CREATE TABLE cidade(
    idCidade INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255),
    uf CHAR(2)
);

CREATE TABLE pessoa(
    idPessoa INT AUTO_INCREMENT PRIMARY KEY,
    cpf INT,
    nome VARCHAR(255),
    dtNascimento DATE,
    genero VARCHAR(10)
);

CREATE TABLE dependente(
    idFuncionario INT,
    idDependente INT AUTO_INCREMENT PRIMARY KEY,
    parentesco VARCHAR(255),
    FOREIGN KEY (idFuncionario) REFERENCES funcionario(idFuncionario)
);

CREATE TABLE funcionario(
    idFuncionario INT AUTO_INCREMENT PRIMARY KEY,
    idCargo INT,
    idEndereco INT,
    NIS INT,
    salario DECIMAL(10,2),
    idDepartamento INT,
    idSupervisor INT,
    FOREIGN KEY (idCargo) REFERENCES cargo(idCargo),
    FOREIGN KEY (idEndereco) REFERENCES endereco(idEndereco),
    FOREIGN KEY (idDepartamento) REFERENCES departamento(idDepartamento)
);

CREATE TABLE departamento(
    idDepartamento INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255),
    idGerente INT
);

CREATE TABLE cargo(
    idCargo INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255)
);

CREATE TABLE gerenciadepartamento(
    idGerente INT AUTO_INCREMENT PRIMARY KEY,
    idDepartamento INT,
    idFuncionario INT,
    dtInicioGerencia DATE,
    FOREIGN KEY(idDepartamento) REFERENCES departamento(idDepartamento),
    FOREIGN KEY(idFuncionario) REFERENCES funcionario(idFuncionario)
);

CREATE TABLE projetofuncionario(
    idProjeto INT,
    idFuncionario INT,
    chSemanal INT,
    FOREIGN KEY(idProjeto) REFERENCES projeto(idProjeto),
    FOREIGN KEY(idFuncionario) REFERENCES funcionario(idFuncionario)
);

CREATE TABLE projeto(
    idProjeto INT AUTO_INCREMENT PRIMARY KEY,
    numero INT,
    idLocalizacao INT,
    nome VARCHAR(255),
    FOREIGN KEY (idLocalizacao) REFERENCES localizacao(idLocalizacao)
);

CREATE TABLE localizacao(
    idLocalizacao INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(255),
    idDepartamento INT,
    FOREIGN KEY (idDepartamento) REFERENCES departamento(idDepartamento)
);