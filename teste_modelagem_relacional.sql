-- Avaliação de rentabilidade do vendedor

SELECT
    v.nomeloja,
    v.ranking,
    SUM(fv.margemdelucro) AS Lucro_Total,
    COUNT(DISTINCT fv.id_pedido) AS Pedidos_Atendidos,
    SUM(fv.valortotalitem) AS Faturamento_Total
FROM
    FatoVendas AS fv
JOIN
    Dim_Vendedor AS v ON fv.id_vendedor = v.id_vendedor
GROUP BY
    v.nomeloja, v.ranking
ORDER BY
    Lucro_Total DESC;

-- Análise da Performance de Vendas por Variação de Produto

SELECT * from dim_variacaoproduto;

SELECT
	p.nomeproduto AS Produto,
	vp.tipovariacao AS Tipo,
	vp.descvariacao AS Descrição,
	SUM(fv.quantidadevendida) AS Quantidade_vendida,
	SUM(fv.valortotalitem) AS Valor_total,
	SUM(fv.margemdelucro) AS Lucro
FROM 
	FatoVendas AS fv
JOIN
	Dim_Produto AS p ON fv.id_produto = p.id_produto
JOIN 
	Dim_VariacaoProduto AS vp ON fv.id_variacaoproduto = vp.id_variacaoproduto
GROUP BY
	p.nomeproduto, vp.tipovariacao, vp.descvariacao
ORDER BY
	Lucro DESC;

-- Efetividade da Campanha de Marketing

SELECT
	c.nomecampanha AS Nome_Campanha,
	c.tipocampanha AS Tipo_Campanha,
	c.canal,
	SUM(fv.valortotalitem) AS Faturamento,
	c.custocampanha AS Custo,
	(SUM(fv.valortotalitem) - c.custocampanha) AS ROI
FROM
	FatoVendas AS fv
JOIN
	Dim_Campanha AS c ON fv.id_campanha = c.id_campanha
GROUP BY
	c.nomecampanha, c.tipocampanha, c.canal, c.custocampanha
ORDER BY
	ROI DESC;
