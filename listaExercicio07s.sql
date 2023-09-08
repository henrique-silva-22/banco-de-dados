SELECT matriculas.curso, COUNT(alunos.id) AS total_de_alunos
FROM matriculas
JOIN alunos ON matriculas.aluno_id = alunos.id
GROUP BY matriculas.curso;
