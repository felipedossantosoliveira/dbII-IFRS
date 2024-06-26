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


INSERT INTO users (role_id, username, password, name, cpf, rg, phone, address_id, sex)
-- admin (role_id = 1)
VALUES (1, 'carlos', 'sha256password', 'Carlos Silva', '94804866019', '313879527', '1112345678', 1, 'F'),
-- doctor (role_id = 2)
       (2, 'joao', 'sha256password', 'João Silva', '76124747006', '164480559', '11987654321', 2, 'M'),
-- patient (role_id = 3)
       (3, 'maria', 'sha256password', 'Maria Souza', '24652397089', '149009264', '21876543210', 3, 'F'),
-- secretary (role_id = 4)
       (4, 'jose', 'sha256password', 'José', '28213752040', '101086283', '11111111111', 1, 'M');

-- Cadastro de relacionamento de doutor
INSERT INTO doctor (user_id, crm)
VALUES (2, '12345');

-- Cadastro de relacionamento de paciente
INSERT INTO patients (user_id, medical_agreement_id)
VALUES (3, 1);

-- Cadastro da tabela cidade
INSERT INTO cids (name, code)
VALUES ('Gastrite', 'K29'),
       ('Infecção viral', 'B34'),
       ('Hipercolesterolemia', 'E78');

-- Cadastro de dados da clínica
INSERT INTO clinic (address_id, name, cnpj, phone, header)
VALUES (1, 'Clínica Popular São Paulo', '12345678901234', '1111112222', 'Clínica especializada em cuidados primários');

-- Cadastro de compromissos médicos
INSERT INTO medical_appointments (doctor_id, initial_date, final_date, description)
VALUES (1, '2024-06-25 10:00:00', '2024-06-25 10:30:00', 'Consulta de rotina'),
       (1, '2024-06-26 11:00:00', '2024-06-26 11:30:00', 'Consulta de acompanhamento'),
       (1, '2024-06-27 12:00:00', '2024-06-27 12:30:00', 'Consulta de retorno');

-- Cadastro de consultas médicas
INSERT INTO medical_consultations (medical_appointment_id, patient_id, observation, diagnostic, done)
VALUES (1, 1, 'Paciente queixa-se de dores abdominais', 'Gastrite leve', true),
       (2, 1, 'Paciente com febre persistente', 'Infecção viral', true),
       (3, 1, 'Paciente precisa de renovação de receita', NULL, false);

-- Cadastro de atestados
INSERT INTO medical_certificates (medical_consultation_id, cid_id, description)
VALUES (1, 1, 'Receita de medicamento para alívio da gastrite'),
       (2, 2, 'Afastamento por 3 dias devido à infecção viral'),
       (3, 3, 'Necessidade de dieta e acompanhamento médico para controle de colesterol');

-- Cadastro de receitas
INSERT INTO prescriptions (medical_consultation_id, description)
VALUES (1, 'Omeprazol 20mg, 1 comprimido ao dia'),
       (2, 'Repouso, hidratação e analgésico para febre'),
       (3, 'Tylenol');