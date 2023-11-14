
---Criar usuários com senha

CREATE USER adm WITH PASSWORD '232425';
CREATE USER gerente WITH PASSWORD '12345';
CREATE USER vendedor WITH PASSWORD '232323';


--Criar o grupo “compras” e o grupo “vendas”


CREATE GROUP compras;
CREATE GROUP vendas;


--Adicionar usuários aos grupos:

GRANT compras TO gerente;
GRANT vendas TO vendedor;

--Conceder permissões para o grupo de “vendas”:

GRANT INSERT, UPDATE, DELETE ON TABLE clientes TO vendas;
GRANT INSERT, UPDATE, DELETE ON TABLE saidas TO vendas;
GRANT INSERT, UPDATE, DELETE ON TABLE itens_saida TO vendas;

--Conceder permissões para o grupo de “compras”:

GRANT INSERT, UPDATE, DELETE ON TABLE fornecedores TO compras;
GRANT INSERT, UPDATE, DELETE ON TABLE entradas TO compras;
GRANT INSERT, UPDATE, DELETE ON TABLE itens_entrada TO compras;
GRANT INSERT, UPDATE, DELETE ON TABLE categorias TO compras;
GRANT INSERT, UPDATE, DELETE ON TABLE produtos TO compras;


