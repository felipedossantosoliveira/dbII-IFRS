CREATE OR REPLACE PROCEDURE register_medical_consultation(
    p_doctor_id INT,
    p_patient_id INT,
    p_initial_date TIMESTAMP,
    p_final_date TIMESTAMP,
    p_appointment_description VARCHAR(255),
    p_observation VARCHAR(255),
    p_diagnostic VARCHAR(255),
    p_done BOOLEAN,
    p_cid_id INT DEFAULT NULL,
    p_certificate_description VARCHAR(255) DEFAULT NULL,
    p_prescription_description VARCHAR(255) DEFAULT NULL
)
    LANGUAGE plpgsql
AS
$$
DECLARE
    v_medical_appointment_id  INT;
    v_medical_consultation_id INT;
BEGIN
    -- Inicia um bloco de transação
    BEGIN
        -- Inserir um novo compromisso médico (agendamento)
        INSERT INTO medical_appointments (doctor_id,
                                          initial_date,
                                          final_date,
                                          description)
        VALUES (p_doctor_id,
                p_initial_date,
                p_final_date,
                p_appointment_description)
        RETURNING id INTO v_medical_appointment_id;

        -- Inserir uma nova consulta médica
        INSERT INTO medical_consultations (medical_appointment_id,
                                           patient_id,
                                           observation,
                                           diagnostic,
                                           done)
        VALUES (v_medical_appointment_id,
                p_patient_id,
                p_observation,
                p_diagnostic,
                p_done)
        RETURNING id INTO v_medical_consultation_id;

        -- Inserir um certificado médico, se fornecido
        IF p_cid_id IS NOT NULL AND p_certificate_description IS NOT NULL THEN
            INSERT INTO medical_certificates (medical_consultation_id,
                                              cid_id,
                                              description)
            VALUES (v_medical_consultation_id,
                    p_cid_id,
                    p_certificate_description);
        END IF;

        -- Inserir uma prescrição, se fornecido
        IF p_prescription_description IS NOT NULL THEN
            INSERT INTO prescriptions (medical_consultation_id,
                                       description)
            VALUES (v_medical_consultation_id,
                    p_prescription_description);
        END IF;

        -- Confirma a transação automaticamente ao sair do bloco
    EXCEPTION
        WHEN OTHERS THEN
            -- Em caso de erro, desfaz a transação e reverte todas as mudanças
            ROLLBACK;
            RAISE;
    END;
END;
$$;


-- Uso da procedure
CALL register_medical_consultation(
        1, -- doctor_id
        1, -- patient_id
        '2024-07-03 09:00:00', -- initial_date
        '2024-07-03 10:00:00', -- final_date
        'Consulta de rotina', -- appointment_description
        'Observação do paciente', -- observation
        'Diagnóstico do paciente', -- diagnostic
        TRUE, -- done
        1, -- cid_id (opcional)
        'Descrição do certificado', -- certificate_description (opcional)
        'Descrição da prescrição' -- prescription_description (opcional)
     );
-- Uso apenas para inserção da consulta
CALL register_medical_consultation(
        1, -- doctor_id
        1, -- patient_id
        '2024-07-03 09:00:00', -- initial_date
        '2024-07-03 10:00:00', -- final_date
        'Consulta de rotina', -- appointment_description
        'Observação do paciente', -- observation
        'Diagnóstico do paciente', -- diagnostic
        FALSE -- done
     );

