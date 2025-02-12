DELIMITER $$

-- 1) Trigger para atualizar o status de exame após inserção em resultadoexame
CREATE TRIGGER atualizar_status_exame
AFTER INSERT ON resultadoexame
FOR EACH ROW
BEGIN
    DECLARE total_exames INT;
    DECLARE total_resultados INT;

    -- Conta quantos exames foram pedidos para a consulta do paciente
    SELECT COUNT(*) INTO total_exames
    FROM pedidoexame
    WHERE idConsulta = (SELECT idConsulta FROM consulta WHERE idPaciente = NEW.idPaciente LIMIT 1);

    -- Conta quantos exames já possuem um resultado lançado
    SELECT COUNT(DISTINCT idResultadoExame) INTO total_resultados
    FROM pedidoexame
    WHERE idConsulta = (SELECT idConsulta FROM consulta WHERE idPaciente = NEW.idPaciente LIMIT 1)
    AND idResultadoExame IS NOT NULL;

    -- Se todos os exames tiverem resultado, marca como concluído
    IF total_exames > 0 AND total_exames = total_resultados THEN
        UPDATE consulta
        SET exameConcluido = 'S'
        WHERE idConsulta = (SELECT idConsulta FROM consulta WHERE idPaciente = NEW.idPaciente LIMIT 1);
    END IF;
END$$

DELIMITER ;

DELIMITER $$

-- 2) Procedimento para remarcar consultas
CREATE PROCEDURE remarcar_consultas(
    IN nome_profissional VARCHAR(100),
    IN data_ausencia DATE
)
BEGIN
    DECLARE novo_dia DATE;
    DECLARE id_profissional INT;

    -- Obtém o ID do profissional pelo nome
    SELECT idProfissionalSaude INTO id_profissional
    FROM profissionalsaude
    WHERE idProfissionalSaude = (SELECT idProfissionalSaude FROM consulta WHERE dtConsulta = data_ausencia LIMIT 1);

    -- Se não encontrar o profissional, encerra
    IF id_profissional IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Profissional não encontrado!';
    END IF;

    -- Encontra um novo dia útil (sem consultas já agendadas)
    SET novo_dia = data_ausencia + INTERVAL 1 DAY;

    WHILE WEEKDAY(novo_dia) IN (5,6) OR EXISTS (
        SELECT 1 FROM consulta WHERE idProfissionalSaude = id_profissional AND dtConsulta = novo_dia
    ) DO
        SET novo_dia = novo_dia + INTERVAL 1 DAY;
    END WHILE;

    -- Atualiza as consultas para o novo dia útil
    UPDATE consulta
    SET dtConsulta = novo_dia
    WHERE idProfissionalSaude = id_profissional AND dtConsulta = data_ausencia;
END$$

DELIMITER ;

DELIMITER $$

-- 3) Procedimento para atualizar o total de consultas
CREATE PROCEDURE atualizar_total_consultas(
    IN data_inicio DATE,
    IN data_fim DATE
)
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE v_idProfissional INT;
    DECLARE v_totalConsultas INT;
    
    -- Cursor para percorrer os profissionais de saúde
    DECLARE cur CURSOR FOR
    SELECT idProfissionalSaude FROM profissionalsaude;
    
    -- Handler para sair do loop quando não houver mais dados
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    -- Criando o campo totalConsultas caso não exista
    IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'profissionalsaude' AND COLUMN_NAME = 'totalConsultas') THEN
        ALTER TABLE profissionalsaude ADD COLUMN totalConsultas INT DEFAULT 0;
    END IF;

    OPEN cur;
    
    read_loop: LOOP
        FETCH cur INTO v_idProfissional;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Conta as consultas do profissional no período especificado
        SELECT COUNT(*) INTO v_totalConsultas
        FROM consulta
        WHERE idProfissionalSaude = v_idProfissional
        AND dtConsulta BETWEEN data_inicio AND data_fim;

        -- Atualiza o total de consultas
        UPDATE profissionalsaude
        SET totalConsultas = v_totalConsultas
        WHERE idProfissionalSaude = v_idProfissional;
    END LOOP;

    CLOSE cur;
END$$

DELIMITER ;