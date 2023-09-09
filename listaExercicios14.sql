SELECT m.curso, a.nome AS aluno
FROM matriculas m
RIGHT JOIN alunos a ON m.aluno_id = a.id;
