DROP PROCEDURE IF EXISTS display;
DELIMITER $

CREATE PROCEDURE display(IN msg VARCHAR(100))
BEGIN
    SELECT msg;
END $
DELIMITER ;


DROP PROCEDURE IF EXISTS pro1;
DELIMITER $

CREATE PROCEDURE pro1(IN idname VARCHAR(20))
BEGIN
    DECLARE x VARCHAR(29);
    DECLARE y VARCHAR(29);
    DECLARE done INT DEFAULT 0;

    -- Cursor to fetch employee names and department names
    DECLARE c1 CURSOR FOR
        SELECT ename, dname
        FROM emp
        JOIN dept ON emp.deptno = dept.deptno
        WHERE dname = idname;

    -- Handler when cursor reaches end
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    -- Check if department exists
    IF EXISTS (SELECT 1 FROM dept WHERE dname = idname) THEN

        OPEN c1;

        lbl: LOOP
            FETCH c1 INTO x, y;

            IF done = 1 THEN
                LEAVE lbl;
            END IF;

            -- Insert into table z
            INSERT INTO z(empno, ename, deptno)
            VALUES (1, x, 1);

            -- Display employee and department
            CALL display(CONCAT(x, ' works in ', y));

        END LOOP lbl;

        CLOSE c1;

        CALL display('No more records');

    ELSE
        CALL display('Department Name not found...');

    END IF;

END $
DELIMITER ;















































/*drop procedure if exists pro1;
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
		/*	end loop lbl;
		close c1;	
	else
		call display('Department Name not found...');
	end if;
	
end $
delimiter ;*/

