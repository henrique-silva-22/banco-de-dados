1) listagem de altures:
    
DELIMITER //
CREATE PROCEDURE sp_ListarAutores()
BEGIN
    SELECT * FROM Autor;
END //
DELIMITER ;

2)  Livros por Categoria:
DELIMITER //
CREATE PROCEDURE sp_LivrosPorCategoria(IN categoriaNome VARCHAR(100))
BEGIN
    SELECT Livro.Titulo
    FROM Livro
    INNER JOIN Categoria ON Livro.Categoria_ID = Categoria.Categoria_ID
    WHERE Categoria.Nome = categoriaNome;
END //
DELIMITER ;

-- Teste a stored procedure
CALL sp_LivrosPorCategoria('Romance');

3) Contagem de Livros por Categoria:

DELIMITER //
CREATE PROCEDURE sp_ContarLivrosPorCategoria(IN categoriaNome VARCHAR(100))
BEGIN
    SELECT COUNT(*) AS TotalLivros
    FROM Livro
    INNER JOIN Categoria ON Livro.Categoria_ID = Categoria.Categoria_ID
    WHERE Categoria.Nome = categoriaNome;
END //
DELIMITER ;

-- Teste a stored procedure
CALL sp_ContarLivrosPorCategoria('Romance');

4)Verificação de Livros por Categoria:

DELIMITER //
CREATE PROCEDURE sp_VerificarLivrosCategoria(IN categoriaNome VARCHAR(100))
BEGIN
    DECLARE categoriaCount INT;
    SELECT COUNT(*) INTO categoriaCount
    FROM Livro
    INNER JOIN Categoria ON Livro.Categoria_ID = Categoria.Categoria_ID
    WHERE Categoria.Nome = categoriaNome;

    IF categoriaCount > 0 THEN
        SELECT 'Categoria possui livros.' AS Status;
    ELSE
        SELECT 'Categoria não possui livros.' AS Status;
    END IF;
END //
DELIMITER ;

-- Teste a stored procedure
CALL sp_VerificarLivrosCategoria('Romance');
CALL sp_VerificarLivrosCategoria('Esportes');

5)Listagem de Livros por Ano:

DELIMITER //
CREATE PROCEDURE sp_LivrosAteAno(IN ano INT)
BEGIN
    SELECT Titulo
    FROM Livro
    WHERE Ano_Publicacao <= ano;
END //
DELIMITER ;

-- Teste a stored procedure
CALL sp_LivrosAteAno(2010);

6)Extração de Títulos por Categoria:

DELIMITER //
CREATE PROCEDURE sp_TitulosPorCategoria(IN categoriaNome VARCHAR(100))
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE livroTitulo VARCHAR(255);

    DECLARE cur CURSOR FOR
    SELECT Livro.Titulo
    FROM Livro
    INNER JOIN Categoria ON Livro.Categoria_ID = Categoria.Categoria_ID
    WHERE Categoria.Nome = categoriaNome;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO livroTitulo;
        IF done THEN
            LEAVE read_loop;
        END IF;
        SELECT livroTitulo;
    END LOOP;

    CLOSE cur;
END //
DELIMITER ;

-- Teste a stored procedure
CALL sp_TitulosPorCategoria('Romance');
