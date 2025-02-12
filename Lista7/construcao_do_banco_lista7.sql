CREATE TABLE pessoa (
    idPessoa INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(100),
    dataNascimento DATE,
    sexo CHAR(1),
    PRIMARY KEY(idPessoa)
);

CREATE TABLE aluno (
    idAluno INT NOT NULL AUTO_INCREMENT,
    matricula INT, 
    anoIngresso INT,
    PRIMARY KEY(idAluno)
);

CREATE TABLE monitoria (
    idMonitoria INT NOT NULL AUTO_INCREMENT,
    descricao VARCHAR(100),
    idDisciplina INT,
    idProfessor INT,
    oficial CHAR(1),
    idAnterior INT,
    dataInicio DATE,
    dataTermino DATE,
    PRIMARY KEY(idMonitoria),
    FOREIGN KEY(idDisciplina) REFERENCES disciplina(idDisciplina),
    FOREIGN KEY(idProfessor) REFERENCES professor(idProfessor)
);

CREATE TABLE monitor (
    idMonitoria INT NOT NULL,
    idAluno INT NOT NULL,
    dataInicio DATE,
    dataTermino DATE,
    PRIMARY KEY(idMonitoria, idAluno),
    FOREIGN KEY(idAluno) REFERENCES aluno(idAluno),
    FOREIGN KEY(idMonitoria) REFERENCES monitoria(idMonitoria)
);

CREATE TABLE professor (
    idProfessor INT NOT NULL AUTO_INCREMENT,
    dataAdmissao INT,
    PRIMARY KEY(idProfessor)
);

CREATE TABLE disciplina (
    idDisciplina INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(100),
    ch INT,
    PRIMARY KEY(idDisciplina)
);

CREATE TABLE selecao (
    idSelecao INT NOT NULL AUTO_INCREMENT,
    idMonitoria INT,
    inicioInscricao DATE,
    fimInscricao DATE,
    dataAvaliacao DATE,
    horaAvaliacao TIME,
    numInscritos INT,
    PRIMARY KEY(idSelecao),
    FOREIGN KEY(idMonitoria) REFERENCES monitoria(idMonitoria)
);

CREATE TABLE inscricao (
    idSelecao INT NOT NULL,
    idAluno INT NOT NULL,
    numInscricao INT,
    notaDisciplina DOUBLE,
    cr DOUBLE,
    notaAvaliacao DOUBLE,
    notaFinal DOUBLE,
    classificacao INT,
    PRIMARY KEY(idSelecao, idAluno),
    FOREIGN KEY(idSelecao) REFERENCES selecao(idSelecao),
    FOREIGN KEY(idAluno) REFERENCES aluno(idAluno)
);

CREATE TABLE bolsa (
    idMonitoria INT NOT NULL,
    numParcela INT NOT NULL,
    valor DOUBLE,
    mesReferencia INT,
    anoReferencia INT,
    PRIMARY KEY(idMonitoria, numParcela),
    FOREIGN KEY(idMonitoria) REFERENCES monitoria(idMonitoria)
);

CREATE TABLE gabarito (
    idSelecao INT NOT NULL,
    idAluno INT NOT NULL,
    idQuestao INT NOT NULL,
    opcao CHAR(1),
    PRIMARY KEY(idSelecao, idAluno, idQuestao),
    FOREIGN KEY(idSelecao) REFERENCES selecao(idSelecao),
    FOREIGN KEY(idAluno) REFERENCES aluno(idAluno),
    FOREIGN KEY(idQuestao) REFERENCES questao(idQuestao)
);

CREATE TABLE avaliacao (
    idSelecao INT NOT NULL,
    idQuestao INT NOT NULL,
    PRIMARY KEY(idSelecao, idQuestao),
    FOREIGN KEY(idSelecao) REFERENCES selecao(idSelecao),
    FOREIGN KEY(idQuestao) REFERENCES questao(idQuestao)
);

CREATE TABLE questao (
    idQuestao INT NOT NULL AUTO_INCREMENT,
    descricao VARCHAR(200),
    opcaoA VARCHAR(100),
    opcaoB VARCHAR(100),
    opcaoC VARCHAR(100),
    opcaoD VARCHAR(100),
    opcaoE VARCHAR(100),
    opcaoCorreta CHAR(1),
    PRIMARY KEY(idQuestao)
);