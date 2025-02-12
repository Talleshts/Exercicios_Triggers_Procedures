DELIMITER $$

-- 1) Trigger para atualizar a nota da avaliação após inserção em gabarito
CREATE TRIGGER atualizar_nota_avaliacao
AFTER INSERT ON gabarito
FOR EACH ROW
BEGIN
    -- Verifica se a opção informada no gabarito é a correta
    DECLARE opcao_correta CHAR(1);

    -- Obtém a opção correta da questão
    SELECT opcaoCorreta INTO opcao_correta
    FROM questao
    WHERE idQuestao = NEW.idQuestao;

    -- Se a opção no gabarito for a correta, atualiza a notaAvaliacao da inscrição
    IF NEW.opcao = opcao_correta THEN
        UPDATE inscricao
        SET notaAvaliacao = notaAvaliacao + 1
        WHERE idSelecao = NEW.idSelecao AND idAluno = NEW.idAluno;
    END IF;
END$$

DELIMITER ;