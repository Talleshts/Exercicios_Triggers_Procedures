INSERT INTO cidade (nome, uf) VALUES ('São Paulo', 'SP');
INSERT INTO endereco (logradouro, numero, complemento, bairro, cep, idCidade) VALUES ('Rua A', 123, 'Apto 1', 'Centro', '01000-000', 1);
INSERT INTO pessoa (nome, telFixo, telCelular, email, cpf, rg, idEndereco) VALUES ('João Silva', '1111-1111', '99999-9999', 'joao@email.com', '12345678900', 'MG1234567', 1);
INSERT INTO cliente (avaliacaoCliente) VALUES ('O');
INSERT INTO trabalhador () VALUES ();
INSERT INTO categoria (descricao) VALUES ('Eletricista');
INSERT INTO servico (descricao, tempoMedioExecucao, idCategoria) VALUES ('Instalação Elétrica', 120, 1);
INSERT INTO agendamento (idStatus, idTrabalhador, idCliente, data, hora, avaliacaoCliente, valorTotal) VALUES (1, 1, 1, '2025-02-11', '08:00:00', 'O', 200.00);
INSERT INTO agendamentoservico (idAgendamento, idServico, tempoExecucao, valorServico) VALUES (1, 1, 120, 200.00);


CALL reajustar_custo_categoria(2025);
