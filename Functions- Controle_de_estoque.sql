

--Função atualizaEstoque:


CREATE OR REPLACE FUNCTION atualizaEstoque(
    estoque_atual INT,
    quantidade_atualizar INT,
    operacao INT
)
RETURNS INT
AS $$
DECLARE
    estoque_atualizado INT;
BEGIN
    IF operacao = 0 THEN
        estoque_atualizado := estoque_atual + quantidade_atualizar;
    ELSE
        estoque_atualizado := estoque_atual - quantidade_atualizar;
    END IF;

    RETURN estoque_atualizado;
END;
$$ LANGUAGE plpgsql;

--Função totalNFSaida:

CREATE OR REPLACE FUNCTION totalNFSaida(
    numero_nfsaida INT
)
RETURNS DECIMAL
AS $$
DECLARE
    total_valor DECIMAL := 0;
BEGIN
    SELECT SUM(valorUnitario * quantidade)
    INTO total_valor
    FROM itens_saida
    WHERE numeronfsaida = numero_nfsaida;

    RETURN total_valor;
END;
$$ LANGUAGE plpgsql;

--Função produtosNFEntrada:

CREATE OR REPLACE FUNCTION produtosNFEntrada(
    numero_nfentrada INT
)
RETURNS TABLE (
    numeronfentrada INT,
    idproduto INT,
    descricao_produto VARCHAR(255),
    quantidade_produto INT
)
AS $$
BEGIN
    RETURN QUERY
    SELECT nf.numeroNFEntrada, ie.idproduto, p.Descricao, ie.quantidade
    FROM itens_entrada ie
    INNER JOIN entradas nf ON ie.numeronfentrada = nf.numeroNFEntrada
    INNER JOIN produtos p ON ie.idproduto = p.idproduto
    WHERE nf.numeroNFEntrada = numero_nfentrada;
END;
$$ LANGUAGE plpgsql;

--Função ehNumeroPar:

CREATE OR REPLACE FUNCTION ehNumeroPar(
    numero INT
)
RETURNS BOOLEAN
AS $$
BEGIN
    RETURN numero % 2 = 0;
END;
$$ LANGUAGE plpgsql;

--Função Fatorial:

CREATE OR REPLACE FUNCTION Fatorial(
    numero INT
)
RETURNS INT
AS $$
DECLARE
    resultado INT := 1;
    i INT := 1;
BEGIN
    WHILE i <= numero LOOP
        resultado := resultado * i;
        i := i + 1;
    END LOOP;

    RETURN resultado;
END;
$$ LANGUAGE plpgsql;



