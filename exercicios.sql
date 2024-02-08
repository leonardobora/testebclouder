-- 1. Gere uma lista contendo nome e sobrenome dos vendedores da cidade de Curitiba
SELECT nome, sobrenome
FROM VENDEDORES
WHERE cidade = 'Curitiba';

--2. Gere uma lista com a quantidade de vendedores em cada cidade

SELECT cidade, COUNT(*) as quantidade_vendedores
FROM VENDEDORES
GROUP BY cidade;

--3. Gere uma lista com todos os vendedores que tiveram vendas após o 31/12/2023

SELECT DISTINCT VENDEDORES.nome, VENDEDORES.sobrenome
FROM VENDEDORES
INNER JOIN VENDAS ON VENDEDORES.id = VENDAS.vendedor
WHERE VENDAS.data > '2023-12-31';

--4. Acrescente na lista gerada no ponto 1 a quantidade de notas fiscais de venda e devolução que tiveram no mês 
de janeiro de 2024

SELECT VENDEDORES.nome, VENDEDORES.sobrenome, 
       COUNT(DISTINCT VENDAS.nfVenda) AS qtd_vendas_jan_2024,
       COUNT(DISTINCT DEVOLUCOES.nfDevolucao) AS qtd_devolucoes_jan_2024
FROM VENDEDORES
LEFT JOIN VENDAS ON VENDEDORES.id = VENDAS.vendedor AND VENDAS.data BETWEEN '2024-01-01' AND '2024-01-31'
LEFT JOIN DEVOLUCOES ON VENDEDORES.id = DEVOLUCOES.vendedor AND DEVOLUCOES.data BETWEEN '2024-01-01' AND '2024-01-31'
WHERE VENDEDORES.cidade = 'Curitiba'
GROUP BY VENDEDORES.nome, VENDEDORES.sobrenome;

--5. Gere uma lista com todos os vendedores da empresa e seu resultado total (vendas - devoluções) e ordene eles 
do maior para o menor resultado

SELECT VENDEDORES.nome, VENDEDORES.sobrenome, 
       SUM(VENDAS.valor) - COALESCE(SUM(DEVOLUCOES.valor), 0) AS resultado_total
FROM VENDEDORES
LEFT JOIN VENDAS ON VENDEDORES.id = VENDAS.vendedor
LEFT JOIN DEVOLUCOES ON VENDEDORES.id = DEVOLUCOES.vendedor
GROUP BY VENDEDORES.nome, VENDEDORES.sobrenome
ORDER BY resultado_total DESC;

-- Exercício 6 respondido em um .txt separado.