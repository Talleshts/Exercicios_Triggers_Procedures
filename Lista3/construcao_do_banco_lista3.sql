CREATE TABLE Campeonato (
    CodCampeonato INT AUTO_INCREMENT PRIMARY KEY,
    Descricao TEXT NOT NULL
);

CREATE TABLE Cidade (
    CodCidade INT AUTO_INCREMENT PRIMARY KEY,
    Nome TEXT NOT NULL,
    UF CHAR(2) NOT NULL
);

CREATE TABLE Clube (
    CodClube INT AUTO_INCREMENT PRIMARY KEY,
    Nome TEXT NOT NULL,
    CodCidade INT NOT NULL,
    FOREIGN KEY (CodCidade) REFERENCES Cidade(CodCidade)
);

CREATE TABLE Estadio (
    CodEstadio INT AUTO_INCREMENT PRIMARY KEY,
    Nome TEXT NOT NULL,
    CodCidade INT NOT NULL,
    Capacidade INT NOT NULL,
    NumPartidas INT DEFAULT 0,
    FOREIGN KEY (CodCidade) REFERENCES Cidade(CodCidade)
);

CREATE TABLE ClubeCampeonato (
    CodClube INT,
    CodCampeonato INT,
    Ano INT,
    Pontos INT DEFAULT 0,
    PRIMARY KEY (CodClube, CodCampeonato, Ano),
    FOREIGN KEY (CodClube) REFERENCES Clube(CodClube),
    FOREIGN KEY (CodCampeonato) REFERENCES Campeonato(CodCampeonato)
);

CREATE TABLE Jogador (
    CodJogador INT AUTO_INCREMENT PRIMARY KEY,
    Nome TEXT NOT NULL,
    DataNascimento DATE NOT NULL,
    ValorPasse DECIMAL(10,2) NOT NULL
);

CREATE TABLE JogadorClubeCampeonato (
    CodClube INT,
    CodCampeonato INT,
    Ano INT,
    CodJogador INT,
    Gols INT DEFAULT 0,
    PRIMARY KEY (CodClube, CodCampeonato, Ano, CodJogador),
    FOREIGN KEY (CodClube, CodCampeonato, Ano) REFERENCES ClubeCampeonato(CodClube, CodCampeonato, Ano),
    FOREIGN KEY (CodJogador) REFERENCES Jogador(CodJogador)
);

CREATE TABLE Partida (
    CodCampeonato INT,
    Ano INT,
    CodPartida INT AUTO_INCREMENT PRIMARY KEY,
    DataHora DATETIME NOT NULL,
    CodEstadio INT NOT NULL,
    CodClube1 INT NOT NULL,
    GolsClube1 INT DEFAULT 0,
    CodClube2 INT NOT NULL,
    GolsClube2 INT DEFAULT 0,
    FOREIGN KEY (CodCampeonato) REFERENCES Campeonato(CodCampeonato),
    FOREIGN KEY (CodEstadio) REFERENCES Estadio(CodEstadio),
    FOREIGN KEY (CodClube1) REFERENCES Clube(CodClube),
    FOREIGN KEY (CodClube2) REFERENCES Clube(CodClube)
);

CREATE TABLE Rodada (
    CodCampeonato INT,
    Rodada INT,
    DataPartida DATE,
    CodClube1 INT,
    CodClube2 INT,
    PRIMARY KEY (CodCampeonato, Rodada, DataPartida, CodClube1, CodClube2),
    FOREIGN KEY (CodCampeonato) REFERENCES Campeonato(CodCampeonato),
    FOREIGN KEY (CodClube1) REFERENCES Clube(CodClube),
    FOREIGN KEY (CodClube2) REFERENCES Clube(CodClube)
);