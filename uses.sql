-- UC001 – Cadastrar secretárias
-- UC001.1 – Cadastrar usuário
INSERT INTO users (role_id, username, password, name, cpf, rg, phone, sex)
VALUES (4, 'bia', 'sha256password', 'Bia da secretaria', '67667667666', '6677666', '11667766766', 'F');

-- UC001.2 – Cadastrar endereço
INSERT INTO addresses (city_id, address, number, complement)
VALUES (2207009, 'Rua Nova', '123', 'Apto 45');

-- UC001.3 – Vincular endereço ao usuário
UPDATE users
SET address_id = 4
WHERE id = 5;

-- UC002 – Cadastrar médicos
-- UC002.1 – Cadastrar usuário
INSERT INTO users (role_id, username, password, name, cpf, rg, phone, sex)
VALUES (2, 'rogerio', 'sha256password', 'Rogério da Silva', '67667667434', '6677444', '11667766766', 'M');
-- UC002.2 – Cadastrar endereço
INSERT INTO addresses (city_id, address, number, complement)
VALUES (5203906, 'Rua Velha', '321', 'Apto 54');
-- UC002.3 – Vincular endereço ao usuário
UPDATE users
SET address_id = 5
WHERE id = 6;
-- UC002.4 – Cadastrar na tabela de doctors
INSERT INTO doctor (user_id, crm)
VALUES (6, '1234567');

-- UC003 – Buscar médicos
-- UC003.1 – Buscar todos os médicos
SELECT u.name, u.phone, d.crm
FROM users u
         LEFT JOIN doctor d ON u.id = d.user_id
WHERE role_id = 2;

-- UC003.2 – Buscar médico por CRM
SELECT u.name, u.phone, d.crm
FROM users u
         LEFT JOIN doctor d ON u.id = d.user_id
WHERE role_id = 2
  AND d.crm ILIKE '%1234567%';

-- UC003.3 – Buscar médico por nome
SELECT u.name, u.phone, d.crm
FROM users u
         LEFT JOIN doctor d ON u.id = d.user_id
WHERE role_id = 2
  AND u.name ILIKE '%Rogério%';

-- UC004 - Alterar médicos
-- UC004.1 – Alterar dados do médico
UPDATE users
SET name = 'Rogério da Silva Santos'
WHERE id = 6;

-- UC004.2 – Alterar endereço de médicos
UPDATE addresses
SET address = 'Avenida do desespero'
WHERE id = 5;

-- UC005 - Cadastro de pacientes
-- UC005.1 – Cadastrar usuário
INSERT INTO users (role_id, username, password, name, cpf, rg, phone, sex)
VALUES (3, 'abelardo', 'sha256password', 'Abelardo Dentadura', '67667667066', '6677066', '11667760766', 'M');

-- UC005.2 – Cadastrar endereço
INSERT INTO addresses (city_id, address, number, complement)
VALUES (5203906, 'Travessa do frango assado', '321', 'Apto 54');

-- UC005.3 – Vincular endereço ao usuário
UPDATE users
SET address_id = 6
WHERE id = 7;

-- UC005.4 – Cadastrar na tabela de patients
INSERT INTO patients (user_id, medical_agreement_id)
VALUES (7, 2);

-- UC006 - Buscar pacientes
-- UC006.1 – Buscar todos os pacientes
SELECT u.name, u.phone, u.cpf
FROM users u
WHERE role_id = 3;

-- UC006.2 – Buscar paciente por CPF
SELECT u.name, u.phone, u.cpf
FROM users u
WHERE role_id = 3
  AND u.cpf ILIKE '%67667667066%';

-- UC006.3 – Buscar paciente por nome
SELECT u.name, u.phone, u.cpf
FROM users u
WHERE role_id = 3
  AND u.name ILIKE '%Abelardo%';

-- UC007 - Alterar pacientes
-- UC007.1 – Alterar dados do paciente
UPDATE users
SET name = 'Abelardo Dentadura da Silva'
WHERE id = 7;

