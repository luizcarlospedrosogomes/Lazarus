CREATE FUNCTION deposito(n_conta integer)
RETURNS TABLE(datadeposito date, nome varchar, valor numeric) AS $$
select datadepostio, nome, valor from deposito 
join conta ON conta.idconta = deposito.idcontadeposito 
join cartao ON cartao.idcartao = conta.idconta 
join cliente ON cliente.idcliente = cartao.idcliente 
where idcontadeposito = $1 and aprovado = $2
order by datadepostio DESC
limit 5;

$$ language 'sql';
select datatrans, cliente.nome, transferencia.valor from transferencia 
left join conta ON transferencia.idcontadestino = conta.idconta 
left join cartao ON cartao.idcartao = conta.idconta 
left join cliente ON cliente.idcliente = cartao.idcliente 
where idcontausuario =$1
order by datatrans DESC
limit 5
--select * from deposito(3,2)
--select * from deposito 
--update deposito set aprovado = 2 where iddeposito=5