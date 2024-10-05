USE nautilus;

-- 2 	procedures -> 
-- * procedimientos de modelo de negocio 
-- * procedimiento de limpieza de registros 
-- * procedimiento de manejo de data agrupada

DROP PROCEDURE IF EXISTS sp_moviento_vehiculo_prioridad;

-- SI EL VEHICULO TIENE > 5 dias -> entonces movelo a la tabla de riesgo
DELIMITER //
CREATE PROCEDURE sp_moviento_vehiculo_prioridad (IN vehiculo INT) BEGIN DECLARE cant_dias INT;

SELECT
    fn_dias_taller (vehiculo) INTO cant_dias
FROM
    DUAL;

IF cant_dias > 5 THEN
INSERT INTO
    riesgo_vehiculo_taller (id_vehiculo, dias_en_taller)
VALUES
    (vehiculo, cant_dias);

UPDATE TALLER_VEHICULO
SET
    fecha_reparacion = NOW()
WHERE
    id_vehiculo = vehiculo;

SELECT
    'SE HA INGRESADO EN LA TABLA DE RIESGO' AS msg
FROM
    DUAL;

END IF;

END //

DELIMITER   ;


-- TCL
DROP PROCEDURE IF EXISTS sp_creacion_de_vehiculo;

DELIMITER //

CREATE PROCEDURE sp_creacion_de_vehiculo(
	IN _fecha_vehiculo DATE ,
    IN _modelo VARCHAR(200),
    IN _tipo_vehiculo VARCHAR(200)
)
BEGIN

	DECLARE __commit_msg VARCHAR(200) DEFAULT "El vehiculo ha sido creado";
    DECLARE __rollback_msg  VARCHAR(200);
    
    START TRANSACTION ;
	
	INSERT INTO nautilus.VEHICULO
		(fecha_vehiculo,modelo,tipo_vehiculo)
        VALUES
        (_fecha_vehiculo,_modelo,_tipo_vehiculo);
        
	IF YEAR(_fecha_vehiculo) < 2000 THEN
		ROLLBACK; 
        SET __rollback_msg  = "El vehiculo debe ser posterior a 2000";
		SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = __rollback_msg;
    
    ELSEIF _modelo LIKE '%AUDI%'THEN 
		ROLLBACK; 
        SET __rollback_msg  = "El modelo del vehiculo no debe ser de Audi";
		SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = __rollback_msg;
	ELSE
		COMMIT ;
		SELECT __commit_msg AS 'mensaje';
    END IF ;
    
END //

DELIMITER ;

