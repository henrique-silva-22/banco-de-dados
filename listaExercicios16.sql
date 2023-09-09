SELECT autores.nome AS autor, COUNT(*) AS quantidade_de_livros
FROM autores
JOIN livros ON autores.id = livros.autor_id
GROUP BY autores.nome
ORDER BY quantidade_de_livros DESC
LIMIT 1;
