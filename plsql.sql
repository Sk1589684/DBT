drop procedure if exists pro1;
delimiter$
create  procedure pro1(IN x int)
BEGIN
if x>10 then 
select"good";
else if 
select "bad";
end
delimiter$;