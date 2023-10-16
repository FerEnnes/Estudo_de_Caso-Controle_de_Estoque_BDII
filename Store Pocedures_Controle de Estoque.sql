--Incluir Fornecedor

CREATE OR REPLACE PROCEDURE IncluirFornecedor(
    p_nome VARCHAR(100),
    p_email VARCHAR(30),
    p_logradouro VARCHAR(255),
    p_numero INT,
    p_cep VARCHAR(10),
    p_cidade VARCHAR(30),
    p_uf VARCHAR(2)
)
AS $$
BEGIN
    INSERT INTO fornecedores (nome, email, logradouro, numero, cep, cidade, uf)
    VALUES (p_nome, p_email, p_logradouro, p_numero, p_cep, p_cidade, p_uf);
END;
$$ LANGUAGE plpgsql;

--Incluir Produto

CREATE OR REPLACE PROCEDURE IncluirProduto(
    p_descricao VARCHAR(200),
    p_preco_custo DECIMAL(10, 2),
    p_preco_venda DECIMAL(10, 2),
    p_quantidade_estoque INT,
    p_id_categoria INT
)
AS $$
BEGIN
    INSERT INTO produtos (Descricao, PrecoCusto, precoVenda, quantidadeEstoque, idcategoria)
    VALUES (p_descricao, p_preco_custo, p_preco_venda, p_quantidade_estoque, p_id_categoria);
END;
$$ LANGUAGE plpgsql;


--Atualizar estoque (saída)

CREATE OR REPLACE PROCEDURE AtualizarEstoqueSaida(
    p_id_produto INT,
    p_quantidade INT
)
AS $$
BEGIN
    UPDATE produtos
    SET quantidadeEstoque = quantidadeEstoque - p_quantidade
    WHERE idproduto = p_id_produto;
END;
$$ LANGUAGE plpgsql;

--Atualizar estoque (entrada: estoque, preço custo, preço de venda)

CREATE OR REPLACE PROCEDURE AtualizarEstoqueEntrada(
    p_id_produto INT,
    p_quantidade INT,
    p_preco_custo DECIMAL(10, 2),
    p_preco_venda DECIMAL(10, 2)
)
AS $$
BEGIN
    UPDATE produtos
    SET quantidadeEstoque = quantidadeEstoque + p_quantidade,
        PrecoCusto = p_preco_custo,
        precoVenda = p_preco_venda
    WHERE idproduto = p_id_produto;
END;
$$ LANGUAGE plpgsql;



