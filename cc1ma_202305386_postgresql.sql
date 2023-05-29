-- Caso o banco de dados já existir ele será excluído
DROP DATABASE IF EXISTS uvv;

-- Caso o usuário já exista ele será excluído
DROP USER IF EXISTS guilhermef;

-- Caso o esquema lojas já exsitir ele será excluído
DROP SCHEMA IF EXISTS lojas CASCADE;

-- Criação do usuário guilhermef com senha criptografada
CREATE USER guilhermef WITH ENCRYPTED PASSWORD 'Gui190874@';

-- Faz com que o usuário possa criar banco de dados
ALTER USER guilhermef CREATEDB;

-- Faz com que o usuário possa criar roles
ALTER USER guilhermef CREATEROLE;

-- Realizando a conexão com o usuário guilhermef
SET ROLE guilhermef;

-- Criação do banco de dados uvv
CREATE DATABASE uvv
       OWNER = guilhermef
       TEMPLATE = template0
       ENCODING = UTF8
       LC_COLLATE = 'pt_BR.UTF-8'
       LC_CTYPE = 'pt_BR.UTF-8'
       ALLOW_CONNECTIONS = true;

-- Mudança do caminho do usuário
ALTER USER guilhermef
SET SEARCH_PATH TO lojas, "$user", public;

-- Realizando a conexão no banco de dados uvv
\c "host=localhost dbname=uvv user=guilhermef password=Gui190874@"

-- Criação do esquema lojas
CREATE SCHEMA lojas;


-- Criação da tabela produtos
CREATE TABLE public.produtos (
                produto_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                preco_unitario NUMERIC(10,2),
                detalhes BYTEA,
                imagem BYTEA,
                imagem_mime_type VARCHAR(512),
                imagem_arquivo VARCHAR(512),
                imagem_charset VARCHAR(512),
                imagem_ultima_atualizacao DATE,
                CONSTRAINT produto_id PRIMARY KEY (produto_id)
);

-- Comentario na tabela produtos
COMMENT ON TABLE public.produtos IS 'tabela de produtos';

--Comentario na coluna produto_id da tabela produtos
COMMENT ON COLUMN public.produtos.produto_id IS 'id de cada produto, number(38)';

--Comentario na coluna nome da tabela produtos
COMMENT ON COLUMN public.produtos.nome IS 'nome de cada produto, varchar(255)';

--Comentario na coluna preco_unitario da tabela produtos
COMMENT ON COLUMN public.produtos.preco_unitario IS 'preço de cada produto, number(10,2)';

--Comentario na coluna detalhes da tabela produtos
COMMENT ON COLUMN public.produtos.detalhes IS 'detalhes do produto, blob';

--Comentario na coluna imagem da tabela produtos
COMMENT ON COLUMN public.produtos.imagem IS 'imagem do produto, blob';

--Comentario na coluna imagem_mime_type da tabela produtos
COMMENT ON COLUMN public.produtos.imagem_mime_type IS 'tipo de arquivo da imagem, varchar(512)';

--Comentario na coluna imagem_arquivo da tabela produtos
COMMENT ON COLUMN public.produtos.imagem_arquivo IS 'arquivo da imagem, varchar(512)';

--Comentario na coluna imagem_charset da tabela produtos
COMMENT ON COLUMN public.produtos.imagem_charset IS 'charset da imagem, varchar(512)';

--Comentario na coluna imagem_ultima_atualizacao da tabela produtos
COMMENT ON COLUMN public.produtos.imagem_ultima_atualizacao IS 'data da ultima atualização da imagem, date';

-- Criação da tabela lojas
CREATE TABLE public.lojas (
                loja_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                endereco_web VARCHAR(100),
                endereco_fisico VARCHAR(512),
                latitude NUMERIC,
                longitude NUMERIC,
                logo BYTEA,
                logo_mime_type VARCHAR(512),
                logo_arquivo VARCHAR(512),
                logo_charset VARCHAR(512),
                logo_ultima_atualizacao DATE,
                CONSTRAINT lojas_id PRIMARY KEY (loja_id)
);

-- Comentário da tabela lojas
COMMENT ON TABLE public.lojas IS 'tabela de lojas';

-- Comentário da coluna loja_id da tabela lojas
COMMENT ON COLUMN public.lojas.loja_id IS 'id das lojas, number(38)';

-- Comentário da coluna nome da tabela lojas
COMMENT ON COLUMN public.lojas.nome IS 'nome das lojas, varchar(255)';

-- Comentário da coluna endereco_web da tabela lojas
COMMENT ON COLUMN public.lojas.endereco_web IS 'endereço web da loja, varchar(100)';

-- Comentário da coluna endereco_fisico da tabela lojas
COMMENT ON COLUMN public.lojas.endereco_fisico IS 'enreço fisico de cada loja, varchar(512)';

-- Comentário da coluna latitude da tabela lojas
COMMENT ON COLUMN public.lojas.latitude IS 'latitude de cada loja, number';

