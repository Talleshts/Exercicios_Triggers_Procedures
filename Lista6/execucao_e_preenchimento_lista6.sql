-- Inserindo cidades
INSERT INTO cidade (nome, uf) VALUES (1, 'Alegre', 'ES');
INSERT INTO cidade (nome, uf) VALUES (2, 'Vitória', 'ES');

-- Inserindo endereços
INSERT INTO endereco (logradouro, bairro, numero, cep, complemento, latitude, longitude, idCidade)
VALUES ('Rua Principal', 'Centro', 100, 29500000, 'Próximo à praça', -20, -41, 1);

INSERT INTO endereco (logradouro, bairro, numero, cep, complemento, latitude, longitude, idCidade)
VALUES ('Avenida Secundária', 'Bairro Novo', 200, 29000000, '', -20.3, -40.3, 2);

-- Inserindo UBS
INSERT INTO ubs (nome, idEndereco) VALUES ('UBS Central', 1);

-- Inserindo especialidades médicas
INSERT INTO especialidade (descricao) VALUES ('Clínico Geral');
INSERT INTO especialidade (descricao) VALUES ('Pediatria');

-- Inserindo profissionais de saúde
INSERT INTO profissionalsaude () VALUES ();
INSERT INTO profissionalsaude () VALUES ();

-- Inserindo pacientes
INSERT INTO paciente (numeroSUS, idPai, idMae) VALUES (123456789, NULL, NULL);
INSERT INTO paciente (numeroSUS, idPai, idMae) VALUES (987654321, NULL, NULL);

-- Inserindo consultas
INSERT INTO consulta (idPaciente, idProfissionalSaude, anamnese, dtConsulta, hConsulta, status, exameConcluido)
VALUES (1, 1, 'Consulta de rotina', '2025-02-12', '10:00:00', 'A', 'N');

INSERT INTO consulta (idPaciente, idProfissionalSaude, anamnese, dtConsulta, hConsulta, status, exameConcluido)
VALUES (2, 2, 'Dor de cabeça frequente', '2025-02-13', '14:30:00', 'A', 'N');

-- Inserindo pedidos de exames para a consulta
INSERT INTO pedidoexame (idConsulta, descricao, arquivo, idResultadoExame)
VALUES (1, 'Hemograma completo', NULL, NULL);

INSERT INTO pedidoexame (idConsulta, descricao, arquivo, idResultadoExame)
VALUES (1, 'Raio-X de Tórax', NULL, NULL);

-- **Teste da Trigger**: Inserindo resultados de exames (o último acionará a atualização do status)
INSERT INTO resultadoexame (idPaciente, descricao, data, arquivo)
VALUES (1, 'Hemograma normal', '2025-02-13', NULL);

INSERT INTO resultadoexame (idPaciente, descricao, data, arquivo)
VALUES (1, 'Raio-X sem alterações', '2025-02-14', NULL); -- **Aqui a trigger muda o exameConcluido para 'S'**

-- **Teste da Procedure de Remarcação**: 
-- O profissional 1 não estará disponível no dia 2025-02-12, então as consultas serão remarcadas.
CALL remarcar_consultas('Dr. João', '2025-02-12');

-- **Teste da Procedure de Atualização de Total de Consultas**
CALL atualizar_total_consultas('2025-02-01', '2025-02-28');

-- Consultando resultados
SELECT * FROM consulta;
SELECT * FROM resultadoexame;
SELECT * FROM profissionalsaude;