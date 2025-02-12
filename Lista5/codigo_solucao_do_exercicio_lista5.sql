DELIMITER $$

-- 1) Trigger para validar hora extra antes de inserir em agendamentoservico
CREATE TRIGGER validar_hora_extra
BEFORE INSERT ON agendamentoservico
FOR EACH ROW
BEGIN
    DECLARE totalHoras INT;
    SELECT COALESCE(SUM(tempoExecucao), 0) INTO totalHoras
    FROM agendamentoservico
    JOIN agendamento ON agendamentoservico.idAgendamento = agendamento.idAgendamento
    WHERE agendamento.idTrabalhador = (SELECT idTrabalhador FROM agendamento WHERE idAgendamento = NEW.idAgendamento)
    AND agendamento.data = (SELECT data FROM agendamento WHERE idAgendamento = NEW.idAgendamento);
    
    IF (totalHoras + NEW.tempoExecucao) > 480 THEN
        INSERT INTO horaextra (idTrabalhador, data, tempoExtra)
        VALUES ((SELECT idTrabalhador FROM agendamento WHERE idAgendamento = NEW.idAgendamento),
                (SELECT data FROM agendamento WHERE idAgendamento = NEW.idAgendamento),
                (totalHoras + NEW.tempoExecucao) - 480)
        ON DUPLICATE KEY UPDATE tempoExtra = tempoExtra + ((totalHoras + NEW.tempoExecucao) - 480);
    END IF;
END$$

DELIMITER $$

-- 2) Procedimento para reajustar custo de categoria
CREATE PROCEDURE reajustar_custo_categoria(IN ano_param INT)
BEGIN
    UPDATE custocategoria cc
    JOIN (
        SELECT c.idCategoria, 
               CASE 
                   WHEN (SELECT COUNT(*) FROM agendamento a JOIN agendamentoservico ag ON a.idAgendamento = ag.idAgendamento WHERE a.avaliacaoCliente = 'O' AND ag.idServico IN (SELECT idServico FROM servico WHERE idCategoria = c.idCategoria)) / 
                        (SELECT COUNT(*) FROM agendamentoservico WHERE idServico IN (SELECT idServico FROM servico WHERE idCategoria = c.idCategoria)) >= 0.6 THEN 1.10
                   ELSE 1.05
               END AS reajuste
        FROM categoria c
    ) AS ajuste ON cc.idCategoria = ajuste.idCategoria AND cc.ano = ano_param - 1
    SET cc.valor = cc.valor * ajuste.reajuste;
    
    INSERT INTO custocategoria (idCategoria, ano, valor)
    SELECT idCategoria, ano_param, valor FROM custocategoria WHERE ano = ano_param - 1;
END$$

DELIMITER ;