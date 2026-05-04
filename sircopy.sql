drop procedure if exists pro1;
delimiter $
create procedure pro1(IN idname varchar(20))
BEGIN	
	declare x, y varchar(29);
	
	declare c1 cursor for select ename, dname from emp,dept where emp.deptno = dept.deptno and dname = idname;
	declare exit handler for 1329 call display('No more');
	if (select true from dept where dname=idname) then
		open c1;
			lbl:loop 
				fetch c1 into x, y;
				insert into z(empno, ename, deptno) values (1, x , 1); 
				/*call display(concat(x, " ", y)); */
			end loop lbl;
		close c1;	
	else
		call display('DEpartment Name not found...');
	end if;
	
end $
delimiter ;