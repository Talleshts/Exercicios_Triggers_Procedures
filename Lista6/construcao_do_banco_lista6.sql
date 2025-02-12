CREATE TABLE paciente (
    idPaciente INT AUTO_INCREMENT,
    numeroSUS INT,
    idPai INT,
    idMae INT,
    PRIMARY KEY (idPaciente)
);

CREATE TABLE pessoa (
    idPessoa INT AUTO_INCREMENT,
    nome VARCHAR(100),
    genero CHAR(1),
    dtNasc DATE,
    numeroRG VARCHAR(20),
    orgaoRG VARCHAR(20),
    expRG DATE,
    numeroCPF VARCHAR(15),
    idEndereco INT,
    PRIMARY KEY (idPessoa),
    FOREIGN KEY (idEndereco) REFERENCES endereco(idEndereco)
);

CREATE TABLE cidade (
    idCidade INT AUTO_INCREMENT,
    nome VARCHAR(100),
    uf CHAR(2),
    PRIMARY KEY (idCidade)
);

CREATE TABLE endereco (
    idEndereco INT AUTO_INCREMENT,
    logradouro VARCHAR(100),
    bairro VARCHAR(30),
    numero INT,
    cep INT,
    complemento VARCHAR(100),
    latitude INT,
    longitude INT,
    idCidade INT,
    PRIMARY KEY (idEndereco),
    FOREIGN KEY (idCidade) REFERENCES cidade(idCidade)
);

CREATE TABLE profissionalsaudeespecialidade (
    idProfissionalSaude INT,
    idEspecialidade INT,
    anoObtencaoTitulo INT,
    FOREIGN KEY (idProfissionalSaude) REFERENCES profissionalsaude(idProfissionalSaude),
    FOREIGN KEY (idEspecialidade) REFERENCES especialidade(idEspecialidade)
);

CREATE TABLE profissionalsaude (
    idProfissionalSaude INT AUTO_INCREMENT,
    PRIMARY KEY (idProfissionalSaude)
);

CREATE TABLE consulta (
    idConsulta INT AUTO_INCREMENT,
    idPaciente INT,
    idProfissionalSaude INT,
    anamnese VARCHAR(100),
    dtConsulta DATE,
    hConsulta TIME,
    status CHAR(1),
    exameConcluido CHAR(1),
    PRIMARY KEY (idConsulta),
    FOREIGN KEY (idPaciente) REFERENCES paciente(idPaciente),
    FOREIGN KEY (idProfissionalSaude) REFERENCES profissionalsaude(idProfissionalSaude)
);

CREATE TABLE resultadoexame (
    idResultadoExame INT AUTO_INCREMENT,
    idPaciente INT,
    descricao VARCHAR(100),
    data DATE,
    arquivo BLOB,
    PRIMARY KEY (idResultadoExame),
    FOREIGN KEY (idPaciente) REFERENCES paciente(idPaciente)
);

CREATE TABLE ubs (
    idUBS INT AUTO_INCREMENT,
    nome VARCHAR(100),
    idEndereco INT,
    PRIMARY KEY (idUBS),
    FOREIGN KEY (idEndereco) REFERENCES endereco(idEndereco)
);

CREATE TABLE especialidade (
    idEspecialidade INT AUTO_INCREMENT,
    descricao VARCHAR(100),
    PRIMARY KEY (idEspecialidade)
);

CREATE TABLE contrato (
    idContrato INT AUTO_INCREMENT,
    titulo VARCHAR(20),
    descricao VARCHAR(100),
    idProfissionalSaude INT,
    idEspecialidade INT,
    idUBS INT,
    valorSalario DOUBLE,
    chDia INT,
    chSemanal INT,
    nConsultas INT,
    dtInicio DATE,
    dtFim DATE,
    PRIMARY KEY (idContrato),
    FOREIGN KEY (idProfissionalSaude) REFERENCES profissionalsaude(idProfissionalSaude),
    FOREIGN KEY (idEspecialidade) REFERENCES especialidade(idEspecialidade),
    FOREIGN KEY (idUBS) REFERENCES ubs(idUBS)
);

CREATE TABLE receita (
    idConsulta INT,
    numReceita INT AUTO_INCREMENT,
    descricao VARCHAR(100),
    arquivo BLOB,
    PRIMARY KEY (numReceita),
    FOREIGN KEY (idConsulta) REFERENCES consulta(idConsulta)
);

CREATE TABLE pedidoexame (
    idConsulta INT,
    numPedido INT AUTO_INCREMENT,
    descricao VARCHAR(100),
    arquivo BLOB,
    idResultadoExame INT,
    PRIMARY KEY (numPedido),
    FOREIGN KEY (idConsulta) REFERENCES consulta(idConsulta),
    FOREIGN KEY (idResultadoExame) REFERENCES resultadoexame(idResultadoExame)
);