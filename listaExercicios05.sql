SELECT produto, SUM(receita) AS receita_total FROM vendas GROUP BY produto;
