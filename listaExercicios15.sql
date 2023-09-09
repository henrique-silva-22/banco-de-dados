SELECT a.nome AS aluno, m.curso
FROM alunos a
INNER JOIN matriculas m ON a.id = m.aluno_id;
