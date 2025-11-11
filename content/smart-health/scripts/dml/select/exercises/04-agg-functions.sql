-- ##################################################
-- # CONSULTAS GROUP BY QUERIES AND AGG FUNCTIONS WITH DATE AND STRING FUNCTIONS LIKE DATEPART, SPLIT, AGE, INTERVAL, UPPER, LOWER AND SO ON, USING JOINS - SMART HEALTH #
-- ##################################################

-- 1. Contar cuántos pacientes nacieron en cada mes del año,
-- mostrando el número del mes y el nombre del mes en mayúsculas,
-- junto con la cantidad total de pacientes nacidos en ese mes.
-- Dificultad: BAJA
SELECT
    EXTRACT(MONTH FROM birth_date)::int AS numero_mes,
    UPPER(TO_CHAR(birth_date, 'Month')) AS nombre_mes,
    COUNT(*) AS total_pacientes
    FROM
    smart_health.patients
    GROUP BY
    numero_mes,
    nombre_mes
    ORDER BY
    numero_mes;

-- 2. Mostrar el número de citas programadas agrupadas por día de la semana,
-- incluyendo el nombre del día en español y la cantidad de citas,
-- ordenadas por la cantidad de citas de mayor a menor.
-- Dificultad: BAJA
WITH dias AS (
    SELECT 0 AS dow, 'Domingo' AS nombre
    UNION ALL SELECT 1, 'Lunes'
    UNION ALL SELECT 2, 'Martes'
    UNION ALL SELECT 3, 'Miércoles'
    UNION ALL SELECT 4, 'Jueves'
    UNION ALL SELECT 5, 'Viernes'
    UNION ALL SELECT 6, 'Sábado'
)
SELECT
    d.nombre AS dia_semana,
    COUNT(*) AS total_citas
    FROM
    smart_health.appointments a
    JOIN
    dias d
    ON EXTRACT(DOW FROM a.appointment_date) = d.dow
    GROUP BY
    d.nombre, d.dow
    ORDER BY
    total_citas DESC;


-- 3. Calcular la cantidad de años promedio que los médicos han trabajado en el hospital,
-- agrupados por especialidad, mostrando el nombre de la especialidad en mayúsculas
-- y el promedio de años de experiencia redondeado a un decimal.
-- Dificultad: BAJA-INTERMEDIA

SELECT
    UPPER(s.specialty_name) AS especialidad,
    ROUND(AVG(EXTRACT(YEAR FROM AGE(CURRENT_DATE, d.hospital_admission_date))), 1) AS promedio_anios_experiencia
    FROM
    smart_health.doctors d
    JOIN
    smart_health.doctor_specialties ds
    ON d.doctor_id = ds.doctor_id
    JOIN
    smart_health.specialties s
    ON ds.specialty_id = s.specialty_id
    GROUP BY
    s.specialty_name
    ORDER BY
    especialidad;


-- 4. Obtener el número de pacientes registrados por año,
-- mostrando el año de registro, el trimestre, y el total de pacientes,
-- solo para aquellos trimestres que tengan más de 2 pacientes registrados.
-- Dificultad: INTERMEDIA


-- 5. Listar el número de prescripciones emitidas por mes y año,
-- mostrando el mes en formato texto con la primera letra en mayúscula,
-- el año, y el total de prescripciones, junto con el nombre del medicamento más prescrito.
-- Dificultad: INTERMEDIA

-- 6. Calcular la edad promedio de los pacientes agrupados por tipo de sangre,
-- mostrando el tipo de sangre, la edad mínima, la edad máxima y la edad promedio,
-- solo para grupos que tengan al menos 3 pacientes.
-- Dificultad: INTERMEDIA
SELECT
    blood_type AS tipo_sangre,
    MIN(EXTRACT(YEAR FROM AGE(CURRENT_DATE, birth_date))) AS edad_minima,
    MAX(EXTRACT(YEAR FROM AGE(CURRENT_DATE, birth_date))) AS edad_maxima,
    ROUND(AVG(EXTRACT(YEAR FROM AGE(CURRENT_DATE, birth_date))), 1) AS edad_promedio
FROM
    smart_health.patients
    GROUP BY
    blood_type
    HAVING
    COUNT(*) >= 3
    ORDER BY
    blood_type;


-- 7. Mostrar el número de citas por médico y por mes,
-- incluyendo el nombre completo del doctor en mayúsculas, el mes y año de la cita,
-- la duración promedio de las citas en minutos, y el total de citas realizadas,
-- solo para aquellos médicos que tengan más de 5 citas en el mes.
-- Dificultad: INTERMEDIA-ALTA

-- 8. Obtener estadísticas de alergias por severidad y mes de diagnóstico,
-- mostrando la severidad en minúsculas, el nombre del mes abreviado,
-- el total de alergias registradas, y el número de pacientes únicos afectados,
-- junto con el nombre comercial del medicamento más común en cada grupo.
-- Dificultad: INTERMEDIA-ALTA


-- ##################################################
-- #                 END OF QUERIES                 #
-- ##################################################