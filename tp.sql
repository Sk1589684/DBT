drop- FUNCTION if exists fn1();

delimiter $
CREATE FUNCTION fn1 RETURNS VARCHAR(20)

deterministic
begin

DECLARE a VARCHAR(20);

return"Hello World";

end $ 
delimiter;