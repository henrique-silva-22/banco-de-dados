SELECT livros.titulo AS livro, autores.nome AS autor
FROM livros
JOIN autores ON livros.autor_id = autores.id;
