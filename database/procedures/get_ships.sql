CREATE OR REPLACE PROCEDURE get_ships(
    OUT p_result JSON,
    IN p_limit INTEGER DEFAULT 100,
    IN p_offset INTEGER DEFAULT 0
)
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT json_build_object(
        'ships', COALESCE(json_agg(
            json_build_object(
                'ship_id', ship_id,
                'ship_name', ship_name,
                'capacity_tons', capacity_tons,
                'status', status,
                'home_port_id', home_port_id,
                'owner_id', owner_id,
                'build_year', build_year,
                'last_maintenance', last_maintenance,
                'last_trade', last_trade
            )
        ), '[]'::json)
    )
    INTO p_result
    FROM (
        SELECT 
            ship_id,
            ship_name,
            capacity_tons,
            status,
            home_port_id,
            owner_id,
            build_year,
            last_maintenance,
            last_trade
        FROM ships
        ORDER BY ship_name
        LIMIT p_limit OFFSET p_offset
    ) AS subquery;
END;
$$;