--1) 
SELECT UPPER(F.NOME), LOWER(D.NOME)
FROM FUNCIONARIO F, DEPENDENTE D
WHERE F.MATRICULA_FUNC=D.MATRICULA_FUNC;

--2)
SELECT LOGRADOURO || '-' || BAIRRO || '-' || CIDADE || '-' || UF
FROM FUNCIONARIO;

--3)
SELECT TRIM(NOME_CARGO)
FROM CARGO
WHERE SALARIO>2000;

--4)
SELECT Nome FROM FUNCIONARIO 
WHERE LENGTH(Nome) = (SELECT MAX(LENGTH(Nome)) FROM FUNCIONARIO);

--5)
SELECT REPLACE(NOME_CARGO,'ANALIST','ANALISTA DE SISTEMAS')
FROM CARGO;

--6)
SELECT MATRICULA, NOME, DATA_NASCIMENTO,
	CASE UF 
		WHEN 'RJ' THEN 'RIO DE JANEIRO'
		WHEN 'SP' THEN 'SÃO PAULO'
		WHEN 'MG' THEN 'MINAS GERAIS'
		WHEN 'PR' THEN 'PARANÁ'		
	END "UNIDADE_FEDERATIVA"
FROM FUNCIONARIO;

SELECT MATRICULA, NOME, DATA_NASCIMENTO,
	   DECODE(UF,'RJ','RIO DE JANEIRO','SP','SÃO PAULO','MG','MINAS GERAIS',
		         'PR','PARANÁ','OUTRO ESTADO') as UNIDADE_FEDERATIVA
FROM FUNCIONARIO;

--7)
SELECT F.NOME, 'R$'||TO_CHAR(TRUNC(C.SALARIO),'L999G999D99')
FROM FUNCIONARIO F, CARGO C
WHERE F.CODIGO_CARGO = C.CODIGO_CARGO;

--8)
SELECT   D.NOME_DEPARTAMENTO, AVG(C.SALARIO)
FROM     DEPARTAMENTO D, CARGO C, FUNCIONARIO F
WHERE    D.SIGLA_DEPARTAMENTO = F.SIGLA_DEPARTAMENTO
AND      F.CODIGO_CARGO = C.CODIGO_CARGO
GROUP BY D.NOME_DEPARTAMENTO
ORDER BY D.NOME_DEPARTAMENTO;

--9)
SELECT TO_CHAR(sysdate,'mm-dd-yyyy hh24:mi') FROM DUAL;

--10)
SELECT P.NOME_PROJETO, MONTHS_BETWEEN(A.DATA_INICIO, A.DATA_FIM)
FROM   PROJETO P, ALOCACAO_FUNC_PROJETO A
WHERE  P.CODIGO_PROJETO = A.CODIGO_PROJETO
AND    DATA_FIM IS NOT NULL;

--11)
SELECT P.Nome_Projeto, LAST_DAY(A.Data_Fim) 
FROM PROJETO P, ALOCACAO_FUNC_PROJETO 
WHERE P.Codigo_Projeto = A.Codigo_Projeto 
AND A.Data_Fim IS NOT NULL;

--12)
SELECT P.Nome_Projeto, (A.Data_Fim - A.Data_Inicio) as QTD_DIAS
FROM PROJETO P, ALOCACAO_FUNC_PROJETO 
WHERE P.Codigo_Projeto = A.Codigo_Projeto 
AND A.Data_Fim IS NOT NULL;

--13)
SELECT P.Nome_Projeto, EXTRACT(YEAR FROM A.Data_Inicio) 
FROM PROJETO P, ALOCACAO_FUNC_PROJETO 
WHERE P.Codigo_Projeto = A.Codigo_Projeto;

--14)
SELECT F.NOME, 
	   TRANSLATE(TO_CHAR(F.CPF,'999,999,999.99'),',.','.-') AS CPF, 
	   TRANSLATE(TO_CHAR(F.IDENTIDADE,'99,999,999.9'),',.','.-') AS IDENTIDADE, 
	   'R$'||TO_CHAR(C.SALARIO,'999G999D99') AS SALARIO, 
	   F.LOGRADOURO||','||F.BAIRRO||','||F.CIDADE||','||F.UF AS ENDERECO
FROM FUNCIONARIO F, CARGO C
WHERE F.CODIGO_CARGO = C.CODIGO_CARGO;

--15)
SELECT F.NOME, NVL(D.NOME,'Não possui filhos.') as DEPENDENTE
FROM FUNCIONARIO F, DEPENDENTE D
WHERE F.MATRICULA_FUNC = D.MATRICULA_FUNC;

--16)
SELECT F.NOME 
FROM   FUNCIONARIO F, CARGO C
WHERE  F.CODIGO_CARGO = C.CODIGO_CARGO
AND    C.SALARIO = SELECT MAX(SALARIO) FROM CARGO
UNION
SELECT F.NOME 
FROM   FUNCIONARIO F, CARGO C
WHERE  F.CODIGO_CARGO = C.CODIGO_CARGO
AND    C.SALARIO = SELECT MIN(SALARIO) FROM CARGO;

--17)
SELECT F.NOME, COUNT(A.CODIGO_PROJETO)
FROM   FUNCIONARIO F, ALOCACAO_FUNC_PROJETO A
WHERE  F.MATRICULA_FUNC = A.MATRICULA_FUNC 
AND    TO_DATE(DATA_INICIO,'YYYY') >= '2000'
GROUP BY F.NOME
ORDER BY F.NOME;

--18)
SELECT SUM(C.SALARIO) as total_em_reais, 
	   SUM(C.SALARIO) * (SELECT TAXA FROM COTACAO WHERE SIGLA_MOEDA = 'U$')
	   as total_em_dolar, 
FROM   CARGO C, FUNCIONARIO F
WHERE  C.CODIGO_CARGO = F.CODIGO_CARGO;

--19)
SELECT NOME
FROM FUNCIONARIO
WHERE SIGLA_DEPARTAMENTO = (SELECT SIGLA_DEPARTAMENTO
							  FROM FUNCIONARIO
							 WHERE NOME='João da Silva Ribeiro');

--20)
SELECT NOME
FROM FUNCIONARIO F, ALOCACAO_FUNC_PROJ A
WHERE F.MATRICULA_FUNC = A.MATRIUCLA_FUNC
AND   F.MATRICULA_FUNC IN (SELECT A2.MATRICULA_FUNC 
						   FROM   ALOCACAO_FUNC_PROJETO A2
						   WHERE  TO_CHAR(A2.DATA_INICIO,'YYYY') >= '2014'
						   AND    TO_CHAR(A2.DATA_FIM,'YYYY') <= '2014')

