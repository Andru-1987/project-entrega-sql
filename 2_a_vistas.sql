USE nautilus;

-- 2	views -> 
-- En cuanto a las fechas
-- cuantas transacciones se han realizado --> obtener de transacciones
-- Costos del taller
-- TALLER_COSTOS_POR_REPARACION_TIPO
CREATE VIEW
    vw_transacciones_mes AS
SELECT
    YEAR(fecha) AS ANIO,
    MONTH(fecha) AS MES,
    SUM(importe) AS TOTAL
FROM
    TRANSACCION
GROUP BY
    MONTH(fecha),
    YEAR(fecha);

CREATE VIEW
    vw_costo_por_taller AS
SELECT
    data_agrupada.taller AS TALLER,
    CONCAT_WS(
        '-',
        YEAR(data_agrupada.fecha_reparacion),
        MONTH(data_agrupada.fecha_reparacion)
    ) AS periodo,
    SUM(data_agrupada.costo_reparacion) AS COSTO
FROM
    (
        SELECT
            t.cuit AS taller,
            v.modelo AS modelo_vehiculo,
            CASE
                WHEN v.tipo_vehiculo LIKE "SUV" THEN 500
                WHEN v.tipo_vehiculo LIKE "SEDAN" THEN 450
                ELSE 600
            END AS costo_reparacion,
            tv.fecha_reparacion
        FROM
            nautilus.TALLER_VEHICULO AS tv
            JOIN nautilus.TALLER AS t
            -- ON tv.id_taller = t.id_taller 
            USING (id_taller)
            JOIN nautilus.VEHICULO AS v ON tv.id_vehiculo = v.id_vehiculo
    ) AS data_agrupada
GROUP BY
    CONCAT_WS(
        '-',
        YEAR(data_agrupada.fecha_reparacion),
        MONTH(data_agrupada.fecha_reparacion)
    ),
    data_agrupada.taller;
