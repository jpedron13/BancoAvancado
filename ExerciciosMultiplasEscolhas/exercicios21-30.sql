21. Sobre UNION e UNION ALL, analise as afirmativas:
I. UNION ALL elimina duplicatas automaticamente comparando todas as colunas.
II. UNION tem custo maior que UNION ALL porque executa um DISTINCT implícito no resultado.
III. Ambos exigem que os SELECTs tenham a mesma quantidade de colunas e tipos compatíveis.
IV. Se nenhuma linha dos dois SELECTs for igual, UNION e UNION ALL retornam exatamente o mesmo resultado.
a) V – V – V – V
b) F – V – V – V
c) F – V – V – F
d) F – F – V – V
e) V – V – F – V  ----------> RESPOSTA CORRETA, LETRA E


 22. Sobre Views em bancos relacionais, analise as afirmativas:
I. Uma VIEW armazena o resultado da query em disco, funcionando como cache automático.
II. É possível fazer GROUP BY e HAVING em cima de uma VIEW como se fosse tabela.
III. Se a query interna da VIEW faz full table scan, consultar a VIEW também fará full table scan.
IV. Criar um índice diretamente em uma VIEW melhora a performance da consulta no MySQL.
a) V – V – V – F
b) F – V – V – F ----------> RESPOSTA CORRETA, LETRA B
c) F – V – V – V
d) F – V – F – F
e) F – F – V – F


23. Sobre índices em bancos de dados, analise as afirmativas:
I. Um índice composto (A, B) é utilizado pelo banco quando o WHERE filtra apenas pela coluna B.
II. Índices aceleram operações de leitura (SELECT), mas podem tornar INSERT, UPDATE e DELETE mais lentos.
III. A constraint UNIQUE cria automaticamente um índice na coluna, além de impedir valores duplicados.
IV. A estrutura mais comum de índice em bancos relacionais é a B-Tree, que permite buscas em O(log n).
a) F – V – V – V --------> RESPOSTA CORRETA, LETRA A
b) V – V – V – V
c) F – V – F – V
d) F – V – V – F
e) V – F – V – V

24. Sobre o EXPLAIN do MySQL, analise as afirmativas:
I. A coluna 'type' com valor ALL indica que o banco usou um índice para acessar a tabela.
II. A coluna 'key' mostra o nome do índice utilizado; se for NULL, nenhum índice foi usado.
III. A coluna 'rows' mostra o número exato de linhas retornadas pela query.
IV. Rodar EXPLAIN em uma VIEW mostra o plano de execução da query interna expandida.
a) F – V – F – V
b) V – V – F – V
c) F – V – V – V ---------> RESPOSTA CORRETA, LETRA C
d) F – F – F – V
e) V – V – F – F

25. Sobre ACID, BASE e o Teorema CAP, analise as afirmativas:
I. ACID garante que uma transação é atômica: ou executa tudo, ou não executa nada.
II. BASE prioriza disponibilidade e aceita que o dado pode estar temporariamente inconsistente.
III. O Teorema CAP afirma que um sistema distribuído pode garantir Consistência, Disponibilidade e Tolerância a
Partição ao mesmo tempo.
IV. Um banco MySQL rodando em um único servidor não precisa escolher entre C, A e P do Teorema CAP.
a) V – V – F – V
b) V – V – V – V
c) V – F – F – V
d) V – V – F – F -------------> RESPOSTA CORRETA, LETRA D
e) F – V – F – V

26. Pool de conexões. Descreva o problema que o pool de conexões resolve. Explique passo a passo o que
acontece quando uma aplicação abre uma conexão com o banco SEM pool (TCP handshake, autenticação,
alocação de memória, execução, desconexão). Depois explique como o pool otimiza esse processo.
-- POOL DE CONEXÕES REDUZ O CONSUMO DE CPU E MEMORIA DO SERVIDOR
-- E CONTROLA AS CONEXÕES ABERTAS, EVITANDO SOBRECARGAS

27. Índices e B-Tree. Explique o que é uma B-Tree e por que ela é a estrutura padrão de índices em bancos
relacionais. Compare o custo de busca com B-Tree (O(log n)) versus busca sequencial (O(n)). Numa tabela com 1
milhão de linhas, quantas comparações cada abordagem precisaria aproximadamente?
-- INDICES B-TREE REDUZ O NUMERO DE COMPARAÇÕES, OTIMIZANDO MAIS AINDA O BANCO

28. UNION vs UNION ALL — custo interno. Descreva o que o banco faz internamente ao executar cada um.
Explique por que UNION precisa de uma etapa extra (sort ou hash pra eliminar duplicatas) e em quais cenários
essa etapa é desnecessária. Dê um exemplo prático onde usar UNION seria um erro lógico
-- A UTILIZAÇÃO DO UNION ALL, TRAS TODOS OS REGISTROS REFERENCIADOS 
-- SUA PRINCIPAL DIFERENÇA COM O UNION , É QUE A UTILIZAÇÃO DO UNIO, ELIMINA OS REGISTROS DUPLICADOS--

-- EXEMPLO PRATICO
SELECT ID ,NOME FROM CLIENTES_ATIVOS
UNION
SELECT ID, NOME FROM CLIENTES_INATIVOS

-- UTILIZA O UNION PARA RETIRAR POR EXEMPLO, OS CLIENTES QUE ESTAVAM ATIVOS E PASSSARAM A SER INATIVOS

29. Processo de execução de uma query. Descreva as etapas que o banco percorre desde o recebimento de
um SELECT até a entrega do resultado: parsing, binding, otimização (escolha do plano de execução), execução e
fetch. Em qual dessas etapas o índice faz diferença? E o EXPLAIN mostra qual etapa?
-- O INDICE ATUA NA ETAPA DE OTIMIZAÇÃO 
-- O OTIMIZADOR DECIDE SE USA OU NAO O INDICE COM BASE EM ESTATISTICAS

30. Privilégio mínimo e DCL. Explique o princípio de privilégio mínimo aplicado a bancos de dados. Descreva
um cenário real com 3 perfis de acesso (app de leitura, secretaria, DBA) e quais permissões (GRANT) cada um
deveria ter. Explique o risco de usar GRANT ALL PRIVILEGES em produção.
-- PRIVILEGIO MINIMO É APENAS PARA SELECT, SEM PERMISSOES PARA INSERT, UPDATES E DELETE
-- PODE CORRER O RISCO DE OCORRER EM PRODUÇÃO DADOS IMPORTANTES NA BASE

-- continua no proximo script

