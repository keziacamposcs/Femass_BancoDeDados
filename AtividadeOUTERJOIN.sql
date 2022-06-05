
--1) Listar os funcionários, seus respectivos cargos e departamentos. 

-- Padrão ANSI
select f.nome, c.nome_cargo, d.nome_departamaento
from funcionario f inner join cargo c on f.codigo_cargo = c.codigo_cargo 
     inner join departamento d on f.sigla_departamento = d.sigla_departamento;

/*2) Listar todos os funcionários e seus respectivos dependentes. 
Os que não tiverem dependentes dever o aparecer da mesma forma.*/

-- Padrão SGBD
Select F.nome, D.nome
From Funcionario F, Dependente D
Where F.Matricula_Func = D.Matricula_Func(+);

-- Padrão ANSI
Select F.nome, D.nome
From Funcionario F LEFT OUTER JOIN Dependente D ON F.Matricula = D.Matricula;

-- Padrão ANSI (opção 2)
Select F.nome, NVL(D.nome,'Não possui filhos.')
From Funcionario F LEFT OUTER JOINDependente D ON F.Matricula = D.Matricula;


--3) Listar o nome do funcionário e o nome dos respectivos dependentes acima de 10 anos.

SELECT F.NOME ,D.NOME 
FROM FUNCIONARIOF NATURAL JOIN DEPENDENTE D 
WHERE (trunc((months_between(sysdate, to_date(d.data_nascimento,'dd/mm/yyyy')))/12) > 10;

--4) Listar o nome dos supervisores e seus respectivos subordinados.

SELECT S.NOME, F.NOME
FROM   FUNCIONARIO S, FUNCIONARIO F
WHERE  S.MATRICULA_SUPERVISOR = F.MATRICULA_FUNC;

SELECT S.NOME, F.NOME
FROM FUNCIONARIO S INNER JOIN FUNCIONARIO F ON S.MATRICULA_SUPERVISOR = F.MATRICULA_FUNC;

--5) Listar os funcionários e seus respectivos projetos iniciados a partir do ano 2010.

SELECT F.NOME, P.NOME
FROM FUNCIONARIO F, ALOCACAO_FUNC_PROJETO AF, PROJETO P
WHERE F.MATRICULA_FUNC = AF.MATRICULA_FUNC
AND AF.CODIGO_PROJETO = P.CODIGO_PROJETO
AND TO_DATE(AF.DATA_INICIO,'YYYY') >= '2010';

SELECT F.NOME, P.NOME,
FROM FUNCIONARIO F INNER JOIN ALOCACAO_FUNC_PROJETO AF ON 
F.MATRICULA_FUNC = AF.MATRICULA_FUNC INNER JOIN PROJETO P USING (CODIGO_PROJETO)
WHERE to_date(AF.DATA_INICIO,'YYYY') = '2010';

--6) Listar todos os funcionários e seus projetos independentemente se 
estão alocados em projeto ou não.

--SGBD
SELECT F.NOME, P.NOME_PROJETO
FROM FUNCIONARIO F, ALOCACAO_FUNC_PROJETO A, PROJETO P
WHERE F.MATRICULA_FUNC = A.MATRICULA_FUNC AND P.CODIGO_PROJETO = A.CODIGO_PROJETO(+);

--7) Listar os projetos e seus respectivos departamentos responsáveis.

--ANSI
SELECT P.NOME, D.NOME_DEPARTAMENTO
FROM PROJETO P INNER JOIN DEPARTAMENTO D
ON P.SIGLA_DEPARTAMENTO_RESP = D.SIGLA_DEPARTAMENTO;

--SGBD
SELECT P.NOME, D.NOME_DEPARTAMENTO
FROM PROJETO P, DEPARTAMENTO D
WHERE P.SIGLA_DEPARTAMENTO_RESP = D.SIGLA_DEPARTAMENTO;


/*8) Listar todos os projetos e seus departamentos responsáveis. 
Os projetos sem responsáveis deverão ser listados com o texto "SEM RESPONSÁVEL".*/

Select P.NOME_PROJETO, NVL(D.NOME_DEPARTAMENTO,'Não possui responsável'.)
From PROJETO P LEFT OUTER JOIN DEPARTAMENTO D on P.SIGLA_DEPARTAMENTO_RESP = D.SIGLA_DEPARTAMENTO;

--9) Listar os funcionários, o cargo, o departamento e os projetos em que eles 
atuam ainda em andamento.

SELECT     F.NOME, C.NOME_CARGO, D.NOME, P.NOME
FROM       FUNCIONARIO F, CARGO C, DEPARTAMENTO D, ALOCACAO_FUNC_PROJETO A, PROJETO P
WHERE      F.CODIGO_CARGO = C.CODIGO_CARGO
AND        F.SIGLA_DEPARTAMENTO = D.SIGLA_DEPARTAMENTO
AND        F.MATRICULA_FUNC = A.MATRICULA_FUNC
AND        A.CODIGO_PROJETO = P.CODIGO_PROJETO
AND        A.DATA_FIM IS NULL;

--10) Listar todos os projetos e todos os departamentos. 
Tanto os projetos sem departamento responsável quanto os departamentos sem projetos dever o ser listados.

--ANSI
SELECT p.nome,d.nome_departamento
FROM projeto p FULL OUTER JOIN departamento d
ON p.sigla_departamento_resp = d.sigla_departamento;

--SGBD
SELECT p.nome,d.nome_departamento
FROM projeto p, departamento d
WHERE p.sigla_departamento_resp = d.sigla_departamento(+)
UNION
SELECT p.nome,d.nome_departamento
FROM projeto p, departamento d
WHERE p.sigla_departamento_resp(+) = d.sigla_departamento;


--11) Quais questões acima poderiam ser resolvidos com NATURAL JOIN?
1,3,5 e 9.