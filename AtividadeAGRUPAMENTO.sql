-- Query de agrupamento

-- Exemplo de uma informação agrupada

Vendedor		Ano			Total_de_Vendas
------------	------		---------------
João Bastos		2020		358.540,00
				2019		478.900,00
				2018		512.300,00		
Carla Santos	2020		890.330,00
				2019		991.223,00
				2018		927.100,00
Ana Beatriz		2020		228.400,00
				2019		338.600,00
				2018		293,500,00
				
-- Funções mais utilizadas
MAX		--> Retorna o valor máximo da coluna	
MIN 	--> Retorna o valor mínimo da coluna
COUNT	--> Retorna a quantidade total da coluna
SUM		--> Retorna a soma do valor da coluna
AVG		--> Retorna a média do valor da coluna

-- SINTAXE DA QUERY DE AGRUPAMENTO
SELECT 	 [COLUNAS QUE DESEJA AGRUPAR E A FUNÇÃO]
FROM	 [TABELA(S) QUE DESEJA EXTRAIR A INFORMAÇÃO]
WHERE	 [CONDIÇÃO/FILTRO]
GROUP BY [COLUNAS AGRUPADAS NA CLAUSULA SELECT]
HAVING	 [CONDIÇÃO/FILTRO SOBRE A FUNÇÃO UTILIZADA]
ORDER BY [COLUNAS E FORMA QUE DESEJAM ORDENAR];

-- Query exemplo
SELECT 	 V.NOME_VENDEDOR, 
		 TO_CHAR(V2.DATA_VENDA,'YYYY') AS ANO,
		 SUM(V2.VALOR_VENDA)
FROM	 VENDEDOR V INNER JOIN VENDA V2 ON V.CODIGO = V2.CODIGO_VENDEDOR
WHERE	 TO_CHAR(V2.DATA_VENDA,'YYYY') IN ('2020','2019','2018')
GROUP BY V.NOME_VENDEDOR, TO_CHAR(V2.DATA_VENDA,'YYYY')
HAVING	 SUM(V2.VALOR_VENDA) > 400.000
ORDER BY V.NOME_VENDEDOR, TO_CHAR(V2.DATA_VENDA,'YYYY') DESC;