INSERT INTO Campeonato (CodCampeonato, Descricao)
VALUES
(1, 'Campeonato Brasileiro 2025'),
(2, 'Copa do Brasil 2025');

INSERT INTO Cidade (CodCidade, Nome, UF)
VALUES
(1, 'Belo Horizonte', 'MG'),
(2, 'Vespasiano', 'MG');

INSERT INTO Clube (CodClube, Nome, CodCidade)
VALUES
(1, 'Atlético Mineiro', 1),
(2, 'Cruzeiro', 2);

INSERT INTO Estadio (CodEstadio, Nome, CodCidade, Capacidade)
VALUES
(1, 'Arena MRV', 1, 60000),
(2, 'Mineirão', 2, 78000);

INSERT INTO ClubeCampeonato (CodClube, CodCampeonato, Ano, Pontos)
VALUES
(1, 1, 2025, 0),
(2, 1, 2025, 0),
(1, 2, 2025, 0),
(2, 2, 2025, 0);

INSERT INTO Jogador (CodJogador, Nome, DataNascimento, ValorPasse)
VALUES
(1, 'Jogador A', '1995-03-10', 1000000),
(2, 'Jogador B', '1997-07-15', 1500000);

INSERT INTO JogadorClubeCampeonato (CodClube, CodCampeonato, Ano, CodJogador, Gols)
VALUES
(1, 1, 2025, 1, 10),
(2, 1, 2025, 2, 12);

INSERT INTO Partida (CodCampeonato, Ano, DataHora, CodEstadio, CodClube1, GolsClube1, CodClube2, GolsClube2)
VALUES
(1, 2025, '2025-02-10 15:00:00', 1, 1, 2, 2, 2),
(1, 2025, '2025-02-11 16:00:00', 2, 1, 3, 2, 1);

-- Chamada da procedure para aumentar o valor do passe
CALL AumentarPasseMaiorGoleador('Campeonato Brasileiro 2025', 2025);
-- Chamada da procedure para adicionar partidas
CALL AdicionarRodada('2025-02-10', 1);