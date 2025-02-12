-- Inserindo categorias
INSERT INTO Categoria (CodCategoria, Descricao) 
VALUES 
(1, 'Leiteira'),
(2, 'Corte');

-- Inserindo animais
INSERT INTO Animal (CodAnimal, Nome, Status, Sexo, ValorCompra, CodCategoria)
VALUES 
(1, 'Vaca1', 'Lactação', 'F', 5000.00, 1),
(2, 'Vaca2', 'Lactação', 'F', 5200.00, 1),
(3, 'Touro1', 'Ativo', 'M', 6000.00, 2);

-- Tipo de parto (1 = Normal, 2 = Cesariana)
INSERT INTO TipoParto (CodTipoParto, Descricao) 
VALUES 
(1, 'Normal'),
(2, 'Cesariana');

-- Inserindo partos para ativar o trigger
INSERT INTO Paricao (CodAnimal, NumCria, DataCria, CodTipoParto)
VALUES 
(1, 1, '2024-01-10', 1),  -- Normal
(2, 2, '2024-01-15', 2);  -- Cesariana (não ativa o trigger diretamente)

-- Simulando produção de leite 301 dias após a última parição
INSERT INTO ProducaoAnimal (CodAnimal, Data, LitrosLeite, Tipo)
VALUES 
(1, '2024-12-07', 25.0, 'L');

CALL AtualizaLactacaoCesaria();

-- Chamando a procedure para ratear uma despesa de R$ 3000 entre vacas leiteiras
CALL RatearDespesa('Ração', 'Leiteira', 3000.00);

CALL CalcularProducaoMedia(2024);

CALL IdentificarAnimaisParaAbate(300.00); -- 300 é o preço da arroba do boi gordo