Tabela produtos (para exercícios 31-36):
id nome categoria preco estoque
1 Notebook eletronico 3500.00 10
2 Mouse eletronico 89.90 50
3 Cadeira movel 899.00 15
4 Mesa movel 1200.00 8
5 Teclado eletronico 159.90 30
6 Monitor eletronico 1800.00 12
7 Estante movel 450.00 NULL

31. Quantas linhas retorna? Quais são os valores de cada linha?
SELECT categoria, COUNT(*) AS total, ROUND(AVG(preco), 2) AS media
FROM produtos GROUP BY categoria;
-- VAI RETORNAR DUAS LINHAS, COM O TOTAL DE PRODUTOS E A MEDIA DE PREÇO

32. Quais categorias aparecem no resultado? Qual é eliminada e por quê?
SELECT categoria, AVG(preco) AS media
FROM produtos GROUP BY categoria
HAVING AVG(preco) > 1000;

-- O COMANDO EXECUTA A MEDIA DE PREÇO POR CATEGORIA, ELE ELIMINARIA A CATEGORIA MOVEL POR SER MENOR QUE 1000

33. Qual é a média usada como filtro? Quais produtos aparecem?
SELECT nome, preco FROM produtos
WHERE preco > (SELECT AVG(preco) FROM produtos);

-- A MEDUA É DE R$ 1157,00, APENAS 3 PRODUTOS APARECEM, QUE SAO MAIORES QUE A MDEIA, NOTEBOOK, MESA E MONITOR

34. Qual produto aparece? Por que COUNT(estoque) retornaria 6 e não 7 nessa tabela?
SELECT nome, estoque FROM produtos
WHERE estoque IS NULL;

-- APARECERIA NOTEBOOL, MOUSE, CADEIRA, MESA, TECLADO E MONITOR.
-- NAO APARECERIA A ESTANTE, POIS A QUANTIDADE ESTA NULA
-- O COMANDO IS NULL, FAZ ESSA CONDIÇÃ

35. Quantas linhas? Quais valores? Mudaria algo se fosse UNION em vez de UNION ALL?
SELECT 'eletronico' AS cat, MAX(preco) AS maior
FROM produtos WHERE categoria = 'eletronico'
UNION ALL
SELECT 'movel', MAX(preco)
FROM produtos WHERE categoria = 'movel';

-- RETORNARIA 2 LINHAS, QUE SAO O NOTEBOOK NO VALOR DE R$ 3500,00 E MESA NO VALOR DE R$ 1200,00
-- NAO HAVERIA MUDANÇA, POIS NÃO HÁ LINHAS DUPLICADAS

36. Quais nomes aparecem? Algum apareceria duplicado com UNION ALL? Qual?
SELECT nome FROM produtos WHERE categoria = 'eletronico'
UNION
SELECT nome FROM produtos WHERE preco > 1000;


-- RETORNARIA 5 LINHAS, QUE SAO NOTEBOOK, MOUSE, TECLADO, MESA E MONITOR
-- A QUERY TRAS TODOS OS PRODUTOS DA CATEGORIA ELETRONICOS E TAMBÉM OS ITENS QUE SAO ACIMA DE R$ 1000 REAIS

Tabela notas (para exercícios 37-40) — recorte do schema faculdade:
matricula_id avaliacao nota
1 P1 8.50
1 P2 7.00
1 Trabalho 9.00
2 P1 9.00
2 P2 9.50
2 Trabalho 10.00
3 P1 5.00
3 P2 4.50

37. Quais matrículas aparecem no resultado? Qual a média de cada uma?
SELECT matricula_id, ROUND(AVG(nota), 2) AS media
FROM notas
WHERE matricula_id IN (1, 2, 3)
GROUP BY matricula_id
HAVING AVG(nota) < 7;
-- MEDIA MATRICULA 1 -> 8,16
-- MEDIA MATRICULA 2 -> 9,5
-- MEDIA MATRICULA 3 -> 517
-- APARECERÁ APENAS A MATRICULA 3 CUJA A MEDIA É MENOR QUE 7

38. Quantas linhas retorna? Qual o valor de cada linha?
SELECT avaliacao, MIN(nota) AS menor, MAX(nota) AS maior
FROM notas GROUP BY avaliacao;

-- O COMANDO IRA RETORNAR 3 LINHAS
-- CADA AVALIAÇÃO APARECERA UMA VEZ COM A SUA MAIOR E MENOR NOTA
-- P1 MAIOR NOTA 9,00 E MENOR 5,00
-- P2 MAIOR NOTA 9,50 E MENOR 4,5
-- TRABALHO MAIOR NOTA 10 E MENOR 6

39. Qual a média de P1 usada como filtro? Quais matrículas aparecem?
SELECT matricula_id, nota FROM notas
WHERE nota > (SELECT AVG(nota) FROM notas WHERE avaliacao = 'P1')
AND avaliacao = 'P2';

-- A MEDIA DA P1 É DE 8,5
-- APENAS A MATRICULA 2 APARECE, JA QUE É MAIOR QUE É A P1

40. Quantas linhas retorna? Quais nomes? Mudaria com UNION ALL?
SELECT 'acima' AS faixa, matricula_id FROM notas
WHERE nota >= 9
UNION
SELECT 'abaixo', matricula_id FROM notas
WHERE nota < 5;

-- A QUERY RETORNA 3 LINHAS, DUAS QUE ESTAO ACIMA E UMA QUE ESTA ABAIXO

-- ESSA NAO ENTENDI MUITO BEM...

