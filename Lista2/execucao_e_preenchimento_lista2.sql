INSERT INTO cidade (nome, uf)
VALUES 
  ('Alegre', 'ES'),
  ('Vitória', 'ES'),
  ('Cariacica', 'ES');

INSERT INTO endereco (cep, rua, numero, bairro, idCidade)
VALUES 
  (29500000, 'Rua A', 10, 'Centro', 1), 
  (29000000, 'Rua B', 20, 'Praia', 2),
  (29001000, 'Rua C', 30, 'Centro', 3);

INSERT INTO cargo (nome)
VALUES 
  ('Supervisor'), 
  ('Analista'),
  ('Gerente');

INSERT INTO departamento (nome, idGerente)
VALUES 
  ('TI', 1), 
  ('RH', 2),
  ('Financeiro', 3);

INSERT INTO funcionario (idCargo, idEndereco, NIS, salario, idDepartamento, idSupervisor)
VALUES 
  (1, 1, 123456789, 3000.00, 1, NULL),
  (2, 2, 987654321, 2000.00, 2, 1),   
  (3, 3, 456789123, 5000.00, 3, NULL);

INSERT INTO projeto (numero, idLocalizacao, nome)
VALUES 
  (1, 1, 'Projeto A'),
  (2, 2, 'Projeto B');

INSERT INTO localizacao (descricao, idDepartamento)
VALUES 
  ('Escritório 1', 1),
  ('Escritório 2', 2);

INSERT INTO projetofuncionario (idProjeto, idFuncionario, chSemanal)
VALUES 
  (1, 1, 10),  -- Projeto A atribuído ao Supervisor
  (2, 2, 15);  -- Projeto B atribuído ao Analista

UPDATE projeto
SET status = 'C'
WHERE idProjeto = 1;  -- Projeto A agora está concluído

SELECT verificar_salarios_iguais(1);  -- Retorna 1 se os salários forem iguais, 0 se forem diferentes

SELECT verificar_supervisao(3);  -- Retorna 1 se o gerente está supervisionando, 0 caso contrário

CALL preencher_relatorio_supervisores_de_supervisores();