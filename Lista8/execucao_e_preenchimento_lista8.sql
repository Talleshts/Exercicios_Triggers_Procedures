-- Inserindo categorias
INSERT INTO Categoria (Descricao) VALUES 
('Leiteiro'),
('Corte');

-- Inserindo animais
INSERT INTO Animal (CodCategoria, Nome, Sexo, DataNascimento, Status) VALUES
(1, 'Vaca1', 'F', '2020-05-15', 'Normal'),
(1, 'Vaca2', 'F', '2019-08-10', 'Normal'),
(1, 'Vaca3', 'F', '2021-02-20', 'Normal');

-- Inserindo tipos de parto
INSERT INTO TipoParto (Descricao) VALUES 
('Normal'),
('Cesariana');

-- Inserindo parições (1 parto normal e 1 cesariana)
INSERT INTO Paricao (CodAnimal, NumCria, DataCria, CodTipoParto) VALUES 
(1, 1, CURDATE(), 1),  -- Parto Normal -> Aciona o trigger e muda status para "Lactação"
(2, 1, CURDATE() - INTERVAL 35 DAY, 2); -- Parto Cesariana há mais de 30 dias

-- Verificando o status do animal após o parto normal
SELECT CodAnimal, Nome, Status FROM Animal WHERE CodAnimal = 1;

-- Atualizando o status dos animais que tiveram parto cesariana há 30 dias ou mais
CALL AtualizarStatusCesarianas();

-- Verificando o status do animal após a atualização
SELECT CodAnimal, Nome, Status FROM Animal WHERE CodAnimal = 2;