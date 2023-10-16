
--Criar a tabela para armazenar os logs

CREATE TABLE logs (
    id SERIAL PRIMARY KEY,
    tabela_afetada VARCHAR(255),
    operacao VARCHAR(10),
    data_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

--Criar a Function Trigger


CREATE OR REPLACE FUNCTION registraLog()
RETURNS TRIGGER
AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO logs (tabela_afetada, operacao) VALUES (TG_TABLE_NAME, 'INSERT');
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO logs (tabela_afetada, operacao) VALUES (TG_TABLE_NAME, 'UPDATE');
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO logs (tabela_afetada, operacao) VALUES (TG_TABLE_NAME, 'DELETE');
    END IF;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

--Criar a Trigger sobre a tabela "saidas"

CREATE TRIGGER trigger_log_saidas
AFTER INSERT OR UPDATE OR DELETE
ON saidas
FOR EACH ROW
EXECUTE FUNCTION registraLog();

--Operações na tabela "saidas" e consulta na tabela "logs"

-- Exemplo de operações INSERT, UPDATE e DELETE na tabela saidas

INSERT INTO saidas (data, valorTotal, idcliente, idusuario) VALUES ('2023-10-18', 150.00, 1, 2);
UPDATE saidas SET valorTotal = 200.00 WHERE numeronfsaida = 1;
DELETE FROM saidas WHERE numeronfsaida = 1;


-- Consulta na tabela logs para verificar os registros gerados pela trigger
SELECT * FROM logs;





