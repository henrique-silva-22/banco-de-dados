SELECT livros.titulo
FROM livros
JOIN autores ON livros.autor_id = autores.id
WHERE autores.nome = 'J.K. Rowling';
