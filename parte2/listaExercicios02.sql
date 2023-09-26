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