-- UC007.2 – Alterar endereço de pacientes
UPDATE addresses
SET address = 'Avenida do desespero'
WHERE id = 6;

-- UC008 - Cadastrar convênios
-- UC008.1 – Cadastrar convênio
INSERT INTO medical_agreements (name, phone, cnpj)
VALUES ('Ipê', '1199998882', '12345678901236');

-- UC008.2 – Cadastrar endereço do convênio
INSERT INTO addresses (city_id, address, number, complement)
VALUES (5203906, 'Rua do Ipê', '321', 'Apto 54');

-- UC008.3 – Vincular endereço ao convênio
UPDATE medical_agreements
SET address_id = 7
WHERE id = 4;

-- UC008.4 – Cadastrar Planos
INSERT INTO plans (medical_agreement_id, name)
VALUES (2, 'Plano Ipê');

-- UC009 - Buscar convênios
-- UC009.1 – Buscar todos os convênios
SELECT ma.name, ma.phone, ma.cnpj
FROM medical_agreements ma;

-- UC009.2 – Buscar convênio por CNPJ
SELECT ma.name, ma.phone, ma.cnpj
FROM medical_agreements ma
WHERE ma.cnpj ILIKE '%12345678901236%';

-- UC009.3 – Buscar convênio por nome
SELECT ma.name, ma.phone, ma.cnpj
FROM medical_agreements ma
WHERE ma.name ILIKE '%Ipê%';

-- UC010 - Marcar consulta
-- UC010.1 – Cadastrar consulta
INSERT INTO medical_appointments (doctor_id, initial_date, final_date)
VALUES (1, '2024-07-01 09:00:00', '2024-07-01 11:30:00');
INSERT INTO medical_consultations (patient_id, medical_appointment_id, observation, done)
VALUES (1, 4, 'Consulta de rotina', false);

-- UC011 - Buscar consultas
-- O sistema deve permitir a busca de consultas pelo CRM do médico, CPF do cliente ou por uma data.
-- UC011.1 – Buscar todas as consultas
SELECT u.name as doctor, u2.name, mc.observation, mc.done, ma.initial_date, ma.final_date as patient
FROM medical_consultations mc
         LEFT JOIN medical_appointments ma ON ma.id = mc.medical_appointment_id
         LEFT JOIN doctor dc ON ma.doctor_id = dc.id
         LEFT JOIN users u ON dc.user_id = u.id
         LEFT JOIN patients p ON mc.patient_id = p.id
         LEFT JOIN users u2 ON p.user_id = u2.id
ORDER BY ma.initial_date;


-- UC011.2 – Buscar consultas por CRM do médico
SELECT mc.observation, mc.done, ma.initial_date, ma.final_date, u.name as doctor, u2.name as patient, dc.crm
FROM medical_consultations mc
         LEFT JOIN medical_appointments ma ON mc.medical_appointment_id = ma.id
         LEFT JOIN doctor dc ON ma.doctor_id = dc.id
         LEFT JOIN users u ON dc.user_id = u.id
         LEFT JOIN patients p ON mc.patient_id = p.id
         LEFT JOIN users u2 ON p.user_id = u2.id
WHERE dc.crm ILIKE '%12345%'
ORDER BY ma.initial_date;

-- UC011.3 – Buscar consultas por CPF do paciente
SELECT mc.observation,
       mc.done,
       ma.initial_date,
       ma.final_date,
       u.name  as doctor,
       u2.name as patient,
       u2.cpf  as patient_cpf
FROM medical_consultations mc
         LEFT JOIN medical_appointments ma ON mc.medical_appointment_id = ma.id
         LEFT JOIN doctor dc ON ma.doctor_id = dc.id
         LEFT JOIN users u ON dc.user_id = u.id
         LEFT JOIN patients p ON mc.patient_id = p.id
         LEFT JOIN users u2 ON p.user_id = u2.id
WHERE u2.cpf ILIKE '%24652397089%';

