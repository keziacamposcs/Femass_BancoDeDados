--1) Altere o cargo “Vendedor” para “Representante Comercial”.

UPDATE CARGO
SET NOME_CARGO = 'REPRESENTANTE COMERCIAL'
WHERE NOME_CARGO = 'VENDEDOR';

-- 2) Aplique um aumento de salário em 10% para os engenheiros.

UPDATE CARGO
SET SALARIO = SALARIO * 1.10
WHERE NOME_CARGO = 'ENGENHEIRO';

--3) Altere a data de nascimento do funcionário de matrícula 34732 para 10/09/1978.

UPDATE FUNCIONARIO
SET DATA_NASCIMENTO = '10/09/1978'
WHERE MATRICULA_FUNC = 34732;

-- 4) Altere o bairro e a cidade de todos os funcionários que residem no CEP 25890010 para “Ouro Verde” e “Rio das Ostras” respectivamente.

UPDATE 	FUNCIONARIO
SET 	BAIRRO = 'OURO VERDE', CIDADE = 'RIO DAS OSTRAS'
WHERE 	CEP = 25890010;

-- 5) O funcionário “Carlos Alberto da Rocha” foi transferido para o departamento TI, atualize seu cadastro.

UPDATE FUNCIONARIO
SET    SIGLA_DEPARTAMENTO = 'TI'
WHERE  NOME = 'CARLOS ALBERTO DA ROCHA';

UPDATE FUNCIONARIO
SET    SIGLA_DEPARTAMENTO = (SELECT SIGLA_DEPARTAMENTO FROM DEPARTAMENTO
							  WHERE NOME_DEPARTAMENTO = 'TECNOLOGIA DA INFORMACAO')
WHERE  NOME = 'CARLOS ALBERTO DA ROCHA';

/* 6) Troque a data de início da atuação em projeto para 01/03/2013 para todos 
    os funcionários que iniciaram em 29/02/2013 e ainda não finalizaram. */

UPDATE 	ALOCACAO_FUNC_PROJETO
SET 	DATA_INICIO = '01/03/2013'
WHERE 	DATA_INICIO = '29/02/2013' 
AND 	DATA_FIM IS NULL;

/* 7) Todos os funcionários do sexo masculino residentes em Macaé foram 
	  transferidos para o departamento de engenharia. Atualize-os. */

UPDATE 	FUNCIONARIO
SET 	SIGLA_DEPARTAMENTO = 'ENG'
WHERE 	SEXO = 'M'
AND 	CIDADE = 'MACAE';

/* 8) Todos os projetos cujo custo previsto é superior a 10.000,00 deve ser 
	  de responsabilidade do departamento Administração. */

UPDATE 	PROJETO
SET 	SIGLA_DEPARTAMENTO_RESP = 'ADM'
WHERE 	CUSTO_PREVISTO > 10000;

/* 9) O supervisor de matrícula 386 acabou de assumir o departamento de Marketing.
	  Atualize a base de dados. */
	  
UPDATE 	FUNCIONARIO
SET 	MATRICULA_SUPERVISOR = 386
WHERE 	SIGLA_DEPARTAMENTO = (SELECT SIGLA_DEPARTAMENTO FROM DEPARTAMENTO
							   WHERE NOME_DEPARTAMENTO = 'MARKETING');
