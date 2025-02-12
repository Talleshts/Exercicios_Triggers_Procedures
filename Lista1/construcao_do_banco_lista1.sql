CREATE TABLE aluno (
    idAluno INT AUTO_INCREMENT PRIMARY KEY,
    matricula INT,
    idCurso INT,
    genero VARCHAR(10),
    dtIngresso DATE,
    FOREIGN KEY (idCurso) REFERENCES curso(idCurso)
);

CREATE TABLE avaliacao (
    idTurma INT,
    idAluno INT,
    idAvaliacao INT AUTO_INCREMENT PRIMARY KEY,
    data DATE,
    nota DECIMAL(10,2),
    peso DECIMAL(10,2)
);

CREATE TABLE bibliografia (
    idBibliografia INT AUTO_INCREMENT PRIMARY KEY,
    descricao TEXT
);

CREATE TABLE cidade (
    idCidade INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    uf CHAR(2)
);

CREATE TABLE curso (
    idCurso INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    chObrigatoria INT,
    chOptativa INT,
    chTotal INT
);

CREATE TABLE departamento (
    idDepartamento INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100)
);

CREATE TABLE disciplina (
    idDisciplina INT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(10),
    nome VARCHAR(100),
    ch INT,
    ementa TEXT,
    programa TEXT
);

CREATE TABLE endereco (
    idEndereco INT AUTO_INCREMENT PRIMARY KEY,
    logradouro VARCHAR(100),
    numero INT,
    bairro VARCHAR(100),
    cep INT,
    idCidade INT,
    complemento VARCHAR(100),
    FOREIGN KEY (idCidade) REFERENCES cidade(idCidade)
);

CREATE TABLE gradecurricular (
    idCurso INT,
    idDisciplina INT,
    obrigatoria VARCHAR(3),
    PRIMARY KEY (idCurso, idDisciplina),
    FOREIGN KEY (idCurso) REFERENCES curso(idCurso),
    FOREIGN KEY (idDisciplina) REFERENCES disciplina(idDisciplina)
);

CREATE TABLE historico (
    idHistorico INT AUTO_INCREMENT PRIMARY KEY,
    idAluno INT,
    idCurso INT,
    idDisciplina INT,
    ano INT,
    semestre INT,
    situacao VARCHAR(20),
    ch INT,
    notaFinal DECIMAL(10,2),
    cr DECIMAL(10,2),
    FOREIGN KEY (idAluno) REFERENCES aluno(idAluno),
    FOREIGN KEY (idCurso) REFERENCES curso(idCurso),
    FOREIGN KEY (idDisciplina) REFERENCES disciplina(idDisciplina)
);

CREATE TABLE pessoa (
    idPessoa INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    idEndereco INT,
    genero VARCHAR(10),
    dtNascimento DATE,
    FOREIGN KEY (idEndereco) REFERENCES endereco(idEndereco)
);

CREATE TABLE professor (
    idProfessor INT AUTO_INCREMENT PRIMARY KEY,
    matricula INT,
    dtIngresso DATE,
    idDepartamento INT,
    FOREIGN KEY (idDepartamento) REFERENCES departamento(idDepartamento)
);

CREATE TABLE referencia (
    idReferencia INT AUTO_INCREMENT PRIMARY KEY,
    idBibliografia INT,
    basica VARCHAR(3),
    FOREIGN KEY (idBibliografia) REFERENCES bibliografia(idBibliografia)
);

CREATE TABLE turma (
    idTurma INT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(10),
    idCurso INT,
    idDisciplina INT,
    idProfessor INT,
    ano INT,
    semestre INT,
    nAlunos INT,
    nAvaliacoes INT,
    FOREIGN KEY (idCurso) REFERENCES curso(idCurso),
    FOREIGN KEY (idDisciplina) REFERENCES disciplina(idDisciplina),
    FOREIGN KEY (idProfessor) REFERENCES professor(idProfessor)
);