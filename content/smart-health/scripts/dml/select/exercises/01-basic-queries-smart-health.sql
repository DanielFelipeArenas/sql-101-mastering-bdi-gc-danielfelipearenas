-- ##################################################
-- #     CONSULTAS DE PRÁCTICA - SMART HEALTH      #
-- ##################################################

-- 1. Listar todos los pacientes de género femenino registrados en el sistema,
-- mostrando su nombre completo, correo electrónico y fecha de nacimiento,
-- ordenados por apellido de forma ascendente.

SELECT
    first_name||' '||COALESCE(middle_name, '')||' '||first_surname||' '||COALESCE(second_surname, '') AS paciente,
    email AS correo_electronico,
    birth_date AS fecha_nacimiento
FROM smart_health.patients
WHERE gender = 'F'
ORDER BY first_name, first_surname
LIMIT 5;

-- 2. Consultar todos los médicos que ingresaron al hospital después del año 2020,
-- mostrando su código interno, nombre completo y fecha de admisión,
-- ordenados por fecha de ingreso de más reciente a más antiguo.
SELECT
    internal_code AS codigo_medico,
    CONCAT(first_name, ' ', last_name) AS nombre_completo,
    hospital_admission_date AS fecha_ingreso
    FROM
    smart_health.doctors
    WHERE
    EXTRACT(YEAR FROM hospital_admission_date) > 2020
    ORDER BY
    hospital_admission_date DESC;

-- 3. Obtener todas las citas médicas con estado 'Scheduled' (Programada),
-- mostrando la fecha, hora de inicio y motivo de la consulta,
-- ordenadas por fecha y hora de manera ascendente.
SELECT
    appointment_date AS fecha,
    start_time AS hora_inicio,
    reason AS motivo
    FROM
    smart_health.appointments
    WHERE
    status = 'Scheduled'
    ORDER BY
    appointment_date ASC,
    start_time ASC;


-- 4. Listar todos los medicamentos cuyo nombre comercial comience con la letra 'A',
-- mostrando el código ATC, nombre comercial y principio activo,
-- ordenados alfabéticamente por nombre comercial.
SELECT
    atc_code AS codigo_atc,
    commercial_name AS nombre_comercial,
    active_ingredient AS principio_activo
    FROM
    smart_health.medications
    WHERE
    commercial_name ILIKE 'A%'
    ORDER BY
    commercial_name ASC;

-- 5. Consultar todos los diagnósticos que contengan la palabra 'diabetes' en su descripción,
-- mostrando el código CIE-10 y la descripción completa,
-- ordenados por código de diagnóstico.
SELECT
    icd_code AS "Código CIE-10",
    INITCAP(description) AS "Descripción"
    FROM
    smart_health.diagnoses
    WHERE
    description ILIKE '%diabetes%'
    ORDER BY
    icd_code;

-- 6. Listar todas las salas de atención activas del hospital con capacidad mayor a 5 personas,
-- mostrando el nombre, tipo y ubicación de cada sala,
-- ordenadas por capacidad de mayor a menor.
SELECT
    room_name AS nombre_sala,
    room_type AS tipo_sala,
    location AS ubicacion,
    capacity AS capacidad
    FROM
    smart_health.rooms
    WHERE
    active = TRUE
    AND capacity > 5
    ORDER BY
    capacity DESC;

-- 7. Obtener todos los pacientes que tienen tipo de sangre O+ o O-,
-- mostrando su nombre completo, tipo de sangre y fecha de nacimiento,
-- ordenados por tipo de sangre y luego por apellido.
SELECT
    CONCAT(p.first_name, ' ', 
           COALESCE(p.middle_name, ''), ' ', 
           p.first_surname, ' ', 
           COALESCE(p.second_surname, '')) AS nombre_completo,
    p.blood_type AS tipo_sangre,
    p.birth_date AS fecha_nacimiento
    FROM
    smart_health.patients p
    WHERE
    p.blood_type IN ('O+', 'O-')
    ORDER BY
    p.blood_type,
    p.first_surname;

-- 8. Consultar todas las direcciones activas ubicadas en un municipio específico,
-- mostrando la línea de dirección, código postal y código del municipio,
-- ordenadas por código postal.

-- ##################################################
-- #              FIN DE CONSULTAS                  #
-- ##################################################