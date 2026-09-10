create table pacientes(
	id serial primary key, 
	nome varchar(150) not null,
	email varchar(150) not null,
	cpf varchar(11) unique not null,
    data_nascimento varchar(8) not null,
	data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)

create table especialidades(
	id serial primary key,
	nome varchar(150) UNIQUE not null
)

create table medicos(
	id serial primary key,
	especialidade_id int not null,
	nome varchar(150) not null,
	crm varchar(150) unique not null,
	valor_consulta int not null default 0 check (valor_consulta >= 0)
)

create table consultas(
    id serial primary key,
    medico_id int not null,
    pacientes_id int not null,
    data_hora TIMESTAMP default CURRENT_TIMESTAMP,
    status varchar (20) default 'Agendada' check (status in ('Agendado', 'Realizada', 'Cancelada')) 
)

create table exames(
    id serial primary key,
    consultas_id int not null,
    nome_exames varchar (150) not null,
    valor_exames int not null default 0 check (valor_exames >= 0)
)

insert into especialidades (nome, id) VALUES
(1, 'Cardiologia'),
(2, 'Pediatra'),
(3, 'Clínico Geral')



insert into especialidades (nome) VALUES
('Cardiologia'),
('Pediatra'),
('Clínico Geral')

insert into medicos(nome,crm, especialidade_id, valor_consulta) values
('Dra. Fonseca', '123456', 1, 450.00),
('Dr. Carlos Eduardo Dias', '987658', 2, 160.00),
('Dra. Mariana Alencar', '689130', 3, 60.00)

insert into pacientes(nome,email,cpf,data_nascimento) values
('Isabella Poppler', 'bebel@gmail.com', '54233676789', '12012010'),
('Valentina Martins', 'melshhzsq@yahoo.com', '43286934357', '13072010'),
('Ana Clara', 'pinheiiro_ana@gmail.com', '32285274741', '12062006')

insert into consultas(medico_id, pacientes_id, status) values
(2 , 1, 'Agendado'),
(3 , 2, 'Realizada'),
(1, 3, 'Agendado')

insert into exames(consultas_id,nome_exames,valor_exames) values
(1,	1,	'Cardiologista', 450.00),
(2,	3,	'Clínica Geral',	60.00),
(3,	2,	'Pediatra',	160.00),
(4,	1,	'Cardiologista',	450.00),
(5,	3,	'Clínica Geral',	60.00),
(6,	2,	'Pediatra',	160.00),
(7,	3,	'Clínica Geral'	60.00)

select 
medicos.nome,
crm,
medico.especialidades,
valor_consulta

from
medicos
join
especialidades
on
medicos.especialidade_id =  especialidades.id