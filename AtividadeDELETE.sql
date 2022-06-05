--1) Exclua o cargo “Analista Pleno”.

DELETE FROM CARGO WHERE NOME_CARGO = 'ANALISTA PLENO';

--2) Exclua os dependentes que nasceram antes de 01/01/1990.

DELETE FROM DEPENDENTE WHERE DATA_NASCIMENTO <= '01/01/1990';

--3) Exclua os dependentes do funcionário CARLOS ALBERTO DA ROCHA.

DELETE FROM DEPENDENTE
WHERE MATRICULA_FUNC = (SELECT MATRICULA_FUNC FROM FUNCIONARIO
					     WHERE NOME = 'CARLOS ALBERTO ROCHA');

--4) Exclua os projetos de custo previsto acima de 300.000 e sem departamento responsável.

 DELETE FROM PROJETO 
 WHERE 	CUSTO_PREVISTO > 300000 
 AND  	SIGLA_DEPARTAMENTO_RESP IS NULL;

--5) Exclua os funcionários que nunca atuaram em projetos.

--Solução 1
DELETE FROM FUNCIONARIO
WHERE MATRICULA_FUNC NOT IN (SELECT DISTINCT MATRICULA_FUNC FROM ALOCACAO_FUNC_PROJETO);

--Solução 2
DELETE FROM FUNCIONARIO
WHERE NOT EXISTS (SELECT * FROM ALOCACAO_FUN_PROJETO
				  WHERE ALOCACAO_FUNC_PROJETO.MATRICULA_FUNC = FUNCIONARIO.MATRICULA_FUNC);
				  


-- DESAFIO UPDATE
/* 10) É preciso criar a coluna DATA_ULT_EXAME na tabela Funcionário. 
Esta coluna deve ser de preenchimento obrigatório, ou seja, NOT NULL. 
Porém, o SGBD só permite criar novas colunas NOT NULL se estiver sem 
registros (“vazia”) e não é o caso, pois a tabela em questão já possui 
736 registros. Liste abaixo o passo a passo dos comandos para resolver 
esta solicitação. */

--PASSO 1
ALTER TABLE FUNCIONARIO ADD (DATA_ULT_EXAME DATE NULL);
--PASSO 2
UPDATE FUNCIONARIO SET DATA_ULT_EXAME = SYSDATE;
COMMIT;
--PASSO 3
ALTER TABLE FUNCIONARIO MODIFY DATA_ULT_EXAME NOT NULL;


-- DESAFIO DELETE
-- 6) Exclua os dependentes com mais de 18 anos de idade.

-- Solução 1
DELETE FROM DEPENDENTE 
WHERE (SYSDATE-DATA_NASCIMENTO)/365 > 18;				  

-- Solução 2
DELETE FROM DEPENDENTE 
WHERE TRUNC((MONTHS_BETWEEN(SYSDATE,TO_DATE(DATA_NASCIMENTO,'DD/MM/YYYY')))/12) > 18;

/* 7) Há funcionários que foram demitidos e precisam ser excluídos, porém há 
diversos registros sobre a atuação dos mesmos em seus respectivos projetos. 
Portanto, caso sejam excluídos, todos os registros vinclulados a estes funcionários
 também serão, causando perda de dados históricos e afetando os relatórios da 
 empresa. Qual seria a forma mais adequada para resolver este problema? Descreva
 a solução, bem como os comandos passo a passo. */

ALTER TABLE FUNCIONARIO ADD ATIVO CHAR(1) DEFAULT 'S' NOT NULL; 

Para cada funcionário demitido, será preciso executar o comando update trocando 
a coluna INATIVO = 'S' para 'N'.
