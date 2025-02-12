INSERT INTO cidade (nome, uf) VALUES 
('Alegre', 'ES'),
('Vitória', 'ES'),
('Cariacica', 'ES');

INSERT INTO endereco (logradouro, numero, bairro, cep, idCidade, complemento) VALUES
('Rua A', 100, 'Centro', 29500000, 1, 'Apartamento 101'),
('Rua B', 200, 'Praia', 29000000, 2, 'Apartamento 202'),
('Rua C', 300, 'Jardim', 29010000, 3, 'Casa 303');

INSERT INTO pessoa (nome, idEndereco, genero, dtNascimento) VALUES
('João Silva', 1, 'Masculino', '1990-05-10'),
('Maria Oliveira', 2, 'Feminino', '1985-11-15'),
('Carlos Souza', 3, 'Masculino', '1992-07-30');

INSERT INTO departamento (nome) VALUES
('Departamento de Computação'),
('Departamento de Matemática');

INSERT INTO curso (nome, chObrigatoria, chOptativa, chTotal) VALUES
('Curso de Ciência da Computação', 150, 50, 200),
('Curso de Matemática', 140, 60, 200);

INSERT INTO disciplina (codigo, nome, ch, ementa, programa) VALUES
('CC101', 'Algoritmos e Estruturas de Dados', 60, 'Estudo de algoritmos e estruturas de dados fundamentais.', 'Algoritmos básicos, pilhas, filas, listas encadeadas, árvores e grafos'),
('MA101', 'Cálculo I', 60, 'Fundamentos de cálculo diferencial e integral.', 'Funções, limites, derivadas e integrais'),
('CC102', 'Sistemas Operacionais', 60, 'Estudo dos fundamentos de sistemas operacionais.', 'Gerenciamento de processos, memória e sistemas de arquivos');

INSERT INTO gradecurricular (idCurso, idDisciplina, obrigatoria) VALUES
(1, 1, 'Sim'),
(1, 2, 'Não'),
(1, 3, 'Sim'),
(2, 2, 'Sim'),
(2, 3, 'Não');

INSERT INTO professor (matricula, dtIngresso, idDepartamento) VALUES
(12345, '2015-03-10', 1),
(67890, '2016-06-20', 2);

INSERT INTO turma (codigo, idCurso, idDisciplina, idProfessor, ano, semestre, nAlunos, nAvaliacoes) VALUES
('CC101-2025-1', 1, 1, 1, 2025, 1, 30, 2),
('MA101-2025-1', 2, 2, 2, 2025, 1, 25, 2);

INSERT INTO aluno (matricula, idCurso, genero, dtIngresso) VALUES
(123, 1, 'Masculino', '2025-01-10'),
(456, 2, 'Feminino', '2025-01-15'),
(789, 1, 'Masculino', '2025-01-18');

INSERT INTO avaliacao (idTurma, idAluno, data, nota, peso) VALUES
(1, 123, '2025-06-15', 8.5, 0.5),
(1, 456, '2025-06-15', 9.0, 0.5),
(2, 789, '2025-06-16', 7.0, 0.6);

INSERT INTO bibliografia (descricao) VALUES
('Livro sobre Algoritmos e Estruturas de Dados'),
('Livro sobre Cálculo e Análise Matemática');

INSERT INTO referencia (idBibliografia, basica) VALUES
(1, 'Sim'),
(2, 'Não');

INSERT INTO historico (idAluno, idCurso, idDisciplina, ano, semestre, situacao, ch, notaFinal, cr) VALUES
(1, 1, 1, 2025, 1, 'Aprovado', 60, 8.5, 8.0),
(2, 2, 2, 2025, 1, 'Aprovado', 60, 9.0, 9.0);