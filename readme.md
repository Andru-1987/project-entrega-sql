

_OPTIONAL :: ppt - pdf o md_

## DOCUMENTACION DE STORED PROCEDURES
**Nombre del Procedimiento** : `sp_creacion_de_vehiculo` 

Descripción
Este procedimiento almacenado se utiliza para insertar registros en la tabla VEHICULO, siempre y cuando se cumplan las siguientes validaciones:

 - El año del vehículo debe ser posterior al 2000.
 - El modelo del vehículo no debe contener la palabra "AUDI".


```sql
-- LLAMADO CASO EXISTOSO
CALL sp_creacion_de_vehiculo('2015-05-10', 'Toyota Corolla', 'Automovil');

-- LLAMADO CASOS DE RECHAZO
CALL sp_creacion_de_vehiculo('1999-12-31', 'Honda Civic', 'Automovil');
CALL sp_creacion_de_vehiculo('2023-01-15', 'AUDI A4', 'Automovil');
```