DELIMITER $$

-- 1) Trigger para verificar lactação após inserção em ProducaoAnimal
CREATE TRIGGER trg_verifica_lactacao
AFTER INSERT ON ProducaoAnimal
FOR EACH ROW
BEGIN
    DECLARE dias_desde_ultima_paricao INT;
    DECLARE data_ultima_paricao DATE;

    -- Obtém a data da última parição do animal
    SELECT MAX(DataCria) INTO data_ultima_paricao
    FROM Paricao
    WHERE CodAnimal = NEW.CodAnimal;

    -- Calcula a diferença de dias
    IF data_ultima_paricao IS NOT NULL THEN
        SET dias_desde_ultima_paricao = DATEDIFF(NEW.Data, data_ultima_paricao);
        
        -- Se passaram 300 dias, atualiza o status para "Seca" e registra a data final da lactação
        IF dias_desde_ultima_paricao >= 300 THEN
            UPDATE Animal
            SET Status = 'Seca'
            WHERE CodAnimal = NEW.CodAnimal;

            UPDATE Lactacao
            SET DataFim = NEW.Data
            WHERE CodAnimal = NEW.CodAnimal
            ORDER BY NumLactacao DESC
            LIMIT 1;
        END IF;
    END IF;
END$$

DELIMITER $$

-- 2) Trigger para atualizar lactação após inserção em Paricao
CREATE TRIGGER trg_atualiza_lactacao
AFTER INSERT ON Paricao
FOR EACH ROW
BEGIN
    DECLARE tipo_parto VARCHAR(50);

    -- Obtém o tipo de parto da nova parição
    SELECT Descricao INTO tipo_parto
    FROM TipoParto
    WHERE CodTipoParto = NEW.CodTipoParto;

    -- Se o parto não for cesariana, atualiza o status do animal
    IF tipo_parto <> 'Cesariana' THEN
        UPDATE Animal
        SET Status = 'Lactação'
        WHERE CodAnimal = NEW.CodAnimal;
    END IF;
END$$

DELIMITER $$

-- 3) Procedimento para atualizar lactação após cesariana
CREATE PROCEDURE AtualizaLactacaoCesaria()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE animal_id INT;
    DECLARE cur CURSOR FOR 
        SELECT CodAnimal FROM Paricao 
        WHERE DATEDIFF(CURDATE(), DataCria) >= 30 
        AND CodTipoParto = (SELECT CodTipoParto FROM TipoParto WHERE Descricao = 'Cesariana');
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO animal_id;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Atualiza o status do animal para Lactação
        UPDATE Animal
        SET Status = 'Lactação'
        WHERE CodAnimal = animal_id;
    END LOOP;

    CLOSE cur;
END$$

DELIMITER $$

-- 4) Procedimento para ratear despesa entre animais de uma categoria
CREATE PROCEDURE RatearDespesa(
    IN descricao_despesa VARCHAR(100), 
    IN descricao_categoria VARCHAR(100), 
    IN valor_total DOUBLE
)
BEGIN
    DECLARE categoria_id INT;
    DECLARE receita_id INT;
    DECLARE num_animais INT;
    DECLARE valor_rateado DOUBLE;

    -- Obtém o ID da categoria
    SELECT CodCategoria INTO categoria_id
    FROM Categoria
    WHERE descricao = descricao_categoria;

    -- Obtém o número de animais na categoria
    SELECT COUNT(*) INTO num_animais
    FROM Animal
    WHERE CodCategoria = categoria_id;

    IF num_animais > 0 THEN
        SET valor_rateado = valor_total / num_animais;
    ELSE
        SET valor_rateado = 0;
    END IF;

    -- Verifica se a receita já existe
    SELECT CodReceita INTO receita_id
    FROM Receita
    WHERE Descricao = descricao_despesa;

    -- Se não existir, cadastra
    IF receita_id IS NULL THEN
        INSERT INTO Receita (Descricao) VALUES (descricao_despesa);
        SET receita_id = LAST_INSERT_ID();
    END IF;

    -- Distribui o valor entre os animais
    INSERT INTO ReceitaAnimal (CodAnimal, CodReceita, valor)
    SELECT CodAnimal, receita_id, valor_rateado
    FROM Animal
    WHERE CodCategoria = categoria_id;
END$$

DELIMITER $$

-- 5) Procedimento para calcular produção média anual
CREATE PROCEDURE CalcularProducaoMedia(IN ano INT)
BEGIN
    INSERT INTO ProducaoMedia (CodAnimal, Ano, LtMediaDiaria)
    SELECT CodAnimal, ano, AVG(LitrosLeite)
    FROM ProducaoAnimal
    WHERE YEAR(Data) = ano
    GROUP BY CodAnimal;
END$$

DELIMITER $$

-- 6) Procedimento para identificar animais para abate
CREATE PROCEDURE IdentificarAnimaisParaAbate(IN preco_boigordo DOUBLE)
BEGIN
    INSERT INTO AnimalPrejuizo (CodAnimal, ValorDespesa, ValorVenda, Prejuizo)
    SELECT 
        a.CodAnimal, 
        (a.ValorCompra + IFNULL(SUM(d.valor), 0)), 
        (pa.peso / 15) * preco_boigordo, 
        ((pa.peso / 15) * preco_boigordo) - (a.ValorCompra + IFNULL(SUM(d.valor), 0))
    FROM Animal a
    LEFT JOIN DespesaAnimal d ON a.CodAnimal = d.CodAnimal
    LEFT JOIN PesoAnimal pa ON a.CodAnimal = pa.CodAnimal
    WHERE (a.Sexo = 'M' OR 
          NOT EXISTS (SELECT 1 FROM Paricao p WHERE p.CodAnimal = a.CodAnimal AND DATEDIFF(CURDATE(), p.DataCria) < 365) OR 
          NOT EXISTS (SELECT 1 FROM ProducaoAnimal pr WHERE pr.CodAnimal = a.CodAnimal AND MONTH(pr.Data) = MONTH(CURDATE()) AND YEAR(pr.Data) = YEAR(CURDATE()) HAVING SUM(pr.LitrosLeite) >= 120))
    GROUP BY a.CodAnimal;
END$$

DELIMITER ;