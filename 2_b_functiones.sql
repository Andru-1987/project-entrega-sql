USE nautilus;

-- 2 	functions ->
-- function de tasacion donde me explique bajo el costo del vehiculo
-- que categoria es : baja, media, alta gama
DROP FUNCTION IF EXISTS fn_gama_vehiculo;

DELIMITER //
CREATE FUNCTION fn_gama_vehiculo (vehiculo INT) RETURNS VARCHAR(50) DETERMINISTIC READS SQL DATA BEGIN DECLARE existencia BOOL;

DECLARE tipo_gama VARCHAR(50);

SELECT
    IF(COUNT(1) = 0, FALSE, TRUE) INTO existencia
FROM
    nautilus.VEHICULO
WHERE
    id_vehiculo = vehiculo;

IF existencia = 0 THEN
RETURN 'NO EXISTE';

ELSE
SELECT
    CASE
        WHEN tipo_vehiculo LIKE "SUV" THEN "MEDIA GAMA"
        WHEN tipo_vehiculo LIKE "SEDAN" THEN "BAJA GAMA"
        ELSE "ALTA GAMA"
    END INTO tipo_gama
FROM
    nautilus.VEHICULO
WHERE
    id_vehiculo = vehiculo;

RETURN tipo_gama;

END IF;

END // 

DELIMITER ;

--  vehiculo 
-- tipo de reparacion que se esta realizando 
-- cuantos dias ha estado en el taller
DROP FUNCTION IF EXISTS fn_dias_taller;

DELIMITER //
CREATE FUNCTION fn_dias_taller (vehiculo INT) RETURNS INT DETERMINISTIC READS SQL DATA BEGIN
-- declaro las variables que necesito para validar
--  existencia del vehiculo
-- cuantos dias pasaron que se encuentra en el taller
DECLARE cant_dias INT;

DECLARE existencia BOOL;

-- valido existencia, para no hacer el calculo 
-- innecesariamente
SELECT
    IF(COUNT(1) = 0, FALSE, TRUE) INTO existencia
FROM
    nautilus.VEHICULO
WHERE
    id_vehiculo = vehiculo;

-- si no existe -> solamente un error
IF existencia = 0 THEN SIGNAL SQLSTATE '45000'
SET
    MESSAGE_TEXT = 'VEHICULO NO EXISTE';

RETURN 0;

ELSE
-- genial! haceme el calculo
SELECT
    DATEDIFF(NOW(), fecha_reparacion) INTO cant_dias
FROM
    TALLER_VEHICULO
WHERE
    id_vehiculo = vehiculo
LIMIT
    1;

RETURN cant_dias;

END IF;

END // 

DELIMITER ;

-- pasos 
-- IN id_vehiculo INT -> vehiculo VARCHAR(200)
DROP FUNCTION IF EXISTS fn_busqueda_vehiculo;

DELIMITER //
CREATE FUNCTION fn_busqueda_vehiculo (vehiculo INT) RETURNS VARCHAR(200) READS SQL DATA BEGIN DECLARE valor_retorno VARCHAR(200);

SELECT
    modelo INTO valor_retorno
FROM
    nautilus.VEHICULO
WHERE
    id_vehiculo = vehiculo;

RETURN valor_retorno;

END //

DELIMITER ;