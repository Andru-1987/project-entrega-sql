USE nautilus; 

CREATE USER 
	'ddl_user'@'%' IDENTIFIED BY 'change_me123!';

CREATE USER 
	'consumer_user'@'%' IDENTIFIED BY 'change_me123!';

CREATE USER 
	'bk_user'@'%' IDENTIFIED BY 'change_me123!';



-- GRANT 

GRANT SELECT,INSERT,UPDATE  
    ON nautilus.* TO 'ddl_user'@'%' ;

SHOW GRANTS FOR
    'ddl_user'@'%' ;
 

GRANT SELECT
    ON nautilus.vw_costo_por_taller
    TO 'consumer_user'@'%' ;

GRANT SELECT
    ON nautilus.vw_transacciones_mes
    TO 'consumer_user'@'%' ;

SHOW GRANTS FOR
    'consumer_user'@'%' ;


GRANT USAGE 
    ON nautilus.* 
    TO 'bk_user'@'%';

GRANT PROCESS, RELOAD
	ON *.* 
    TO 'bk_user'@'%';

GRANT SELECT, LOCK TABLES, SHOW VIEW, EVENT, TRIGGER
    ON nautilus.* 
    TO 'bk_user'@'%';

SHOW GRANTS FOR 
    'bk_user'@'%';