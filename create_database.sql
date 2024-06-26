-- PostgreSQL
CREATE DATABASE health_system;

CREATE TABLE states (
    id INT NOT NULL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    abbreviation CHAR(2) NOT NULL
);

CREATE TABLE medical_agreements (
    id SERIAL PRIMARY KEY,
    address_id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    cnpj VARCHAR(14) NOT NULL
);

CREATE TABLE medical_consultations (
    id SERIAL PRIMARY KEY,
    medical_appointment_id INT NULL,
    patient_id INT NOT NULL,
    observation VARCHAR(255) NULL,
    diagnostic VARCHAR(255) NULL,
    done BOOLEAN NOT NULL
);

CREATE TABLE cities (
    id INT NOT NULL PRIMARY KEY,
    state_id INT NOT NULL,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE roles (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE doctor (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    crm VARCHAR(255) NOT NULL
);

CREATE TABLE patients (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    medical_agreement_id INT NOT NULL
);

CREATE TABLE cids (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    code VARCHAR(255) NOT NULL
);

CREATE TABLE clinic (
    id SERIAL PRIMARY KEY,
    address_id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    cnpj VARCHAR(14) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    header TEXT NOT NULL
);

CREATE TABLE medical_certificates (
    id SERIAL PRIMARY KEY,
    medical_consultation_id INT NOT NULL,
    cid_id INT NOT NULL,
    description VARCHAR(255) NOT NULL
);

CREATE TABLE addresses (
    id SERIAL PRIMARY KEY,
    city_id INT NOT NULL,
    address VARCHAR(255) NOT NULL,
    number VARCHAR(255) NOT NULL,
    complement VARCHAR(255) NOT NULL
);

CREATE TABLE medical_appointments (
    id SERIAL PRIMARY KEY,
    doctor_id INT NOT NULL,
    initial_date TIMESTAMP NOT NULL,
    final_date TIMESTAMP NOT NULL,
    description VARCHAR(255) NULL
);

CREATE TABLE prescriptions (
    id SERIAL PRIMARY KEY,
    medical_consultation_id INT NOT NULL,
    description VARCHAR(255) NOT NULL
);

CREATE TABLE plans (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    medical_agreement_id INT NOT NULL
);

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    role_id INT NOT NULL,
    username VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL,
    cpf VARCHAR(255) NOT NULL,
    rg VARCHAR(255) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    address_id INT NOT NULL,
    sex CHAR(1) NOT NULL
);

ALTER TABLE plans
    ADD CONSTRAINT plans_medical_agreement_id_foreign FOREIGN KEY (medical_agreement_id) REFERENCES medical_agreements (id);

ALTER TABLE patients
    ADD CONSTRAINT patients_medical_agreement_id_foreign FOREIGN KEY (medical_agreement_id) REFERENCES medical_agreements (id);

ALTER TABLE clinic
    ADD CONSTRAINT clinics_address_id_foreign FOREIGN KEY (address_id) REFERENCES addresses (id);

ALTER TABLE medical_certificates
    ADD CONSTRAINT medical_certificates_cid_id_foreign FOREIGN KEY (cid_id) REFERENCES cids (id);

ALTER TABLE patients
    ADD CONSTRAINT patients_user_id_foreign FOREIGN KEY (user_id) REFERENCES users (id);

ALTER TABLE prescriptions
    ADD CONSTRAINT prescriptions_medical_consultation_id_foreign FOREIGN KEY (medical_consultation_id) REFERENCES medical_consultations (id);

ALTER TABLE cities
    ADD CONSTRAINT cities_state_id_foreign FOREIGN KEY (state_id) REFERENCES states (id);

ALTER TABLE users
    ADD CONSTRAINT users_address_id_foreign FOREIGN KEY (address_id) REFERENCES addresses (id);

ALTER TABLE medical_certificates
    ADD CONSTRAINT medical_certificates_medical_consultation_id_foreign FOREIGN KEY (medical_consultation_id) REFERENCES medical_consultations (id);

ALTER TABLE users
    ADD CONSTRAINT users_role_id_foreign FOREIGN KEY (role_id) REFERENCES roles (id);

ALTER TABLE medical_consultations
    ADD CONSTRAINT medical_consultations_medical_appointment_id_foreign FOREIGN KEY (medical_appointment_id) REFERENCES medical_appointments (id);

ALTER TABLE doctor
    ADD CONSTRAINT doctor_user_id_foreign FOREIGN KEY (user_id) REFERENCES users (id);

ALTER TABLE addresses
    ADD CONSTRAINT addresses_city_id_foreign FOREIGN KEY (city_id) REFERENCES cities (id);
