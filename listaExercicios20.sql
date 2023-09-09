SELECT produto, COUNT(*) AS quantidade_de_transacoes
FROM vendas
GROUP BY produto
ORDER BY quantidade_de_transacoes DESC
LIMIT 1;
