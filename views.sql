-- View para consultas médicas detalhadas

CREATE VIEW detailed_medical_consultations AS
SELECT
    mc.id AS consultation_id,
    mc.medical_appointment_id,
    mc.patient_id,
    p.user_id AS patient_user_id,
    u.name AS patient_name,
    u.cpf AS patient_cpf,
    ma.doctor_id,
    d.crm AS doctor_crm,
    u2.name AS doctor_name,
    u2.cpf AS doctor_cpf,
    ma.initial_date,
    ma.final_date,
    ma.description AS appointment_description,
    mc.observation,
    mc.diagnostic,
    mc.done
FROM
    medical_consultations mc
        JOIN
    patients p ON mc.patient_id = p.id
        JOIN
    users u ON p.user_id = u.id
        JOIN
    medical_appointments ma ON mc.medical_appointment_id = ma.id
        JOIN
    doctor d ON ma.doctor_id = d.id
        JOIN
    users u2 ON d.user_id = u2.id;

SELECT * FROM detailed_medical_consultations;
