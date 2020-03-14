# --------------------- Criacao do Banco de Dados com as tabelas e campos --------------------------------------------- 
create database agencia_de_viagens
default character set utf8
default collate utf8_general_ci;

use agencia_de_viagens;

create table cidade (
cod_cidade int not null,
nome varchar(20) not null,
uf char(2) not null,
primary key(cod_cidade))default charset = utf8;

create table voo (
nro_voo int not null,
data_partida date not null,
companhia varchar(4) not null,
primary key(nro_voo))default charset = utf8;

create table vai_para (
cod_cidade int not null,
nro_voo int not null,
hora_saida time not null,
hora_chegada time not null,
valor decimal(5,2) not null,
qtd_assento_disp int not null,
primary key(cod_cidade, nro_voo),
foreign key(cod_cidade) references cidade(cod_cidade),
foreign key(nro_voo) references voo(nro_voo))default charset = utf8;

create table hotel (
cod_hotel int not null,
nro_estrelas int not null,
nome varchar(60) not null,
cafe_manha_disp boolean not null default 1,
cep int(8) null,
bairro varchar(20) null,
numero int not null,
logradouro varchar(30) not null,
cod_cidade int not null,
primary key(cod_hotel),
foreign key(cod_cidade) references cidade(cod_cidade))default charset = utf8;

create table quarto(
nro_quarto int not null,
disponibilidade boolean not null default 1,
tipo enum('padrao','suite vip','suite presidencial') null,
diaria decimal(5,2) not null,
capacidade int not null,
cod_hotel int not null,
primary key (nro_quarto,cod_hotel),
foreign key(cod_hotel) references hotel(cod_hotel))default charset = utf8;

create table funcionario (
matricula varchar(5) not null,
tipo enum('admin', 'comum') not null,
nome varchar(60) not null,
primary key (matricula))default charset = utf8;

create table cliente(
cpf varchar(11) not null,
nome varchar(30) not null,
telefone1 numeric(11) not null,
telefone2 numeric(11) null,
email varchar(30) null,
cep int(8) null,
bairro varchar(20) null,
numero int not null,
logradouro varchar(30) not null,
primary key(cpf))default charset = utf8;
  
create table pacote(
id_pacote int not null,
data_compra DATE not null,
taxa_servico decimal(5,2) not null,
cpf varchar(11) not null,
matricula varchar(5) not null,
primary key(id_pacote),
foreign key(cpf) references cliente(cpf),
foreign key(matricula) references funcionario(matricula))default charset = utf8;

create table gera(
id_pacote int not null,
cod_cidade int not null,
nro_voo int not null,
cod_hotel int not null,
nro_quarto int not null,
primary key(id_pacote, cod_cidade, nro_voo, cod_hotel, nro_quarto),
foreign key(id_pacote) references pacote(id_pacote),
foreign key(cod_cidade) references cidade(cod_cidade),
foreign key(nro_voo) references voo(nro_voo),
foreign key(cod_hotel) references hotel(cod_hotel),
foreign key(nro_quarto) references quarto(nro_quarto))default charset = utf8;