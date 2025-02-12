--Questão 1
DELIMITER $$

CREATE TRIGGER atualiza_historico_insert
AFTER INSERT ON historico
FOR EACH ROW
BEGIN
    -- Atualizar a nota final e CR do aluno após a inserção no histórico
    UPDATE historico
    SET notaFinal = (SELECT SUM(nota * peso) / SUM(peso)
                     FROM avaliacao
                     WHERE idAluno = NEW.idAluno
                       AND idTurma IN (SELECT idTurma FROM turma WHERE idDisciplina = NEW.idDisciplina)
                     GROUP BY idAluno),
        cr = (SELECT SUM(nota * peso) / SUM(peso)
              FROM avaliacao
              WHERE idAluno = NEW.idAluno
                AND idTurma IN (SELECT idTurma FROM turma WHERE idDisciplina = NEW.idDisciplina)
              GROUP BY idAluno)
    WHERE idAluno = NEW.idAluno
      AND idDisciplina = NEW.idDisciplina
      AND ano = NEW.ano
      AND semestre = NEW.semestre;
END$$

CREATE TRIGGER atualiza_historico_update
AFTER UPDATE ON historico
FOR EACH ROW
BEGIN
    -- Recalcular a nota final e CR ao atualizar o histórico
    UPDATE historico
    SET notaFinal = (SELECT SUM(nota * peso) / SUM(peso)
                     FROM avaliacao
                     WHERE idAluno = NEW.idAluno
                       AND idTurma IN (SELECT idTurma FROM turma WHERE idDisciplina = NEW.idDisciplina)
                     GROUP BY idAluno),
        cr = (SELECT SUM(nota * peso) / SUM(peso)
              FROM avaliacao
              WHERE idAluno = NEW.idAluno
                AND idTurma IN (SELECT idTurma FROM turma WHERE idDisciplina = NEW.idDisciplina)
              GROUP BY idAluno)
    WHERE idAluno = NEW.idAluno
      AND idDisciplina = NEW.idDisciplina
      AND ano = NEW.ano
      AND semestre = NEW.semestre;
END$$

CREATE TRIGGER atualiza_historico_delete
AFTER DELETE ON historico
FOR EACH ROW
BEGIN
    -- Caso necessário, você pode atualizar ou limpar outros dados relacionados ao histórico de avaliações
    -- O exemplo abaixo apenas sinaliza a remoção, mas pode ser ajustado conforme os requisitos específicos.
    UPDATE aluno
    SET cr = (SELECT AVG(cr) FROM historico WHERE idAluno = OLD.idAluno)
    WHERE idAluno = OLD.idAluno;
END$$

DELIMITER ;

--Questão 2

DELIMITER $$

CREATE PROCEDURE calcular_nota_final (IN turma_id INT)
BEGIN
    DECLARE aluno_id INT;
    DECLARE nota_final DECIMAL(10,2);
    DECLARE peso_total DECIMAL(10,2);
    DECLARE done INT DEFAULT 0;

    -- Cursor para obter todos os alunos da turma
    DECLARE aluno_cursor CURSOR FOR
    SELECT idAluno
    FROM avaliacao
    WHERE idTurma = turma_id
    GROUP BY idAluno;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    -- Iniciar o cursor
    OPEN aluno_cursor;

    -- Loop para calcular a nota final para cada aluno
    read_loop: LOOP
        FETCH aluno_cursor INTO aluno_id;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Calcular a nota final e o peso total para o aluno
        SELECT SUM(nota * peso), SUM(peso)
        INTO nota_final, peso_total
        FROM avaliacao
        WHERE idAluno = aluno_id
          AND idTurma = turma_id;

        -- Atualizar a nota final e CR no histórico do aluno
        UPDATE historico
        SET notaFinal = (nota_final / peso_total),
            cr = (nota_final / peso_total)
        WHERE idAluno = aluno_id
          AND idTurma = turma_id;

    END LOOP;

    -- Fechar o cursor
    CLOSE aluno_cursor;
END$$

DELIMITER ;