/*1. Liste todos os nomes de alunos e professores numa única coluna, com uma coluna extra indicando 'ALUNO' ou
'PROFESSOR'. Use UNION ALL.*/

select nome as nome, 'ALUNO' 
from alunos
union all
select nome as nome, 'PROFESSOR'
from professores;

/*2. Reescreva o exercício 1 usando UNION (sem ALL). O resultado muda? Explique por quê no comentário SQL
R:NAO HOUVE DIFERENÇA POIS NÃO TEM NOMES DUPLICADOS ENTRE ALUNOS E PROFESSORES*/

 /*3. Monte uma query que retorne os nomes das avaliações distintas que existem na tabela notas. Faça de duas
formas: com DISTINCT e com UNION*/

select distinct avaliacao
from notas

select avaliacao
from notas
union
select avaliacao
from notas;

/*4. Crie uma VIEW chamada vw_boletim que mostre: nome do aluno, nome da disciplina, avaliação e nota. Use
os JOINs necessários (notas → matriculas → alunos, matriculas → turmas → disciplinas).*/

create or replace view vw_boletim as
select a.nome as aluno, d.nome as disciplina, n.avaliacao, n.nota, t.semestre
from notas n
join matriculas m on m.id = n.matricula_id
join alunos a on a.id = m.aluno_id
join turmas t on t.id = m.turma_id
join disciplinas d on d.id = t.disciplina_id; 

/*5. Usando a vw_boletim, escreva uma query que retorne a média de cada aluno por disciplina.*/

select aluno, disciplina, ROUND(AVG(nota), 2) as media from vw_boletim 
GROUP BY aluno, disciplina;

/*6. Crie uma VIEW chamada vw_alunos_seguros que mostre apenas id e nome dos alunos (escondendo CPF,
email, data_nascimento).*/

create or replace view vw_alunos_seguros as
select id, nome from alunos

/*7. Crie um usuário 'relatorio'@'localhost' com senha 'rel123'. Dê permissão de SELECT apenas na view
vw_boletim. Depois rode SHOW GRANTS pra confirmar.*/