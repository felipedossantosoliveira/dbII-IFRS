-- Endereços
INSERT INTO addresses (city_id, address, number, complement)
VALUES (3550308, 'Av. Paulista', '1000', 'Sala 101'),
       (3304557, 'Av. Rio Branco', '500', 'Bloco C'),
       (3106200, 'Rua da Paz', '200', 'Andar 2');

-- Convênios de saúde
INSERT INTO medical_agreements (address_id, name, phone, cnpj)
VALUES (1, 'Unimed', '1199998888', '12345678901234'),
       (2, 'Tachimed', '2177776666', '98765432109876'),
       (3, 'Amil', '3133332222', '55555555555555');

-- Planos de saúde
INSERT INTO plans (name, medical_agreement_id)
VALUES ('Plano Básico', 1),
       ('Plano Básico', 2),
       ('Plano Básico', 3),
       ('Plano Completo', 1),
       ('Plano Completo', 2),
       ('Plano Completo', 3),
       ('Plano Popular', 1),
       ('Plano Popular', 2),
       ('Plano Popular', 3);


INSERT INTO users (role_id, username, password, name, cpf, rg,
                   phone, address_id, sex)
-- admin (role_id = 1)
VALUES (1, 'carlos', 'sha256password', 'Carlos Silva',
        '94804866019', '313879527', '1112345678', 1, 'F'),
-- doctor (role_id = 2)
       (2, 'joao', 'sha256password', 'João Silva',
        '76124747006', '164480559', '11987654321', 2, 'M'),
-- patient (role_id = 3)
       (3, 'maria', 'sha256password', 'Maria Souza',
        '24652397089', '149009264', '21876543210', 3, 'F'),
-- secretary (role_id = 4)
       (4, 'jose', 'sha256password', 'José', '28213752040',
        '101086283', '11111111111', 1, 'M');

INSERT INTO users (id, role_id, username, password, name, cpf, rg,
                   phone, address_id, sex)
VALUES (5, 3, 'dr.marta', 'senha101', 'Dra. Marta',
        '444.444.444-44', '4444444', '(21) 22222-2222', 2, 'F');
INSERT INTO users (id, role_id, username, password, name, cpf, rg,
                   phone, address_id, sex)
VALUES (6, 3, 'dr.carlos', 'senha102', 'Dr. Carlos',
        '555.555.555-55', '5555555', '(31) 33333-3333', 3, 'M');


INSERT INTO doctor (id, user_id, crm)
VALUES (1, 4, '12345');
INSERT INTO doctor (id, user_id, crm)
VALUES (2, 5, '54321');
INSERT INTO doctor (id, user_id, crm)
VALUES (3, 6, '98765');


INSERT INTO patients (id, user_id, medical_agreement_id)
VALUES (1, 2, 1);
INSERT INTO patients (id, user_id, medical_agreement_id)
VALUES (2, 3, 2);
INSERT INTO patients (id, user_id, medical_agreement_id)
VALUES (3, 4, 3);


INSERT INTO cids (id, name, code)
VALUES (1, 'Gastrite', 'K29');
INSERT INTO cids (id, name, code)
VALUES (2, 'Infecção viral',
        'B34');
INSERT INTO cids (id, name, code)
VALUES (3,
        'Hipercolesterolemia', 'E78');


INSERT INTO clinics (id, address_id, name, cnpj, phone, header)
VALUES (1, 1, 'Clínica Popular São Paulo', '12345678901234', '(11)
1111-2222', 'Clínica especializada em cuidados primários');


INSERT INTO medical_appointments (id, doctor_id, initial_date,
                                  final_date, description)
VALUES (1, 1, '2024-06-25 10:00:00', '2024-06-25 10:30:00',
        'Consulta de rotina');
INSERT INTO medical_appointments (id, doctor_id, initial_date,
                                  final_date, description)
VALUES (2, 2, '2024-06-26 11:00:00', '2024-06-26 11:30:00',
        'Consulta de acompanhamento');
INSERT INTO medical_appointments (id, doctor_id, initial_date,
                                  final_date, description)
VALUES (3, 3, '2024-06-27 12:00:00', '2024-06-27 12:30:00',
        'Consulta de retorno');
INSERT INTO medical_consultations (id, medical_appointment_id,
                                   patient_id, observation, diagnostic, done)
VALUES (1, 1, 1, 'Paciente queixa-se de dores abdominais',
        'Gastrite leve', true);
INSERT INTO medical_consultations (id, medical_appointment_id,
                                   patient_id, observation, diagnostic, done)
VALUES (2, 2, 2, 'Paciente com febre persistente', 'Infecção
viral', true);
INSERT INTO medical_consultations (id, medical_appointment_id,
                                   patient_id, observation, diagnostic, done)
VALUES (3, 3, 3, 'Paciente precisa de renovação de receita', NULL,
        false);
INSERT INTO medical_certificates (id, medical_consultation_id,
                                  cid_id, description)
VALUES (1, 1, 1, 'Receita de medicamento para alívio da
gastrite');
INSERT INTO medical_certificates (id, medical_consultation_id,
                                  cid_id, description)
VALUES (2, 2, 2, 'Afastamento por 3 dias devido à infecção
viral');
INSERT INTO medical_certificates (id, medical_consultation_id,
                                  cid_id, description)
VALUES (3, 3, 3, 'Necessidade de dieta e acompanhamento médico
para controle de colesterol');
INSERT INTO prescriptions (id, medical_consultation_id,
                           description)
VALUES (1, 1, 'Omeprazol 20mg, 1 comprimido ao dia');
INSERT INTO prescriptions (id, medical_consultation_id,
                           description)
VALUES (2, 2, 'Repouso, hidratação e analgésico para febre');
INSERT INTO prescriptions (id, medical_consultation_id,
                           description)
VALUES (3, 3, 'Tylenol');
INSERT INTO plans (id, name, medical_agreement_id)
VALUES (1,
        'Plano Básico', 1);
INSERT INTO plans (id, name, medical_agreement_id)
VALUES (2,
        'Plano Completo', 2);
INSERT INTO plans (id, name, medical_agreement_id)
VALUES (3,
        'Plano Popular', 3);
INSERT INTO roles (id, name)
VALUES (4, 'Secretária');
INSERT INTO addresses (id, city_id, address, number, complement)
VALUES (4, 1, 'Rua da Secretária', '123', 'Apto 45');
INSERT INTO users (id, role_id, username, password, name, cpf, rg,
                   phone, address_id, sex)
VALUES (7, 4, 'secretaria123', 'senha123', 'Ana Secretária',
        '666.666.666-66', '6666666', '(11) 66666-6666', 4, 'F');