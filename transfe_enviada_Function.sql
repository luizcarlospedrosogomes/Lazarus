CREATE FUNCTION transferencia_enviadas(n_conta integer)
RETURNS TABLE(datatransferencia date, nome varchar, valor numeric) AS $$

select datatrans, cliente.nome, transferencia.valor from transferencia 
left join conta ON transferencia.idcontadestino = conta.idconta 
left join cartao ON cartao.idcartao = conta.idconta 
left join cliente ON cliente.idcliente = cartao.idcliente 
where idcontausuario =$1
order by datatrans DESC
limit 5

$$ language 'sql';



--select * from transferencia 
--select *  from transferencia_recebidas(3)
--select * from deposito(3,2)
--select * from deposito 
--update deposito set aprovado = 2 where iddeposito=5