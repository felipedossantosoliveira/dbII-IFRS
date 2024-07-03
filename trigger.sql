CREATE OR REPLACE FUNCTION update_consultation_done()
    RETURNS TRIGGER AS $$
BEGIN
    -- Atualiza o campo 'done' para TRUE na tabela 'medical_consultations'
    UPDATE medical_consultations
    SET done = TRUE
    WHERE id = NEW.medical_consultation_id;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger que chama a função acima após a inserção de uma nova prescrição
CREATE TRIGGER after_prescription_insert
    AFTER INSERT ON prescriptions
    FOR EACH ROW
EXECUTE FUNCTION update_consultation_done();

INSERT INTO prescriptions (medical_consultation_id, description) VALUES (7, 'Tomar 1 comprimido de paracetam por dia');
