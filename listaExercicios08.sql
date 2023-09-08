SELECT produto, AVG(receita) AS media_de_receita
FROM vendas
GROUP BY produto;
