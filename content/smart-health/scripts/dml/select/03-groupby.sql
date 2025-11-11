-- ##################################################
-- # CONSULTAS GROUP BY QUERIES - SMART HEALTH #
-- ##################################################

-- 1. Contar cuántos pacientes están registrados por cada tipo de documento,
-- mostrando el nombre del tipo de documento y la cantidad total de pacientes,
-- ordenados por cantidad de mayor a menor.
-- Dificultad: BAJA
SELECT
    td.type_name AS tipo_documento,
    COUNT(p.patient_id) AS total_pacientes
FROM
    smart_health.patients p
    JOIN
    smart_health.document_types td
    ON p.document_type_id = td.document_type_id
    GROUP BY
    td.type_name
    ORDER BY
    total_pacientes DESC;
  
--                           tipo_documento                            | total_pacientes
-----------------------------------------------------------------------+-----------------
-- Cédula de Ciudadanía                                                |            7630
-- Número Único de Identificación Personal (NUIP)                      |            7594
-- Registro Civil de Nacimiento                                        |            7490
-- Cédula de Extranjería / Identificación de Extranjería               |            7482
-- Tarjeta de Identidad                                                |            7481
-- Número de Identificación establecido por la Secretaría de Educación |            7457
-- Certificado Cabildo                                                 |            7450
-- Número de Identificación Personal (NIP)                             |            7416
--(8 filas)


-- 2. Mostrar el número de citas programadas por cada médico,
-- incluyendo el nombre completo del doctor y el total de citas,
-- ordenadas alfabéticamente por apellido del médico.
-- Dificultad: BAJA
SELECT
    d.last_name || ' ' || d.first_name AS nombre_completo_doctor,
    COUNT(a.appointment_id) AS total_citas
FROM 
    smart_health.appointments a
    JOIN
    smart_health.doctors d
    ON a.doctor_id = d.doctor_id
    GROUP BY d.last_name, d.first_name
    ORDER BY d.last_name ASC;

--nombre_completo_doctor | total_citas
------------------------+-------------
 --Aguirre Mauricio       |          19
 --Aguirre Juan           |          31
 --Aguirre Rodrigo        |          45
 --Aguirre Alejandro      |          77
 --Aguirre Vanessa        |          31
 --Aguirre Paola          |          33
 --Aguirre MarÝa          |          47
 --Aguirre Fernando       |          61
 --Aguirre Camila         |          47
 --Aguirre Esteban        |          28
 --Aguirre Laura          |          16
 --Aguirre Adriana        |          55
 --Aguirre Gabriela       |          37
 --Aguirre Carlos         |          21
 --Aguirre Pedro          |          44
 --Aguirre Ricardo        |          71
 --Aguirre Manuel         |          67
 --Aguirre Julißn         |          36
 --Aguirre Felipe         |          42
 --Aguirre AndrÚs         |          44
 --Aguirre Santiago       |          23
 --Aguirre Mariana        |          45
 --Aguirre Hernßn         |          46
 --Aguirre Miguel         |          15
 --Aguirre Natalia        |          75
 --Aguirre Isabel         |          43
 --Aguirre Cristian       |          29
 --Aguirre Juliana        |          43


-- 3. Calcular el promedio de edad de los pacientes agrupados por género,
-- mostrando el género y la edad promedio redondeada a dos decimales.
-- Dificultad: INTERMEDIA
SELECT
    p.gender AS genero,
    ROUND(AVG(EXTRACT(YEAR FROM AGE(CURRENT_DATE, p.birth_date))), 2) AS edad_promedio
FROM
    smart_health.patients p
    GROUP BY p.gender
    ORDER BY p.gender;

-- genero | edad_promedio
--------+---------------
-- F      |         41.96
 --M      |         41.90
 --O      |         41.87
--(3 filas)


-- 4. Obtener el número total de prescripciones realizadas por cada medicamento,
-- mostrando el nombre comercial del medicamento, el principio activo,
-- y la cantidad de veces que ha sido prescrito, solo para aquellos medicamentos
-- que tengan al menos 5 prescripciones.
-- Dificultad: INTERMEDIA


-- 5. Listar el número de citas por estado y tipo de cita,
-- mostrando cuántas citas existen para cada combinación de estado y tipo,
-- ordenadas primero por estado y luego por la cantidad de citas de mayor a menor,
-- incluyendo solo aquellas combinaciones que tengan más de 3 citas.
-- Dificultad: INTERMEDIA-ALTA


-- ##################################################
-- #                 END OF QUERIES                 #
-- ##################################################