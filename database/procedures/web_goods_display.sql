CREATE OR REPLACE PROCEDURE web_goods_display(
    IN p_request JSON,
    INOUT p_response JSON
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_query JSON := p_request->'query';
    v_command VARCHAR(32) := COALESCE(v_query->>'command', 'view_search');
    v_filter_category VARCHAR(100) := v_query->>'filter_category';
    v_filter_origin_country VARCHAR(100) := v_query->>'filter_origin_country';
    v_filter_unit_measure VARCHAR(32) := v_query->>'filter_unit_measure';
    v_limit INT := COALESCE((v_query->>'limit')::INT, 10);
    v_offset INT := COALESCE((v_query->>'offset')::INT, 0);
    v_response_command VARCHAR(32) := v_command;
    v_goods_array JSON;
    v_pagination JSON;
    v_headers JSON := '[
        {"name": "ID", "key": "good_id", "type": "numeric"},
        {"name": "Name", "key": "name", "type": "string"},
        {"name": "Category", "key": "category", "type": "string"},
        {"name": "Origin Country", "key": "origin_country", "type": "string"},
        {"name": "Unit Measure", "key": "unit_measure", "type": "string"},
        {"name": "Price per Unit", "key": "price_per_unit", "type": "numeric"}
    ]';
    v_filters JSON;
    v_total_count INT;
BEGIN
    IF v_command = 'view_search' THEN
        -- Calculate total count for pagination
        SELECT COUNT(*)
        INTO v_total_count
        FROM goods
        WHERE (v_filter_category IS NULL OR category = v_filter_category)
          AND (v_filter_origin_country IS NULL OR origin_country = v_filter_origin_country)
          AND (v_filter_unit_measure IS NULL OR unit_measure::TEXT = v_filter_unit_measure);

        -- Fetch goods data
        SELECT JSON_AGG(
            JSON_BUILD_OBJECT(
                'good_id', g.good_id,
                'name', g.name,
                'category', g.category,
                'origin_country', g.origin_country,
                'unit_measure', g.unit_measure,
                'price_per_unit', g.price_per_unit
            )
        ) INTO v_goods_array
        FROM goods g
        WHERE (v_filter_category IS NULL OR g.category = v_filter_category)
          AND (v_filter_origin_country IS NULL OR g.origin_country = v_filter_origin_country)
          AND (v_filter_unit_measure IS NULL OR g.unit_measure::TEXT = v_filter_unit_measure)
        ORDER BY g.good_id
        LIMIT v_limit OFFSET v_offset;

        -- Handle empty results
        IF v_goods_array IS NULL THEN
            v_goods_array := '[]'::JSON;
        END IF;

        -- Build pagination info
        v_pagination := JSON_BUILD_OBJECT(
            'total_count', v_total_count,
            'limit', v_limit,
            'offset', v_offset,
            'page', (v_offset / v_limit) + 1,
            'total_pages', CEIL(v_total_count::FLOAT / v_limit)::INT
        );

        -- Build filter info
        v_filters := JSON_BUILD_OBJECT(
            'category', JSON_BUILD_OBJECT(
                'name', 'Category',
                'value', v_filter_category,
                'type', 'string'
            ),
            'origin_country', JSON_BUILD_OBJECT(
                'name', 'Origin Country',
                'value', v_filter_origin_country,
                'type', 'string'
            ),
            'unit_measure', JSON_BUILD_OBJECT(
                'name', 'Unit Measure',
                'value', v_filter_unit_measure,
                'type', 'enum',
                'options', JSON_ARRAY('pounds', 'barrels', 'crates', 'kg')
            )
        );

        -- Construct response
        p_response := JSONB_BUILD_OBJECT(
            'command', v_response_command,
            'goods', v_goods_array,
            'headers', v_headers,
            'pagination', v_pagination,
            'filters', v_filters,
            'error', ''
        );
    ELSE
        p_response := JSONB_BUILD_OBJECT(
            'command', v_response_command,
            'error', 'Unknown command'
        );
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        p_response := JSONB_BUILD_OBJECT(
            'command', v_response_command,
            'error', SQLERRM
        );
END;
$$;