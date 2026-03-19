-- 1. Liste todos os nomes de alunos e professores numa única coluna, com uma coluna extra indicando 'ALUNO' ou
'PROFESSOR'. Use UNION ALL.

select nome as nome, 'ALUNO' 
from alunos
union all
select nome as nome, 'PROFESSOR'
from professores;

-- 2. Reescreva o exercício 1 usando UNION (sem ALL). O resultado muda? Explique por quê no comentário SQL
R:NAO HOUVE DIFERENÇA POIS NÃO TEM NOMES DUPLICADOS ENTRE ALUNOS E PROFESSORES*/

 -- 3. Monte uma query que retorne os nomes das avaliações distintas que existem na tabela notas. Faça de duas formas: com DISTINCT e com UNION

select distinct avaliacao
from notas

select avaliacao
from notas
union
select avaliacao
from notas;

-- 4. Crie uma VIEW chamada vw_boletim que mostre: nome do aluno, nome da disciplina, avaliação e nota. Use os JOINs necessários (notas → matriculas → alunos, matriculas → turmas → disciplinas).

create or replace view vw_boletim as
select a.nome as aluno, d.nome as disciplina, n.avaliacao, n.nota, t.semestre
from notas n
join matriculas m on m.id = n.matricula_id
join alunos a on a.id = m.aluno_id
join turmas t on t.id = m.turma_id
join disciplinas d on d.id = t.disciplina_id; 

-- 5. Usando a vw_boletim, escreva uma query que retorne a média de cada aluno por disciplina.

select aluno, disciplina, ROUND(AVG(nota), 2) as media from vw_boletim 
GROUP BY aluno, disciplina;

-- 6. Crie uma VIEW chamada vw_alunos_seguros que mostre apenas id e nome dos alunos (escondendo CPF, email, data_nascimento).

create or replace view vw_alunos_seguros as
select id, nome from alunos

-- 7. Crie um usuário 'relatorio'@'localhost' com senha 'rel123'. Dê permissão de SELECT apenas na view vw_boletim. Depois rode SHOW GRANTS pra confirmar.

CREATE USER 'relatorio'@'localhost' IDENTIFIED BY 'senha123';
GRANT SELECT ON vw_boletim TO 'relatorio'@'localhost';

show grants

-- 8. Revogue todas as permissões do usuário 'relatorio' e depois exclua o usuário. 
REVOKE SELECT ON faculdade.* FROM 'relatorio'@'localhost';
SELECT User, Host FROM mysql.user;
drop user 'relatorio'@'localhost';

-- 9. Crie um índice simples na coluna nome da tabela professores. 

create index idx_professores on professores(nome);

select nome, cpf, titulacao 
from professores
where nome = 'Lucas Martins';


show index from professores

-- 10. Crie um índice composto na tabela notas nas colunas (matricula_id, avaliacao). Depois rode SHOW INDEX
FROM notas pra confirmar.

CREATE INDEX idx_notas_matric_aval ON notas(matricula_id, avaliacao);
SELECT * FROM notas WHERE matricula_id = 5 AND avaliacao = 'P1';

-- *11. Liste todos os índices da tabela alunos e identifique quais foram criados automaticamente pelas constraints
UNIQUE
 
show index from alunos;
/* Analisando o retorno da query, acredito que as 3 colunas foram criadas automaticamentes pelas constraints unique
isto é, cpf, email e id.*/

-- 12. Rode EXPLAIN em: SELECT * FROM alunos WHERE cpf = '100.000.000-01'; — Anote type, rows e key. OUNIQUE do CPF foi usado?

EXPLAIN SELECT * FROM alunos WHERE cpf = '100.000.000-01';
-- Type: const
-- Rows: 1
-- Key: CPF
## Sim, o UNIQUE do CPF foi usado, ja que apenas uma linha foi retornada

