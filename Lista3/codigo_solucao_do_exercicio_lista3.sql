--1 
DELIMITER $$

CREATE TRIGGER AtualizarPontos
AFTER INSERT ON Partida
FOR EACH ROW
BEGIN
    DECLARE v_gols_clube1 INT;
    DECLARE v_gols_clube2 INT;
    DECLARE v_cod_clube1 INT;
    DECLARE v_cod_clube2 INT;
    DECLARE v_cod_campeonato INT;
    DECLARE v_ano INT;

    SET v_gols_clube1 = NEW.GolsClube1;
    SET v_gols_clube2 = NEW.GolsClube2;
    SET v_cod_clube1 = NEW.CodClube1;
    SET v_cod_clube2 = NEW.CodClube2;
    SET v_cod_campeonato = NEW.CodCampeonato;
    SET v_ano = NEW.Ano;

    IF v_gols_clube1 > v_gols_clube2 THEN
        UPDATE ClubeCampeonato SET Pontos = Pontos + 3
        WHERE CodClube = v_cod_clube1 AND CodCampeonato = v_cod_campeonato AND Ano = v_ano;
    ELSIF v_gols_clube1 < v_gols_clube2 THEN
        UPDATE ClubeCampeonato SET Pontos = Pontos + 3
        WHERE CodClube = v_cod_clube2 AND CodCampeonato = v_cod_campeonato AND Ano = v_ano;
    ELSE
        UPDATE ClubeCampeonato SET Pontos = Pontos + 1
        WHERE CodClube = v_cod_clube1 AND CodCampeonato = v_cod_campeonato AND Ano = v_ano;
        UPDATE ClubeCampeonato SET Pontos = Pontos + 1
        WHERE CodClube = v_cod_clube2 AND CodCampeonato = v_cod_campeonato AND Ano = v_ano;
    END IF;
END$$

DELIMITER ;

--2 
DELIMITER $$

CREATE TRIGGER AtualizarNumPartidas
AFTER INSERT ON Partida
FOR EACH ROW
BEGIN
    UPDATE Estadio
    SET NumPartidas = NumPartidas + 1
    WHERE CodEstadio = NEW.CodEstadio;
END$$

DELIMITER ;

--3
DELIMITER $$

CREATE PROCEDURE AumentarPasseMaiorGoleador(
    IN descricao_campeonato TEXT,
    IN ano INT
)
BEGIN
    DECLARE v_cod_jogador INT;
    DECLARE v_max_gols INT;

    SELECT CodJogador, MAX(Gols) INTO v_cod_jogador, v_max_gols
    FROM JogadorClubeCampeonato
    WHERE CodCampeonato = (SELECT CodCampeonato FROM Campeonato WHERE Descricao = descricao_campeonato)
      AND Ano = ano
    GROUP BY CodJogador
    ORDER BY v_max_gols DESC
    LIMIT 1;

    UPDATE Jogador
    SET ValorPasse = ValorPasse * 1.15
    WHERE CodJogador = v_cod_jogador;
END$$

DELIMITER ;

--4 
DELIMITER $$

CREATE PROCEDURE AdicionarRodada(
    IN data_partida DATE,
    IN cod_campeonato INT
)
BEGIN
    DECLARE v_num_rodada INT;

    SELECT MAX(Rodada) INTO v_num_rodada
    FROM Rodada
    WHERE CodCampeonato = cod_campeonato;

    IF v_num_rodada IS NULL THEN
        SET v_num_rodada = 1;
    ELSE
        SET v_num_rodada = v_num_rodada + 1;
    END IF;

    INSERT INTO Rodada (CodCampeonato, Rodada, DataPartida, CodClube1, CodClube2)
    SELECT CodCampeonato, v_num_rodada, DataHora, CodClube1, CodClube2
    FROM Partida
    WHERE CodCampeonato = cod_campeonato
      AND DATE(DataHora) = data_partida;
END$$

DELIMITER ;