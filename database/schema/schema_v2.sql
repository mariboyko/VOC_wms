-- Ports Table
CREATE TYPE naval_security_level AS ENUM ('Low', 'Medium', 'High');
CREATE TYPE port_type AS ENUM ('Commercial', 'Military', 'Fishing', 'Research');
CREATE TYPE port_region AS ENUM ('Europe', 'Asia', 'Africa', 'Americas', 'Oceania');

-- DROP TABLE IF EXISTS marine_ports CASCADE;
CREATE TABLE marine_ports (
    port_id SERIAL PRIMARY KEY,
    port_name VARCHAR(255) NOT NULL,
    region port_region,
    port_type port_type,
    warehouse_capacity INTEGER NOT NULL CHECK (warehouse_capacity >= 0),
    naval_security_level naval_security_level,
    longitude DECIMAL(9, 6) CHECK (longitude BETWEEN -180 AND 180),
    latitude DECIMAL(9, 6) CHECK (latitude BETWEEN -90 AND 90),
    UNIQUE(port_name)
);

-- Personnel Table
CREATE TYPE personnel_role AS ENUM ('Captain', 'Merchant', 'Warehouse Clerk', 'Navigator', 'Dock Supervisor', 'Sailor');
CREATE TYPE personnel_status AS ENUM ('Active', 'Inactive', 'On Leave');
CREATE TYPE personnel_rank AS ENUM ('Junior', 'Mid-level', 'Senior');

-- DROP TABLE IF EXISTS personnel CASCADE;
CREATE TABLE personnel (
    person_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    role personnel_role,
    status personnel_status,
    rank personnel_rank,
    ship_id INTEGER, -- No REFERENCES yet
    port_id INTEGER, -- No REFERENCES yet
    UNIQUE(name, ship_id)
);
-- Ships Table
-- DROP TYPE ship_status;
CREATE TYPE ship_status AS ENUM ('Docked', 'En route', 'Under repair', 'Out of service');
-- DROP TABLE IF EXISTS ships CASCADE;
CREATE TABLE ships (
    ship_id SERIAL PRIMARY KEY,
    ship_name VARCHAR(255) NOT NULL,
    capacity_tons INTEGER NOT NULL CHECK (capacity_tons > 0),
    status ship_status NOT NULL,
    home_port_id INTEGER, -- No REFERENCES yet
    owner_id INTEGER, -- No REFERENCES yet
    build_year INTEGER CHECK (build_year >= 1500),
    last_maintenance DATE,
    last_trade DATE,
    UNIQUE(ship_name)
);

-- Add foreign key constraints
ALTER TABLE ships
    ADD CONSTRAINT fk_ships_home_port_id FOREIGN KEY (home_port_id) REFERENCES marine_ports(port_id) ON DELETE SET NULL,
    ADD CONSTRAINT fk_ships_owner_id FOREIGN KEY (owner_id) REFERENCES personnel(person_id) ON DELETE SET NULL;

ALTER TABLE personnel
    ADD CONSTRAINT fk_personnel_ship_id FOREIGN KEY (ship_id) REFERENCES ships(ship_id) ON DELETE SET NULL,
    ADD CONSTRAINT fk_personnel_port_id FOREIGN KEY (port_id) REFERENCES marine_ports(port_id) ON DELETE SET NULL;
    -- Warehouses Table