-- Comentário da coluna longitude da tabela lojas
COMMENT ON COLUMN public.lojas.longitude IS 'longitude de cada loja, number';

-- Comentário da coluna logo da tabela lojas
COMMENT ON COLUMN public.lojas.logo IS 'logo da loja, blob';

-- Comentário da coluna logo_mime_type da tabela lojas
COMMENT ON COLUMN public.lojas.logo_mime_type IS 'tipo de arquivo da logo, varchar(512)';

-- Comentário da coluna logo_arquivo da tabela lojas
COMMENT ON COLUMN public.lojas.logo_arquivo IS 'arquivo da logo, varchar(512)';

-- Comentário da coluna logo_charset da tabela lojas
COMMENT ON COLUMN public.lojas.logo_charset IS 'charset da logo, varchar(512)';

-- Comentário da coluna logo_ultima_atualizacao da tabela lojas
COMMENT ON COLUMN public.lojas.logo_ultima_atualizacao IS 'data da ultima atualização da logo, date';

-- Ciração da tabela estoque
CREATE TABLE public.estoque (
                estoque_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                quantidade NUMERIC(38),
                CONSTRAINT estoque_id PRIMARY KEY (estoque_id)
);

-- Comentário da tabela estoque
COMMENT ON TABLE public.estoque IS 'tabela do estoque';

-- Comentário da coluna estoque_id da tabela estoque
COMMENT ON COLUMN public.estoque.estoque_id IS 'id do estoque, number(38)';

-- Comentário da coluna loja_id estoque_id da tabela estoque
COMMENT ON COLUMN public.estoque.loja_id IS 'id das lojas, number(38)';

-- Comentário da coluna produto_id da tabela estoque
COMMENT ON COLUMN public.estoque.produto_id IS 'id de cada produto, number(38)';

-- Comentário da coluna quantidade da tabela estoque
COMMENT ON COLUMN public.estoque.quantidade IS 'quantidade de itens no estoque, number(38)';

-- Criação da tabela clientes
CREATE TABLE public.clientes (
                cliente_id NUMERIC(38) NOT NULL,
                email VARCHAR(255) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                telefone1 VARCHAR(20),
                telefone2 VARCHAR(20),
                telefone3 VARCHAR(20),
                CONSTRAINT cliente_id PRIMARY KEY (cliente_id)
);

-- Comentário da tabela cliente
COMMENT ON TABLE public.clientes IS 'tabela dos clientes';

-- Comentário das coluna da tabela clientes
COMMENT ON COLUMN public.clientes.cliente_id IS 'id do cliente, number(38)';

-- Comentário das coluna email da tabela clientes
COMMENT ON COLUMN public.clientes.email IS 'email do cliente, varchar(255)';

-- Comentário das coluna nome da tabela clientes
COMMENT ON COLUMN public.clientes.nome IS 'nome completo do cliente, varchar(255)';

-- Comentário das coluna telefone1 da tabela clientes
COMMENT ON COLUMN public.clientes.telefone1 IS 'primeira opção de telefone do cliente, varchar(20)';

-- Comentário das coluna telefone2 da tabela clientes
COMMENT ON COLUMN public.clientes.telefone2 IS 'segunda opção de telefone do cliente, varchar(20)';

-- Comentário das coluna telefone3 da tabela clientes
COMMENT ON COLUMN public.clientes.telefone3 IS 'terceira opção de telefone do cliente< varchar(20)';

-- Criação da tabela envios
CREATE TABLE public.envios (
                envio_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                endereco_entrega VARCHAR(512) NOT NULL,
                status VARCHAR(15) NOT NULL,
                CONSTRAINT envio_id PRIMARY KEY (envio_id)
);

-- Comentário da tabela envios
COMMENT ON TABLE public.envios IS 'tabela de envios';

-- Comentário das coluna da tabela envios
COMMENT ON COLUMN public.envios.envio_id IS 'id do envio, number(38)';

-- Comentário das coluna loja_id da tabela envios
COMMENT ON COLUMN public.envios.loja_id IS 'id das lojas, number(38)';

-- Comentário das coluna cliente_id da tabela envios
COMMENT ON COLUMN public.envios.cliente_id IS 'id do cliente, number(38)';

-- Comentário das coluna endereco_entrega da tabela envios
COMMENT ON COLUMN public.envios.endereco_entrega IS 'endereço da entrega, varchar(512)';

-- Comentário das coluna envios_status da tabela envios
COMMENT ON COLUMN public.envios.status IS 'status da entrega, varchar(15)';

-- Criação da tabelas pedidos
CREATE TABLE public.pedidos (
                pedido_id NUMERIC(38) NOT NULL,
                data_hora TIMESTAMP NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                status VARCHAR(15) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                CONSTRAINT pedido_id PRIMARY KEY (pedido_id)
);

-- Comentário da tabela pedidos
COMMENT ON TABLE public.pedidos IS 'tabela dos pedidos';

-- Comentário das coluna da tabela pedidos
COMMENT ON COLUMN public.pedidos.pedido_id IS 'id do pedido, number(38)';

