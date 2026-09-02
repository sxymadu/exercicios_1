create table clientes(
	id serial primary key, 
	nome varchar(150) not null,
	email varchar(150) not null,
	cpf varchar(11) unique not null,
	data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)

create table categorias (
	id serial primary key,
	nome varchar(150) UNIQUE not null
)

create table produtos(
	id serial primary key,
	categoria_id int not null,
	nome varchar(100) not null,
	preco numeric(10,2) not null check(preco > 0),
	qtd_estoque int not null default 0 check (qtd_estoque >= 0),


CONSTRAINT fk_produtos_categoria
	FOREIGN key (categoria_id)
	REFERENCES categorias(id)
	on delete restrict
);

CREATE table pedidos(
	id serial primary KEY,
	cliente_id int not NULL,
	data_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	status varchar(20) DEFAULT 'pendente' check (status in('Pendente', 'Pago', 'Enviado', 'Cancelado')),

	CONSTRAINT fk_pedido_cliente
	FOREIGN key (cliente_id) 
	REFERENCES clientes (id)
	on delete cascade 
)

CREATE table pedidos(
	id serial primary KEY,
	cliente_id int not NULL,
	data_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	status varchar(20) DEFAULT 'pendente' check (status in('Pendente', 'Pago', 'Enviado', 'Cancelado')),

	CONSTRAINT fk_pedido_cliente
	FOREIGN key (cliente_id) 
	REFERENCES clientes (id)
	on delete cascade 
)

create table clientes(
	id serial primary key, 
	nome varchar(150) not null,
	email varchar(150) not null,
	cpf varchar(11) unique not null,
	data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)

create table categorias (
	id serial primary key,
	nome varchar(150) UNIQUE not null
)

create table produtos(
	id serial primary key,
	categoria_id int not null,
	nome varchar(100) not null,
	preco numeric(10,2) not null check(preco > 0),
	qtd_estoque int not null default 0 check (qtd_estoque >= 0),


CONSTRAINT fk_produtos_categoria
	FOREIGN key (categoria_id)
	REFERENCES categorias(id)
	on delete restrict
);

ate table pedidos(
	id serial primary KEY,
	cliente_id int nott NULL,
	data_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	status va
)


insert into categorias (nome) VALUES
('Perifericos'),
('Monitores'),
('Hardwares')

select * from 
categorias

insert into clientes(nome,email,cpf) values
('Madu', 'dudona@teste', '11894276333'),
('Bella', 'bebel@teste', '96365123487'),
('Noah', 'noah@teste', '76584593430')

select * from clientes

insert into produtos(categoria_id,nome, preco, qtd_estoque) values
(1, 'Teclado LogiTech', 120.00, 97),
(1, 'MousePad Philips', 39.99, 500),
(2, 'Monitor Philips 24p 244hz', 899.90, 10),
(2, 'Monitor AOC 27p 75hz', 999.99, 150),
(2, 'Monitor Mancer 17p 240hz', 500, 600),
(3, 'Placa Mae Asus A520', 450.90, 300),
(3, 'Memoria Ram DDR4 Redragon 8GB', 580.90, 700),
(3, 'SSD 1TB Mancer', 800.50, 49);

select * from produtos 

insert into pedidos(cliente_id, status) VALUES
(1, 'Pago'), 
(1, 'Enviado'), 
(2, 'Cancelado'), 
(2, 'Pago'), 
(2, 'Pendente'), 
(3, 'Cancelado'), 
(3, 'Pendente'), 
(3, 'Enviado')

insert into itens_pedido(pedido_id, produto_id, quantidade, preco_unitario) VALUES
(1, 2, 2, 1500),
(1, 3, 4, 1000),
(2, 1, 3, 750.50),
(2, 2, 3, 507),
(2, 3, 3, 300),
(3, 1, 3, 497),
(3, 2, 3, 111.99),
(3, 3, 3, 601)

select * from itens_pedido