CREATE TYPE warehouse_type_enum AS ENUM ('General', 'Specialized');
DROP TABLE IF EXISTS warehouses CASCADE;
CREATE TABLE warehouses (
    warehouse_id SERIAL PRIMARY KEY,
    port_id INTEGER REFERENCES marine_ports(port_id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL UNIQUE, -- Added for distinct identity
    current_stock INTEGER DEFAULT 0 CHECK (current_stock >= 0),
    max_capacity INTEGER CHECK (max_capacity > 0),
    warehouse_type warehouse_type_enum NOT NULL, -- Ensured NOT NULL
    UNIQUE(port_id),
    CHECK (current_stock <= max_capacity) -- Added for stock realism
);

-- Goods Table
CREATE TYPE unit_measure_enum AS ENUM ('pounds', 'barrels', 'crates', 'kg');
-- DROP TABLE IF EXISTS goods CASCADE;
CREATE TABLE goods (
    good_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    category VARCHAR(100),
    origin_country VARCHAR(100),
    description TEXT,
    unit_measure unit_measure_enum NOT NULL,
    price_per_unit DECIMAL(10, 2) CHECK (price_per_unit >= 0),
    spoilage_risk DECIMAL(3, 2) DEFAULT 0 CHECK (spoilage_risk BETWEEN 0 AND 1), -- Inherent risk of the good type
    UNIQUE(name, origin_country)
);
-- Cargo Table
CREATE TYPE cargo_unit_enum AS ENUM ('pounds', 'barrels', 'crates');
CREATE TYPE cargo_status_enum AS ENUM ('In Transit', 'Stored', 'Damaged', 'Lost');
CREATE TYPE cargo_quality_enum AS ENUM ('Excellent', 'Good', 'Fair', 'Poor');
-- DROP TABLE IF EXISTS cargo CASCADE;
CREATE TABLE cargo (
    cargo_id SERIAL PRIMARY KEY,
    good_id INTEGER REFERENCES goods(good_id) ON DELETE CASCADE,
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    unit unit_measure_enum NOT NULL,
    status cargo_status_enum NOT NULL,
    quality cargo_quality_enum,
    value_guilders INTEGER CHECK (value_guilders >= 0),
    ship_id INTEGER REFERENCES ships(ship_id) ON DELETE SET NULL,
    warehouse_id INTEGER REFERENCES warehouses(warehouse_id) ON DELETE SET NULL,
    spoilage_risk DECIMAL(3, 2) CHECK (spoilage_risk BETWEEN 0 AND 1), -- Risk adjusted for shipment conditions
    theft_risk DECIMAL(3, 2) CHECK (theft_risk BETWEEN 0 AND 1),
    arrival_date DATE
);
-- Trade Routes Table
-- DROP TABLE IF EXISTS trade_routes CASCADE;
CREATE TABLE trade_routes (
    route_id SERIAL PRIMARY KEY,
    start_port_id INTEGER REFERENCES marine_ports(port_id) ON DELETE CASCADE,
    end_port_id INTEGER REFERENCES marine_ports(port_id) ON DELETE CASCADE,
    distance_nautical_miles INTEGER CHECK (distance_nautical_miles > 0),
    risk_factor DECIMAL(3, 2) CHECK (risk_factor BETWEEN 0 AND 1),
    typical_transit_days INTEGER CHECK (typical_transit_days > 0),
    last_updated DATE DEFAULT CURRENT_DATE,
    UNIQUE(start_port_id, end_port_id)
);

-- Orders Table
CREATE TYPE order_status_enum AS ENUM ('Pending', 'Shipped', 'Delivered');
CREATE TYPE order_urgency_enum AS ENUM ('Low', 'Medium', 'High');
-- DROP TABLE IF EXISTS orders CASCADE;
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    destination_port_id INTEGER REFERENCES marine_ports(port_id) ON DELETE CASCADE,
    status order_status_enum NOT NULL,
    order_date DATE DEFAULT CURRENT_DATE,
    urgency_level order_urgency_enum,
    expected_delivery_date DATE
);

-- Order_Goods Table (Links orders to goods with quantity)
-- DROP TABLE IF EXISTS order_goods CASCADE;
CREATE TABLE order_goods (
    order_id INTEGER REFERENCES orders(order_id) ON DELETE CASCADE,
    good_id INTEGER REFERENCES goods(good_id) ON DELETE CASCADE,
    quantity INTEGER CHECK (quantity > 0),
    PRIMARY KEY (order_id, good_id)
);
-- Cargo_Orders Table (Links cargo to orders for fulfillment)
-- DROP TABLE IF EXISTS cargo_orders CASCADE;
CREATE TABLE cargo_orders (
    cargo_id INTEGER REFERENCES cargo(cargo_id) ON DELETE CASCADE,
    order_id INTEGER REFERENCES orders(order_id) ON DELETE CASCADE,
    PRIMARY KEY (cargo_id, order_id)
);

-- Indexes
CREATE INDEX idx_cargo_good_id ON cargo(good_id);
CREATE INDEX idx_cargo_ship_id ON cargo(ship_id);
CREATE INDEX idx_cargo_warehouse_id ON cargo(warehouse_id);
CREATE INDEX idx_order_goods_order_id ON order_goods(order_id);
CREATE INDEX idx_order_goods_good_id ON order_goods(good_id);
CREATE INDEX idx_cargo_orders_cargo_id ON cargo_orders(cargo_id);
CREATE INDEX idx_cargo_orders_order_id ON cargo_orders(order_id);




ALTER TABLE warehouses DROP CONSTRAINT warehouses_port_id_key;
