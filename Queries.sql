# Visualização das tabelas criadas:

Select * from cidade;
Select * from cliente;
Select * from funcionario;
Select * from gera;
Select * from hotel;
Select * from pacote;
Select * from quarto;
Select * from vai_para;
Select * from voo;

# -------------------------- ESCOLHA DO VOO ----------------------------------
# Retornar o nome da companhia área, hora de saída e hora de chegada dos voos que vão para Fortaleza dia 02/04/2016 

select voo.companhia, vai_para.hora_saida, vai_para.hora_chegada
from voo natural join vai_para natural join cidade
where cidade.nome = 'Fortaleza' and voo.data_partida = '2016-04-02';

# Retornar o nome da companhia área, hora de saída e hora de chegada dos voos que vão para Fortaleza dia 02/04/2016 depois as 18h.

select voo.companhia, vai_para.hora_saida, vai_para.hora_chegada
from voo natural join vai_para natural join cidade
where cidade.nome = 'Fortaleza' and voo.data_partida = '2016-04-02' and vai_para.hora_saida > '18:00:00';

# Retornar o nome da companhia área, hora de saída e hora de chegada dos voos que vão para Fortaleza e tem mais de 10 assentos disponíveis 

select voo.companhia, vai_para.hora_saida, vai_para.hora_chegada
from voo natural join vai_para natural join cidade
where cidade.nome = 'Fortaleza' and vai_para.qtd_assento_disp > 10;

# -------------------------- SELEÇÃO DE FUNCIONÁRIOS ---------------------------
# Retornar funcionários que são administradores

select *
from funcionario
where tipo = 'admin';

# ---------------------------- SELEÇÃO DE HOTÉIS --------------------------------
# Retornar o nome e número de estrelas dos hotéis da cidade de fortaleza, ordenando por numero de estrelas (decrescente)

select hotel.nome, hotel.nro_Estrelas
from cidade,hotel
where cidade.nome = 'Fortaleza' and cidade.cod_cidade = hotel.cod_cidade
order by nro_estrelas desc;

# Retornar nome e cep dos hotéis de Fortaleza que tenham 5 estrelas

select hotel.nome, hotel.cep
from cidade,hotel
where cidade.nome = 'Fortaleza' and hotel.nro_Estrelas = '5' and cidade.cod_cidade = hotel.cod_cidade;

# ------------------------------- SELEÇÃO DE QUARTO -----------------------------------------------------------------
# Retornar nome do hotel, número do quarto e valor da diária de hoteís em fortaleza que tenham quarto com capacidade maior ou igual a 4 pessoas

select hotel.nome, quarto.nro_quarto, quarto.diaria
from cidade, hotel, quarto
where cidade.nome = 'Rio de Janeiro' and quarto.capacidade >= 4 and
cidade.cod_cidade = hotel.cod_cidade and hotel.cod_hotel = quarto.cod_hotel;

---------------------------------------- SELEÇÃO DE PACOTES ---------------------------------------------------
# Retornar o número de clientes que compraram pacotes com o funcionario Rafael

select count(cliente.cpf)
from funcionario, pacote, cliente
where funcionario.nome = 'Rafael' and
funcionario.matricula = pacote.matricula and pacote.cpf = cliente.cpf;

# Retornar o número de pacotes que foram vendidos pelo funcionario Danilo

select count(pacote.id_pacote)
from funcionario, pacote
where funcionario.nome = 'Danilo' and
funcionario.matricula = pacote.matricula;

# ------------------------------------ SELEÇÃO GERAL -------------------------------------------------
# Retornar data e hora da partida, cidade, nome do hotel e número do quarto do cliente Rafael Rani Santos Martins

select voo.data_partida, vai_para.hora_saida, cidade.nome, hotel.nome, quarto.nro_quarto
from voo, vai_para, cidade, hotel, quarto, gera, pacote, cliente
where cliente.nome = 'Rafael Rani Santos Martins' and
voo.nro_voo = vai_para.nro_voo and vai_para.cod_cidade = cidade.cod_cidade and cidade.cod_cidade = hotel.cod_cidade and hotel.cod_hotel = quarto.cod_hotel
and voo.nro_voo = gera.nro_voo and cidade.cod_cidade = gera.cod_cidade and hotel.cod_hotel = gera.cod_hotel and quarto.nro_quarto = gera.nro_quarto and
pacote.id_pacote = gera.id_pacote and pacote.cpf = cliente.cpf;

# Retornar o nome do hotel, número do quarto e valor da diária dos quartos do tipo suíte presidencial que ficam em hoteís 5 estrelas do Rio de Janeiro 

select hotel.nome, quarto.nro_quarto, quarto.diaria
from cidade, hotel, quarto
where cidade.nome = 'Rio de Janeiro' and hotel.nro_Estrelas = 5 and quarto.tipo = 'suíte presidencial' and
cidade.cod_cidade = hotel.cod_cidade and hotel.cod_hotel = quarto.cod_hotel;

# Retornar data da partida, hora de saída, nome da cidade, nome do hotel, número do quarto, valores de cada serviço (diária 3 dias) e valor total do pacote da cliente Adriana Pereira Almeida

select voo.data_partida, vai_para.hora_saida, cidade.nome as cidade, hotel.nome as hotel, quarto.nro_quarto, vai_para.valor as valor_do_voo,
quarto.diaria * 3 as diária_3_dias, pacote.taxa_servico, vai_para.valor + (quarto.diaria * 3) + pacote.taxa_servico as valor_total
from voo, vai_para, cidade, hotel, quarto, gera, pacote, cliente
where cliente.nome = 'Adriana Pereira Almeida' and
voo.nro_voo = vai_para.nro_voo and vai_para.cod_cidade = cidade.cod_cidade and cidade.cod_cidade = hotel.cod_cidade and hotel.cod_hotel = quarto.cod_hotel
and voo.nro_voo = gera.nro_voo and cidade.cod_cidade = gera.cod_cidade and hotel.cod_hotel = gera.cod_hotel and quarto.nro_quarto = gera.nro_quarto and
pacote.id_pacote = gera.id_pacote and pacote.cpf = cliente.cpf;

# retornar o numero de todos os quartos do hotel Crocobeach

select quarto.nro_quarto
from hotel natural join quarto
where hotel.nome = 'Crocobeach Hotel';

# retornar o numero do voo de todos o voos que irão para fotaleza

select voo.nro_voo
from voo natural join vai_para natural join cidade
where cidade.nome = 'Fortaleza';