-- UC011.4 – Buscar consultas por data
SELECT mc.observation, mc.done, ma.initial_date, ma.final_date, u.name as doctor, u2.name as patient
FROM medical_consultations mc
         LEFT JOIN medical_appointments ma ON mc.medical_appointment_id = ma.id
         LEFT JOIN doctor dc ON ma.doctor_id = dc.id
         LEFT JOIN users u ON dc.user_id = u.id
         LEFT JOIN patients p ON mc.patient_id = p.id
         LEFT JOIN users u2 ON p.user_id = u2.id
WHERE ma.initial_date BETWEEN '2024-07-01 00:00:00' AND '2024-07-01 23:59:59';

-- UC012 - Marcar compromissos de médicos
-- UC012.1 – Cadastrar compromisso
INSERT INTO medical_appointments (doctor_id, initial_date, final_date, description)
VALUES (1, '2024-07-01 14:00:00', '2024-07-01 15:00:00', 'Cirurgia de joelho');

-- UC013 - Consultar agenda médica
-- UC013.1 – Buscar todos os compromissos
SELECT u.name, ma.initial_date, ma.final_date, ma.description, u2.name as patient
FROM medical_appointments ma
         LEFT JOIN doctor d ON ma.doctor_id = d.id
         LEFT JOIN users u ON d.user_id = u.id
         LEFT JOIN medical_consultations mc ON ma.id = mc.medical_appointment_id
         LEFT JOIN patients p ON mc.patient_id = p.id
         LEFT JOIN users u2 ON p.user_id = u2.id;

-- UC014 - Gerar relatórios
-- UC014.1 – Buscar médicos
SELECT u.name, u.phone, d.crm
FROM users u
         LEFT JOIN doctor d ON u.id = d.user_id
WHERE role_id = 2;

-- UC014.2 - Buscar pacientes
SELECT u.name, u.phone, u.cpf
FROM users u
WHERE role_id = 3;

-- UC014.3 - Buscar convênios
SELECT ma.name, ma.phone, ma.cnpj, a.address, a.number, a.complement, p.name as plan
FROM medical_agreements ma
LEFT JOIN addresses a ON ma.address_id = a.id
LEFT JOIN plans p ON ma.id = p.medical_agreement_id
ORDER BY ma.name;

-- UC014.4 - Buscar consultas em um intervalo de datas
SELECT u.name as doctor, u2.name, mc.observation, mc.done, ma.initial_date, ma.final_date as patient
FROM medical_consultations mc
         LEFT JOIN medical_appointments ma ON ma.id = mc.medical_appointment_id
         LEFT JOIN doctor dc ON ma.doctor_id = dc.id
         LEFT JOIN users u ON dc.user_id = u.id
         LEFT JOIN patients p ON mc.patient_id = p.id
         LEFT JOIN users u2 ON p.user_id = u2.id
WHERE ma.initial_date BETWEEN '2023-07-01 00:00:00' AND '2025-07-01 23:59:59'
ORDER BY ma.initial_date;

-- UC015 - Consultar tabela CID
-- UC015.1 – Buscar todas as CIDs
SELECT name, code FROM cids;

-- UC016 - Realizar consulta
UPDATE medical_consultations SET done = true, diagnostic = 'Morreu' WHERE id = 4;

-- UC017 - Emitir receitas e atestados
-- UC017.1 – Cadastrar receita
INSERT INTO prescriptions (medical_consultation_id, description)
VALUES (4, 'Fluoxetina 20mg');

-- UC017.2 – Cadastrar atestado
INSERT INTO medical_certificates (medical_consultation_id,cid_id,description)
VALUES (4,1,'Afastado por 15 dias');

-- UC018 - Login
SELECT *
FROM users
WHERE username = '$username'
  AND password = '$password'
  AND role_id = '$role_id';

-- UC019 - Informações da clínica
INSERT INTO clinic (address_id, name, cnpj, phone, header)
VALUES (1, 'Clínica Popular São Paulo', '12345678901234', '1111112222', 'Clínica especializada em cuidados primários');