-- 13. Rode EXPLAIN em: SELECT * FROM notas WHERE avaliacao = 'P1'; — Crie um índice na coluna avaliacao e rode EXPLAIN de novo. O que mudou em type e rows?

create index idx_avaliacao on notas(avaliacao)
explain SELECT * FROM notas WHERE avaliacao = 'P1';

## Antes de criar a indice, rows estava em 54 e type estava all
## Após a indice, rows ficou 22 e type ficou como ref.

-- 14. Rode EXPLAIN na query: SELECT * FROM vw_boletim WHERE aluno = 'Mariana Lima'; — O EXPLAIN mostra a query da view expandida ou não?
EXPLAIN SELECT * FROM vw_boletim WHERE aluno = 'Mariana Lima';

## SIM, MOSTRA ESTENDIDA, E MOSTRA A INDICE CRIADA TAMBÉM.alter

-- 15. Escreva uma query que retorne os alunos cuja nota em qualquer avaliação é maior que a média geral de notas. Use subquery no WHERE.

SELECT A.NOME, N.NOTA, N.AVALIACAO 
FROM ALUNOS AS A
JOIN NOTAS AS N 
ON N.ID = A.ID
WHERE nota > (SELECT AVG(nota) FROM notas);

-- 16. Escreva uma query que retorne os nomes dos professores que NÃO têm nenhuma turma atribuída. Use NO EXISTS.

SELECT p.nome
FROM professores p
WHERE NOT EXISTS (
    SELECT 1
    FROM turmas t
    WHERE t.professor_id = p.id
    );
    
    -- 17. Usando subquery no FROM (tabela derivada), liste os alunos com média geral abaixo de 6.0
    
SELECT a.nome, m.media
FROM alunos a
JOIN (
    SELECT mat.aluno_id, AVG(n.nota) AS media
    FROM notas n
    JOIN matriculas mat ON n.matricula_id = mat.id
    GROUP BY mat.aluno_id
) m ON a.id = m.aluno_id
WHERE m.media < 6.0;

## SENDO SINCERO, ESSA FIZ COM AJUDA DO CHATGPT, NAO ESTAVA CONSEGUINDO DE JEITO MANEIRA, AS OUTRAS EU SABIA UM POUCO E OUTRO POUCO CONSULTEI NO CHAT TAMBÉM...KK

-- 18. Reescreva o exercício 15 usando JOIN em vez de subquery. Compare os resultados. Rode EXPLAIN em ambas.


explain SELECT A.NOME, N.NOTA, N.AVALIACAO 
FROM ALUNOS AS A
JOIN NOTAS AS N 
ON N.ID = A.ID
WHERE nota > (SELECT AVG(nota) FROM notas);

## COM O JOIN ELE RETORNOU MAIS LINHAS, 54, JA NA OUTRA RETORNOU APENAS 15

explain SELECT a.nome, n.nota, n.avaliacao
FROM alunos a
JOIN matriculas m ON a.id = m.aluno_id
JOIN notas n ON n.matricula_id = m.id
WHERE n.nota > (SELECT AVG(nota) FROM notas);

-- 19. Escreva uma query que mostre, por turma_id, a quantidade de matrículas com status 'ativa' e a quantidade total. Use GROUP BY
SELECT turma_id,
       SUM(CASE WHEN status = 'ativa' THEN 1 ELSE 0 END) AS qtd_ativas,
       COUNT(*) AS qtd_total
FROM matriculas
GROUP BY turma_id;

-- 20. Liste as disciplinas cuja média geral de notas é menor que 7. Use JOIN até disciplinas e HAVING.

SELECT d.nome AS disciplina, AVG(n.nota) AS media_geral
FROM disciplinas d
JOIN turmas t ON d.id = t.disciplina_id
JOIN matriculas m ON t.id = m.turma_id
JOIN notas n ON n.matricula_id = m.id
GROUP BY d.id, d.nome
HAVING AVG(n.nota) < 7;

## AGORA SÓ COMITAR E SUBIR PRO GITHUB..


