create table clientes(
    id serial primary key,
    nome varchar(150) not null,
    email varchar(150) unique not null,
    telefone varchar(20) not null,
    cpf varchar(11) unique not null,
    data_cadastro timestamp default current_timestamp
);

create table mecanicos(
    id serial primary key,
    nome varchar(150) not null,
    especialidade varchar(100) not null,
    valor_hora numeric(10,2) not null check (valor_hora > 0)
);

create table veiculos(
    id serial primary key,
    cliente_id int not null,
    placa varchar(7) unique not null,
    modelo varchar(100) not null,
    marca varchar(100) not null,
    ano int not null,

    constraint fk_veiculos_cliente
        foreign key (cliente_id)
        references clientes(id)
        on delete cascade
);

create table ordens_servico(
    id serial primary key,
    veiculo_id int not null,
    mecanico_id int not null,
    data_abertura timestamp default current_timestamp,
    valor_mao_obra numeric(10,2) not null check (valor_mao_obra >= 0),
    status varchar(20) default 'Em Aberto'
        check (status in ('Em Aberto', 'Em Andamento', 'Concluida', 'Cancelada')),

    constraint fk_os_veiculo
        foreign key (veiculo_id)
        references veiculos(id)
        on delete cascade,

    constraint fk_os_mecanico
        foreign key (mecanico_id)
        references mecanicos(id)
        on delete restrict
);

create table pecas_os(
    id serial primary key,
    os_id int not null,
    nome_peca varchar(150) not null,
    quantidade int not null check (quantidade > 0),
    valor_unitario numeric(10,2) not null check (valor_unitario > 0),

    constraint fk_pecas_os
        foreign key (os_id)
        references ordens_servico(id)
        on delete cascade
);

insert into clientes(nome, email, telefone, cpf) values
('Fernanda Lima', 'fernanda@gmail.com', '48999990001', '12345678901'),
('Carlos Mendes', 'carlos@gmail.com', '48999990002', '23456789012'),
('Juliana Alves', 'juliana@gmail.com', '48999990003', '34567890123');

insert into mecanicos(nome, especialidade, valor_hora) values
('João da Silva', 'Motor', 120.00),
('Marcos Oliveira', 'Suspensão', 85.00),
('Rafael Santos', 'Injeção Eletrônica', 150.00);

insert into veiculos(cliente_id, placa, modelo, marca, ano) values
(1, 'ABC1234', 'Civic', 'Honda', 2020),
(2, 'DEF5678', 'Onix', 'Chevrolet', 2022),
(3, 'GHI9012', 'Corolla', 'Toyota', 2021);

insert into ordens_servico
(veiculo_id, mecanico_id, valor_mao_obra, status)
values
(1, 1, 300.00, 'Concluida'),
(2, 2, 200.00, 'Em Andamento'),
(3, 3, 450.00, 'Concluida'),
(1, 3, 150.00, 'Cancelada');

insert into pecas_os
(os_id, nome_peca, quantidade, valor_unitario)
values
(1, 'Filtro de Óleo', 2, 45.00),
(1, 'Óleo do Motor', 4, 35.00),
(2, 'Pastilha de Freio', 1, 180.00),
(3, 'Amortecedor', 2, 350.00);

select
    v.modelo,
    v.marca,
    v.placa,
    c.nome as proprietario,
    c.telefone
from veiculos v
join clientes c
    on c.id = v.cliente_id
order by
    v.marca,
    v.modelo;

select
    os.id as os_id,
    v.placa,
    v.modelo,
    os.data_abertura,
    m.nome as mecanico,
    os.status
from ordens_servico os
join veiculos v
    on v.id = os.veiculo_id
join clientes c
    on c.id = v.cliente_id
join mecanicos m
    on m.id = os.mecanico_id
where c.nome = 'Fernanda Lima';

select
    os.id as os_id,
    v.placa,
    m.nome as mecanico,
    os.valor_mao_obra,
    coalesce(sum(p.quantidade * p.valor_unitario), 0) as valor_pecas,
    os.valor_mao_obra +
    coalesce(sum(p.quantidade * p.valor_unitario), 0) as valor_total
from ordens_servico os
join veiculos v
    on v.id = os.veiculo_id
join mecanicos m
    on m.id = os.mecanico_id
left join pecas_os p
    on p.os_id = os.id
group by
    os.id,
    v.placa,
    m.nome,
    os.valor_mao_obra
order by os.id;

select
    nome,
    especialidade,
    valor_hora
from mecanicos
where valor_hora > 90.00
order by valor_hora desc;

select
    m.especialidade,
    sum(os.valor_mao_obra) as total_faturado
from ordens_servico os
join mecanicos m
    on m.id = os.mecanico_id
where os.status = 'Concluida'
group by m.especialidade
order by total_faturado desc;
