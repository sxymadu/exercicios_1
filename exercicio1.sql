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

CONSTRAINT fk_produtos_categoria
	FOREIGN key (categoria_id)
	REFERENCES categoria(id)
	on delete restrict
