CREATE OR REPLACE PROCEDURE add_personnel(
    IN p_name VARCHAR(255),
    IN p_role personnel_role,
    IN p_status personnel_status,
    IN p_rank personnel_rank,
    IN p_ship_id INTEGER,
    IN p_port_id INTEGER,
    OUT p_result JSON
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Validate inputs
    IF p_name IS NULL OR TRIM(p_name) = '' THEN
        p_result := json_build_object('status', 'error', 'message', 'Name cannot be empty');
        RETURN;
    END IF;

    -- Validate ship_id (if provided)
    IF p_ship_id IS NOT NULL THEN
        IF NOT EXISTS (SELECT 1 FROM ships WHERE ship_id = p_ship_id) THEN
            p_result := json_build_object('status', 'error', 'message', 'Invalid ship_id');
            RETURN;
        END IF;
    END IF;

    -- Validate port_id (if provided)
    IF p_port_id IS NOT NULL THEN
        IF NOT EXISTS (SELECT 1 FROM marine_ports WHERE port_id = p_port_id) THEN
            p_result := json_build_object('status', 'error', 'message', 'Invalid port_id');
            RETURN;
        END IF;
    END IF;

    -- Check for unique constraint (name, ship_id)
    IF EXISTS (SELECT 1 FROM personnel WHERE name = p_name AND ship_id = p_ship_id) THEN
        p_result := json_build_object('status', 'error', 'message', 'Personnel with this name and ship_id already exists');
        RETURN;
    END IF;

    -- Insert personnel
    INSERT INTO personnel (name, role, status, rank, ship_id, port_id)
    VALUES (p_name, p_role, p_status, p_rank, p_ship_id, p_port_id)
    RETURNING person_id INTO p_result;

    p_result := json_build_object(
        'status', 'success',
        'message', 'Personnel added successfully',
        'person_id', p_result
    );
EXCEPTION
    WHEN OTHERS THEN
        p_result := json_build_object('status', 'error', 'message', format('Error adding personnel: %s', SQLERRM));
END;
$$;