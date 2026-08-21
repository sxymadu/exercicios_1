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
	preco numeric(10,2) not null check(preco > 0)
	quantidade_estoque int not null default 0 check (qtd_estoque >= 0)
)

CONSTRAINT fk_produtos_categoria
	FOREIGN key (categoria_id)
	REFERENCES categoria(id)
	on delete restrict
