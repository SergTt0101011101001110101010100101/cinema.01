CREATE DATABASE cinema;
USE cinema;

CREATE TABLE categorias (
    Id_categorias INT,
    Categoria VARCHAR(25),
    PRIMARY KEY (Id_categorias)
);

INSERT INTO categorias VALUES
(1, 'Sport'),
(2, 'Terror'),
(3, 'Aventura'),
(4, 'Comedia');



CREATE TABLE filmes (
    Id_filme INT,
    Id_categorias INT,
    Nome VARCHAR(40),
    PRIMARY KEY (Id_filme),
    FOREIGN KEY (Id_categorias) REFERENCES categorias(Id_categorias)
);

INSERT INTO filmes VALUES
(1043, 1, 'Cavalos vs Ferrari'),
(1044, 2, 'Speed Water');



CREATE TABLE atores (
    Id_atores INT,
    Nome VARCHAR(60),
    Data_Nascimento DATE,
    Id_filme INT,
    PRIMARY KEY (Id_atores),
    FOREIGN KEY (Id_filme) REFERENCES filmes(Id_filme)
);

INSERT INTO atores VALUES
(1, 'Jhon Alper', '1998-09-09', 1043),
(2, 'Carlos Cardoso', '1996-05-06', 1043),
(3, 'Paulo Notas', '2000-10-04', 1044),
(4, 'Liandro Costa', '2003-11-01', 1044);



CREATE TABLE loja (
    Id_loja INT,
    Id_filme INT,
    PRIMARY KEY (Id_loja),
    FOREIGN KEY (Id_filme) REFERENCES filmes(Id_filme)
);

INSERT INTO loja VALUES
(1, 1043),
(2, 1044);


-- Consulta para seleccionar os filmes da categoría 'Sport'
SELECT filmes.Id_filme, filmes.Nome
FROM filmes
LEFT JOIN categorias ON categorias.Id_categorias = filmes.Id_categorias
WHERE categorias.Categoria = 'Sport'
ORDER BY filmes.Nome ASC;


-- Adicionar una constraint
ALTER TABLE loja
ADD CONSTRAINT FK_Loja_Filmes
FOREIGN KEY (Id_filme) REFERENCES filmes(Id_filme);


-- Adicionar uma coluna da tabela filmes
ALTER TABLE filmes
ADD Id_loja INT;


-- Seleccionar um título dos filmes que apenas podem ser alugados na loja nº 1
-- Ordenado alfabéticamente por título
SELECT filmes.Nome AS Titulo_filme
FROM filmes
JOIN loja ON filmes.Id_filme = loja.Id_filme
WHERE loja.Id_loja = 1
ORDER BY filmes.Nome ASC;

-- Seleccionar um título dos filmes que apenas podem ser alugados na loja nº 1
-- Ordenado alfabéticamente por título
SELECT filmes.Id_filme
FROM filmes
WHERE Id_loja IN(
				SELECT Id_filme
                FROM loja
                WHERE Id_loja = 1
				)
ORDER BY Id_filme ASC;
