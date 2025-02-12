DELIMITER $$

-- 1) Trigger para atualizar o status de lactação após inserção em Paricao
CREATE TRIGGER AtualizarStatusLactacao
AFTER INSERT ON Paricao
FOR EACH ROW
BEGIN
    DECLARE tipo_parto VARCHAR(100);

    -- Obter a descrição do tipo de parto
    SELECT Descricao INTO tipo_parto
    FROM TipoParto
    WHERE CodTipoParto = NEW.CodTipoParto;

    -- Atualizar status do animal caso não seja cesariana
    IF tipo_parto <> 'Cesariana' THEN
        UPDATE Animal
        SET Status = 'Lactação'
        WHERE CodAnimal = NEW.CodAnimal;
    END IF;
END$$

DELIMITER ;

DELIMITER $$

-- 2) Procedimento para atualizar o status dos animais que tiveram parto cesariana há 30 dias ou mais
CREATE PROCEDURE AtualizarStatusCesarianas()
BEGIN
    UPDATE Animal A
    INNER JOIN Paricao P ON A.CodAnimal = P.CodAnimal
    INNER JOIN TipoParto TP ON P.CodTipoParto = TP.CodTipoParto
    SET A.Status = 'Lactação'
    WHERE TP.Descricao = 'Cesariana'
    AND P.DataCria <= DATE_SUB(CURDATE(), INTERVAL 30 DAY);
END$$

DELIMITER ;

DELIMITER $$

-- 3) Evento para chamar o procedimento de atualização de status diariamente
CREATE EVENT AtualizarStatusDiario
ON SCHEDULE EVERY 1 DAY
DO
BEGIN
    CALL AtualizarStatusCesarianas();
END$$

DELIMITER ;