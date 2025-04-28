CREATE OR REPLACE PROCEDURE get_goods(
    OUT p_result JSON,
    IN p_limit INTEGER DEFAULT 100,
    IN p_offset INTEGER DEFAULT 0
)
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT json_build_object(
        'goods', COALESCE(json_agg(
            json_build_object(
                'good_id', good_id,
                'name', name,
                'category', category,
                'origin_country', origin_country,
                'unit_measure', unit_measure,
                'price_per_unit', price_per_unit,
                'spoilage_risk', spoilage_risk
            )
        ), '[]'::json)
    )
    INTO p_result
    FROM (
        SELECT 
            good_id,
            name,
            category,
            origin_country,
            unit_measure,
            price_per_unit,
            spoilage_risk
        FROM goods
        ORDER BY name
        LIMIT p_limit OFFSET p_offset
    ) AS subquery;
END;
$$;