-- Comentário das coluna data_hora da tabela pedidos
COMMENT ON COLUMN public.pedidos.data_hora IS 'data e hora que foi feito o pedido, timestamp';

-- Comentário das coluna cliente_id da tabela pedidos
COMMENT ON COLUMN public.pedidos.cliente_id IS 'id do cliente, number(38)';

-- Comentário das coluna status da tabela pedidos
COMMENT ON COLUMN public.pedidos.status IS 'status atual do pedido';

-- Comentário das coluna loja_id da tabela pedidos
COMMENT ON COLUMN public.pedidos.loja_id IS 'id das lojas, number(38)';

-- Criação da tabela pedidos_itens
CREATE TABLE public.pedidos_itens (
                produto_id NUMERIC(38) NOT NULL,
                pedido_id NUMERIC(38) NOT NULL,
                envio_id NUMERIC(38) NOT NULL,
                numero_da_linha NUMERIC(38) NOT NULL,
                preco_unitario NUMERIC(10,2) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                CONSTRAINT pk_pedidos_itens PRIMARY KEY (pedido_id)
);

-- Comentário da tabea pedidos_itens
COMMENT ON TABLE public.pedidos_itens IS 'tabela de pedidos';

-- Comentário das coluna da tabela pedidos_itens
COMMENT ON COLUMN public.pedidos_itens.produto_id IS 'id de cada produto, number(38)';

-- Comentário das coluna pedido_id da tabela pedidos_itens
COMMENT ON COLUMN public.pedidos_itens.pedido_id IS 'id do pedido, number(38)';

-- Comentário das coluna envio_id da tabela pedidos_itens
COMMENT ON COLUMN public.pedidos_itens.envio_id IS 'id do envio, number(38)';

-- Comentário das coluna numero_da_linha da tabela pedidos_itens
COMMENT ON COLUMN public.pedidos_itens.numero_da_linha IS 'numero da linha do pedido, number(38)';

-- Comentário das coluna preco_unitario da tabela pedidos_itens
COMMENT ON COLUMN public.pedidos_itens.preco_unitario IS 'preço unitario, number(10,2)';

-- Comentário das coluna quantidades da tabela pedidos_itens
COMMENT ON COLUMN public.pedidos_itens.quantidade IS 'quantidade de itens no pedido, number(38)';


-- Adicionando a FK produto_id na tabela estoque
ALTER TABLE public.estoque ADD CONSTRAINT produtos_estoque_fk
FOREIGN KEY (produto_id)
REFERENCES public.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Adicionando a FK produto_id na tabela pedidos_itens
ALTER TABLE public.pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES public.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Adicionando a FK loja_id na tabela pedidos
ALTER TABLE public.pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES public.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Adicionando a FK loja_id ma tabela estoque
ALTER TABLE public.estoque ADD CONSTRAINT lojas_estoque_fk
FOREIGN KEY (loja_id)
REFERENCES public.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Adicionando a FK loja_id na tabela envios
ALTER TABLE public.envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES public.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Adicionando a FK cliente_id na tabela pedidos
ALTER TABLE public.pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES public.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Adicionando a FK cliente_id na tabela envios
ALTER TABLE public.envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES public.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Adicionando a FK envio_id na tabela pedidos_itens
ALTER TABLE public.pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES public.envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Adicionando a FK pedido_id na tabela pedidos_itens
ALTER TABLE public.pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES public.pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Restrições de status dos pedidos
ALTER TABLE public.pedidos
    ADD CONSTRAINT pedidos_status_check CHECK (status IN ('CANCELADO', 'COMPLETO', 'ABERTO', 'PAGO', 'REEMBOLSADO', 'ENVIADO'));

-- Restrições de status dos envios
ALTER TABLE public.envios
    ADD CONSTRAINT envios_status_check CHECK (status IN ('CRIADO', 'ENVIADO', 'TRANSITO', 'ENTREGUE'));

-- Restrição de checagem no endereço físico das lojas
ALTER TABLE public.lojas
    ADD CONSTRAINT lojas_endereco_check CHECK (endereco_web IS NOT NULL OR endereco_fisico IS NOT NULL);
-- Restrição de preço_unitario na tabela produtos
ALTER TABLE public.produtos
    ADD CONSTRAINT produtos_preco_unitario_check CHECK (preco_unitario > 0);

-- Restrição de preço_unitario na tabela pedidos_itens
ALTER TABLE public.pedidos_itens
    ADD CONSTRAINT pedidos_itens_preco_unitario_check CHECK (preco_unitario > 0);

-- Restrição de quantidade na tabela estoque
ALTER TABLE public.estoque
    ADD CONSTRAINT estoque_quantidade_check CHECK (quantidade >= 0);

-- Restrição de quantidade na tabela pedidos_itens
ALTER TABLE public.pedidos_itens
    ADD CONSTRAINT pedidos_itens_quantidade_check CHECK (quantidade >= 0);

