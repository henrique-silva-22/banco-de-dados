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

7)Adição de Livro com Tratamento de Erros:

DELIMITER //
CREATE PROCEDURE sp_AdicionarLivro(IN titulo VARCHAR(255), IN editoraID INT, IN anoPublicacao INT, IN numPaginas INT, IN categoriaID INT)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Erro ao adicionar o livro. Verifique os parâmetros.' AS Resultado;
    END;

    START TRANSACTION;

    INSERT INTO Livro (Titulo, Editora_ID, Ano_Publicacao, Numero_Paginas, Categoria_ID)
    VALUES (titulo, editoraID, anoPublicacao, numPaginas, categoriaID);

    COMMIT;
    SELECT 'Livro adicionado com sucesso.' AS Resultado;
END //
DELIMITER ;

-- Teste a stored procedure
CALL sp_AdicionarLivro('O Novo Livro', 1, 2022, 250, 1);
CALL sp_AdicionarLivro('A Jornada', 1, 2000, 320, 1); 

8) Autor mais antigo:

DELIMITER //
CREATE PROCEDURE sp_AutorMaisAntigo()
BEGIN
    SELECT CONCAT(Nome, ' ', Sobrenome) AS AutorMaisAntigo
    FROM Autor
    WHERE Data_Nascimento = (SELECT MIN(Data_Nascimento) FROM Autor);
END //
DELIMITER ;

-- Teste a stored procedure
CALL sp_AutorMaisAntigo();

9) Documentação e Comentários:

DELIMITER //
CREATE PROCEDURE sp_LivrosPorCategoria(IN categoriaNome VARCHAR(100))
BEGIN
    /* Esta stored procedure lista os títulos dos livros que pertencem a uma categoria específica.
       Parâmetros:
       - categoriaNome: o nome da categoria desejada.
    */

    SELECT
DELIMITER ;

10)Livros e Seus Autores:

DELIMITER //
CREATE PROCEDURE sp_LivrosESeusAutores()
BEGIN
    SELECT Livro.Titulo, CONCAT(Autor.Nome, ' ', Autor.Sobrenome) AS Autor
    FROM Livro
    INNER JOIN Autor_Livro ON Livro.Livro_ID = Autor_Livro.Livro_ID
    INNER JOIN Autor ON Autor_Livro.Autor_ID = Autor.Autor_ID;
END //
DELIMITER ;

-- Teste a stored procedure
CALL sp_LivrosESeusAutores();
