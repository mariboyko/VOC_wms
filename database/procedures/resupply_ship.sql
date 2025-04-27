-- functions/resupply_ship.sql
CREATE OR REPLACE FUNCTION resupply_ship(ship_id INT, port_id INT, qty INT) RETURNS VOID AS $$
BEGIN
    UPDATE inventory
    SET quantity = quantity + qty
    WHERE item_id IN (SELECT item_id FROM cargo WHERE ship_id = ship_id)
      AND port_id = port_id;
END;
$$ LANGUAGE plpgsql;