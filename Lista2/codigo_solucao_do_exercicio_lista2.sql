-- 1a) Trigger para atualizar a carga horária semanal total após inserção em projetofuncionario
DELIMITER $$

CREATE TRIGGER atualizar_chSemanalTotal
AFTER INSERT ON projetofuncionario
FOR EACH ROW
BEGIN
  UPDATE funcionario
  SET chSemanalTotal = chSemanalTotal + NEW.chSemanal
  WHERE idFuncionario = NEW.idFuncionario;
END$$

DELIMITER ;

-- 1b) Trigger para reduzir a carga horária semanal total após atualização no projeto
DELIMITER $$

CREATE TRIGGER reduzir_chSemanalTotal
AFTER UPDATE ON projeto
FOR EACH ROW
BEGIN
  IF NEW.status = 'C' AND OLD.status = 'E' THEN
    UPDATE funcionario
    SET chSemanalTotal = chSemanalTotal - (SELECT chSemanal
                                           FROM projetofuncionario
                                           WHERE idProjeto = NEW.idProjeto
                                           AND idFuncionario = (SELECT idFuncionario
                                                                FROM projetofuncionario
                                                                WHERE idProjeto = NEW.idProjeto
                                                                LIMIT 1))
    WHERE idFuncionario = (SELECT idFuncionario
                           FROM projetofuncionario
                           WHERE idProjeto = NEW.idProjeto
                           LIMIT 1);
  END IF;
END$$

DELIMITER ;

-- 2) Função para verificar se todos os salários de um cargo são iguais
DELIMITER $$

CREATE FUNCTION verificar_salarios_iguais(idCargo INTEGER) 
RETURNS INTEGER
BEGIN
  DECLARE salario_padrao REAL;
  DECLARE salario_igual INTEGER DEFAULT 1;
  
  -- Obter o salário do primeiro funcionário do cargo
  SELECT salario INTO salario_padrao
  FROM funcionario
  WHERE idCargo = idCargo
  LIMIT 1;
  
  -- Verificar se todos os outros funcionários têm o mesmo salário
  DECLARE cursor_salarios CURSOR FOR
    SELECT salario FROM funcionario WHERE idCargo = idCargo;
  
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET salario_igual = 0;
  
  OPEN cursor_salarios;
  
  read_loop: LOOP
    FETCH cursor_salarios INTO salario_padrao;
    IF salario_padrao <> salario_padrao THEN
      SET salario_igual = 0;
      LEAVE read_loop;
    END IF;
  END LOOP;
  
  CLOSE cursor_salarios;
  
  RETURN salario_igual;
END$$

DELIMITER ;

-- 3) Função para verificar se um funcionário está supervisionando algum outro funcionário
DELIMITER $$

CREATE FUNCTION verificar_supervisao(idFuncionario INTEGER) 
RETURNS INTEGER
BEGIN
  DECLARE supervisao_existente INTEGER DEFAULT 0;
  
  -- Verificar se o funcionário está supervisionando algum outro funcionário
  SELECT COUNT(*) INTO supervisao_existente
  FROM funcionario
  WHERE idSupervisor = idFuncionario;
  
  RETURN supervisao_existente;
END$$

DELIMITER ;

-- 4) Procedimento para preencher o relatório de supervisores de supervisores
DELIMITER $$

CREATE PROCEDURE preencher_relatorio_supervisores_de_supervisores()
BEGIN
  INSERT INTO relatorio (idFuncionario, nome, genero)
  SELECT f.idFuncionario, f.nome, f.genero
  FROM funcionario f
  WHERE f.idFuncionario IN (
    SELECT idSupervisor 
    FROM funcionario 
    WHERE idSupervisor IS NOT NULL
  );
END$$

DELIMITER ;