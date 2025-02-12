-- Inserindo dados na tabela questao
INSERT INTO questao (descricao, opcaoA, opcaoB, opcaoC, opcaoD, opcaoE, opcaoCorreta)
VALUES ('Qual a capital do Brasil?', 'Rio de Janeiro', 'São Paulo', 'Brasília', 'Salvador', 'Belo Horizonte', 'C');

-- Inserindo dados na tabela aluno
INSERT INTO aluno (matricula, anoIngresso)
VALUES (12345, 2020),
       (67890, 2021);

-- Inserindo dados na tabela professor
INSERT INTO professor (dataAdmissao)
VALUES (2020),
       (2021);

-- Inserindo dados na tabela disciplina
INSERT INTO disciplina (nome, ch)
VALUES ('Matemática', 60),
       ('Física', 45);

-- Inserindo dados na tabela monitoria
INSERT INTO monitoria (descricao, idDisciplina, idProfessor, oficial, idAnterior, dataInicio, dataTermino)
VALUES ('Monitoria de Matemática', 1, 1, 'S', NULL, '2025-02-01', '2025-06-30');

-- Inserindo dados na tabela selecao
INSERT INTO selecao (idMonitoria, inicioInscricao, fimInscricao, dataAvaliacao, horaAvaliacao, numInscritos)
VALUES (1, '2025-01-01', '2025-01-31', '2025-02-05', '10:00:00', 2);

-- Inserindo dados na tabela inscricao
INSERT INTO inscricao (idSelecao, idAluno, numInscricao, notaDisciplina, cr, notaAvaliacao, notaFinal, classificacao)
VALUES (1, 1, 1001, 9.5, 7.0, 0, 7.5, 1),
       (1, 2, 1002, 8.0, 6.5, 0, 6.0, 2);

-- Inserindo dados na tabela gabarito (isso acionará o TRIGGER)
INSERT INTO gabarito (idSelecao, idAluno, idQuestao, opcao)
VALUES (1, 1, 1, 'C'),  -- Resposta correta para a primeira questão
       (1, 2, 1, 'B');  -- Resposta incorreta para a primeira questão

-- Verificando a tabela inscricao para ver se a notaAvaliacao foi atualizada
SELECT * FROM inscricao;

-- Verificando a tabela gabarito para confirmar as respostas
SELECT * FROM gabarito;