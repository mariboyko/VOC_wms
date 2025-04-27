-- Insert dummy data into marine_ports (VOC-era ports, ~1630s, unchanged)
-- Truncate marine_ports to remove existing data
TRUNCATE TABLE marine_ports RESTART IDENTITY CASCADE;

-- Insert real VOC-era ports (~1630s)
INSERT INTO marine_ports (port_name, region, port_type, warehouse_capacity, naval_security_level, longitude, latitude) VALUES
    ('Amsterdam', 'Europe', 'Commercial', 80000, 'High', 4.9041, 52.3676),
    ('Batavia', 'Asia', 'Commercial', 100000, 'High', 106.8456, -6.1751),
    ('Malacca', 'Asia', 'Commercial', 60000, 'Medium', 102.2501, 2.1896),
    ('Colombo', 'Asia', 'Commercial', 50000, 'Medium', 79.8612, 6.9271),
    ('Hoorn', 'Europe', 'Commercial', 40000, 'Medium', 5.0606, 52.6413);
-- Truncate the ships table to remove all existing data
TRUNCATE TABLE ships RESTART IDENTITY CASCADE;

-- Insert dummy data into ships (VOC-era ships, ~1630s, including Ganj-i-Sawai and additional historical ships)
INSERT INTO ships (ship_name, capacity_tons, status, home_port_id, owner_id, build_year, last_maintenance, last_trade) VALUES
    ('Batavia', 1200, 'Docked', NULL, NULL, 1628, '1632-06-15', '1632-09-20'), -- Famous VOC ship, fluyt
    ('De Hoop', 800, 'En route', NULL, NULL, 1625, '1632-04-10', '1632-08-25'), -- Common VOC ship name
    ('Vliegende Draeck', 600, 'Under repair', NULL, NULL, 1620, '1632-07-01', '1632-05-30'), -- Pinnace-type
    ('Amstel', 1000, 'Out of service', NULL, NULL, 1618, '1631-12-20', '1631-11-10'), -- Older VOC vessel
    ('Ganj-i-Sawai', 1000, 'En route', NULL, NULL, 1627, '1632-07-15', '1632-09-05'), -- Mughal ship, fictional VOC capture
    ('Wapen van Amsterdam', 800, 'Docked', NULL, NULL, 1629, '1632-08-01', '1632-09-10'), -- Common VOC ship name, corrected from Walch van
    ('Zeven Provincien', 1200, 'Docked', NULL, NULL, 1631, '1632-08-20', '1632-09-25'), -- Famous VOC ship
    ('Hollandia', 1000, 'Docked', NULL, NULL, 1626, '1632-07-10', '1632-08-15'), -- Common VOC ship name
    ('Zeehaen', 1400, 'Docked', NULL, NULL, 1630, '1632-08-05', '1632-09-15'), -- East Indiaman
    ('Mauritius', 1100, 'En route', NULL, NULL, 1612, '1632-06-20', '1632-09-01'), -- Early VOC East Indiaman
    ('Wapen van Hoorn', 900, 'Docked', NULL, NULL, 1619, '1632-07-25', '1632-08-30'), -- VOC fluyt from Hoorn
    ('Sardam', 700, 'Under repair', NULL, NULL, 1628, '1632-08-10', '1632-09-12'), -- VOC yacht, Batavia rescue
    ('Ridderschap van Holland', 1200, 'En route', NULL, NULL, 1623, '1632-07-05', '1632-09-20'), -- VOC East Indiaman
    ('Eendracht', 1000, 'Docked', NULL, NULL, 1615, '1632-06-25', '1632-09-03'); -- VOC ship, charted Australia

    -- Truncate warehouses to remove existing data
TRUNCATE TABLE warehouses RESTART IDENTITY CASCADE;

-- Insert dummy data into warehouses (VOC-era, ~1630s, multiple per port)
INSERT INTO warehouses (port_id, name, current_stock, max_capacity, warehouse_type) VALUES
    (1, 'Amsterdam Main Depot', 20000, 80000, 'General'), -- Amsterdam: textiles, porcelain
    (1, 'Amsterdam Spice Store', 10000, 40000, 'Specialized'), -- Amsterdam: imported spices
    (2, 'Batavia Spice Vault', 30000, 100000, 'Specialized'), -- Batavia: nutmeg, cloves
    (2, 'Batavia Textile Hold', 20000, 60000, 'General'), -- Batavia: silk, cotton
    (3, 'Malacca Trade Store', 15000, 60000, 'General'), -- Malacca: regional goods
    (3, 'Malacca Pepper Cache', 8000, 30000, 'Specialized'), -- Malacca: pepper storage
    (4, 'Colombo Cinnamon Hold', 10000, 50000, 'General'), -- Colombo: cinnamon, goods
    (4, 'Colombo Gem Vault', 5000, 20000, 'Specialized'), -- Colombo: precious stones
    (5, 'Hoorn Shipyard Cache', 8000, 40000, 'General'), -- Hoorn: shipbuilding supplies
    (5, 'Hoorn Timber Yard', 6000, 30000, 'General'); -- Hoorn: wood for ships

    -- Truncate trade_routes to remove existing data
TRUNCATE TABLE trade_routes RESTART IDENTITY CASCADE;

-- Insert dummy data into trade_routes (VOC-era, ~1630s)
INSERT INTO trade_routes (start_port_id, end_port_id, distance_nautical_miles, risk_factor, typical_transit_days, last_updated) VALUES
    (1, 2, 8000, 0.85, 80, '1632-09-01'), -- Amsterdam to Batavia: long spice trade route
    (2, 1, 8000, 0.85, 80, '1632-09-01'), -- Batavia to Amsterdam: return route
    (2, 3, 1000, 0.40, 8, '1632-09-05'), -- Batavia to Malacca: intra-Asian trade
    (3, 2, 1000, 0.40, 8, '1632-09-05'), -- Malacca to Batavia: return route
    (3, 4, 500, 0.30, 5, '1632-09-10'), -- Malacca to Colombo: regional spice trade
    (4, 3, 500, 0.30, 5, '1632-09-10'), -- Colombo to Malacca: return route
    (1, 5, 50, 0.10, 1, '1632-09-15'), -- Amsterdam to Hoorn: short shipbuilding route
    (5, 1, 50, 0.10, 1, '1632-09-15'); -- Hoorn to Amsterdam: return route

    -- Truncate goods to remove existing data
TRUNCATE TABLE goods RESTART IDENTITY CASCADE;

-- Insert dummy data into goods (VOC-era trade goods, ~1630s, 110 entries)
INSERT INTO goods (name, category, origin_country, description, unit_measure, price_per_unit, spoilage_risk) VALUES
    ('Nutmeg', 'Spices', 'Banda Islands', 'High-value spice from nutmeg trees, used in cuisine and medicine.', 'pounds', 120.00, 0.60),
    ('Black Pepper', 'Spices', 'Malabar Coast', 'Common spice for seasoning, traded in bulk.', 'pounds', 15.00, 0.50),
    ('Silk', 'Textiles', 'China', 'Fine silk fabric for European markets, lightweight and luxurious.', 'crates', 200.00, 0.20),
    ('Cotton Calico', 'Textiles', 'India', 'Printed cotton fabric, popular in Europe.', 'crates', 50.00, 0.15),
    ('Porcelain', 'Luxury Goods', 'China', 'Delicate blue-and-white ceramics, prized by European elites.', 'crates', 300.00, 0.05),
    ('Sugar', 'Commodities', 'Java', 'Refined sugar from cane, used in food and trade.', 'barrels', 10.00, 0.40),
    ('Saltpeter', 'Commodities', 'India', 'Potassium nitrate for gunpowder production.', 'barrels', 8.00, 0.10),
    ('Tea', 'Beverages', 'China', 'Early green tea exports, gaining popularity in Europe.', 'pounds', 25.00, 0.70),
    ('Indigo', 'Dyes', 'India', 'Blue dye for textiles, valued in European markets.', 'pounds', 30.00, 0.30),
    ('Pearls', 'Luxury Goods', 'Persian Gulf', 'Precious pearls for jewelry, traded via Asian ports.', 'pounds', 500.00, 0.05),
    ('Cloves', 'Spices', 'Ambon', 'Aromatic spice for culinary and medicinal use.', 'pounds', 100.00, 0.65),
    ('Cinnamon', 'Spices', 'Ceylon', 'Sweet spice from tree bark, highly valued.', 'pounds', 80.00, 0.55),
    ('Mace', 'Spices', 'Banda Islands', 'Spice from nutmeg husk, used in cooking.', 'pounds', 110.00, 0.60),
    ('Cardamom', 'Spices', 'Malabar Coast', 'Fragrant spice for food and medicine.', 'pounds', 40.00, 0.50),
    ('Saffron', 'Spices', 'Persia', 'Rare spice for flavor and dye.', 'pounds', 200.00, 0.70),
    ('Muslin', 'Textiles', 'India', 'Lightweight cotton fabric, prized for quality.', 'crates', 60.00, 0.15),
    ('Chintz', 'Textiles', 'India', 'Colorful printed cotton, popular in Europe.', 'crates', 55.00, 0.15),
    ('Woolen Cloth', 'Textiles', 'Netherlands', 'Heavy fabric for Asian markets.', 'crates', 30.00, 0.10),
    ('Linen', 'Textiles', 'Netherlands', 'Durable fabric for clothing and sails.', 'crates', 25.00, 0.10),
    ('Lacquerware', 'Luxury Goods', 'Japan', 'Ornate wooden items with lacquer finish.', 'crates', 250.00, 0.05),
    ('Ivory', 'Luxury Goods', 'India', 'Carved elephant tusks for decorative items.', 'pounds', 150.00, 0.05),
    ('Ambergris', 'Luxury Goods', 'Indian Ocean', 'Rare substance for perfumes.', 'pounds', 400.00, 0.10),
    ('Rubies', 'Luxury Goods', 'Ceylon', 'Precious red gemstones for jewelry.', 'pounds', 600.00, 0.05),
    ('Copper', 'Metals', 'Japan', 'Metal for trade and coinage.', 'kg', 5.00, 0.05),
    ('Tin', 'Metals', 'Malaya', 'Metal for alloys and utensils.', 'kg', 4.00, 0.05),
    ('Silver', 'Metals', 'Japan', 'Precious metal for trade currency.', 'kg', 50.00, 0.05),
    ('Rice', 'Commodities', 'Java', 'Staple grain for provisions.', 'barrels', 3.00, 0.40),
    ('Teak Timber', 'Commodities', 'Java', 'Hardwood for shipbuilding.', 'barrels', 6.00, 0.10),
    ('Pitch', 'Commodities', 'Indonesia', 'Resin for ship waterproofing.', 'barrels', 4.00, 0.20),
    ('Coir', 'Commodities', 'Ceylon', 'Coconut fiber for ropes.', 'barrels', 2.00, 0.15),
    ('Coffee', 'Beverages', 'Mocha', 'Arabian coffee beans, luxury drink.', 'pounds', 20.00, 0.60),
    ('Dried Mango', 'Food', 'India', 'Preserved fruit for provisions.', 'pounds', 5.00, 0.50),
    ('Wine', 'Beverages', 'Spain', 'European wine for Asian elites.', 'barrels', 12.00, 0.30),
    ('Opium', 'Medicinals', 'India', 'Narcotic for medicinal trade.', 'pounds', 35.00, 0.20),
    ('Tortoiseshell', 'Luxury Goods', 'Indonesia', 'Shell for decorative items.', 'pounds', 100.00, 0.05),
    ('Beeswax', 'Commodities', 'Java', 'Wax for candles and sealing.', 'pounds', 3.00, 0.20),
    ('Cloves', 'Spices', 'Ternate', 'Aromatic spice from Moluccas.', 'pounds', 95.00, 0.65),
    ('Ginger', 'Spices', 'India', 'Spicy root for cooking and medicine.', 'pounds', 10.00, 0.45),
    ('Turmeric', 'Spices', 'India', 'Yellow spice for dye and flavor.', 'pounds', 8.00, 0.40),
    ('Camphor', 'Medicinals', 'Borneo', 'Resinous substance for medicine.', 'pounds', 25.00, 0.30),
    ('Sandalwood', 'Commodities', 'Timor', 'Fragrant wood for carvings.', 'barrels', 15.00, 0.10),
    ('Brocade', 'Textiles', 'Persia', 'Ornate silk fabric with gold threads.', 'crates', 250.00, 0.20),
    ('Velvet', 'Textiles', 'Persia', 'Soft luxury fabric for clothing.', 'crates', 180.00, 0.15),
    ('Damask', 'Textiles', 'China', 'Patterned silk fabric.', 'crates', 200.00, 0.20),
    ('Gold Thread', 'Textiles', 'India', 'Thread for embroidery.', 'pounds', 300.00, 0.10),
    ('Sapanwood', 'Dyes', 'Siam', 'Red dye wood for textiles.', 'barrels', 7.00, 0.15),
    ('Frankincense', 'Resins', 'Arabia', 'Aromatic resin for incense.', 'pounds', 30.00, 0.20),
    ('Myrrh', 'Resins', 'Arabia', 'Resin for perfumes and medicine.', 'pounds', 35.00, 0.20),
    ('Diamonds', 'Luxury Goods', 'India', 'Precious stones from Golconda.', 'pounds', 550.00, 0.05),
    ('Emeralds', 'Luxury Goods', 'India', 'Green gemstones for jewelry.', 'pounds', 500.00, 0.05),
    ('Glass Beads', 'Luxury Goods', 'Netherlands', 'Decorative beads for trade.', 'crates', 10.00, 0.05),
    ('Tobacco', 'Commodities', 'Americas', 'Smoking leaf via Spanish trade.', 'pounds', 12.00, 0.50),
    ('Cacao', 'Beverages', 'Americas', 'Cocoa beans for early chocolate.', 'pounds', 15.00, 0.60),
    ('Vanilla', 'Spices', 'Americas', 'Flavoring spice via Spanish trade.', 'pounds', 50.00, 0.70),
    ('Rosewater', 'Perfumes', 'Persia', 'Fragrant water for cosmetics.', 'barrels', 20.00, 0.30),
    ('Hides', 'Commodities', 'India', 'Leather for European markets.', 'crates', 5.00, 0.15),
    ('Palm Oil', 'Commodities', 'Java', 'Oil for cooking and lamps.', 'barrels', 4.00, 0.40),
    ('Betel Nut', 'Commodities', 'Indonesia', 'Chewing nut for local trade.', 'pounds', 2.00, 0.50),
    ('Nutmeg Oil', 'Medicinals', 'Banda Islands', 'Essential oil from nutmeg.', 'pounds', 150.00, 0.70),
    ('Star Anise', 'Spices', 'China', 'Star-shaped spice for flavor.', 'pounds', 30.00, 0.55),
    ('Coriander', 'Spices', 'India', 'Seed spice for cooking.', 'pounds', 6.00, 0.40),
    ('Fennel', 'Spices', 'India', 'Anise-flavored seed spice.', 'pounds', 7.00, 0.40),
    ('Tamarind', 'Food', 'India', 'Tart fruit for sauces.', 'pounds', 4.00, 0.50),
    ('Dried Fish', 'Food', 'Indonesia', 'Preserved fish for provisions.', 'barrels', 3.00, 0.60),
    ('Honey', 'Food', 'Java', 'Sweetener for trade.', 'barrels', 8.00, 0.50),
    ('Alum', 'Commodities', 'India', 'Mineral for dyeing and tanning.', 'kg', 3.00, 0.10),
    ('Iron', 'Metals', 'India', 'Metal for tools and trade.', 'kg', 2.00, 0.05),
    ('Lead', 'Metals', 'Malaya', 'Metal for weights and shot.', 'kg', 2.50, 0.05),
    ('Sulfur', 'Commodities', 'Indonesia', 'Material for gunpowder.', 'kg', 4.00, 0.10),
    ('Rattan', 'Commodities', 'Indonesia', 'Flexible cane for furniture.', 'crates', 5.00, 0.15),
    ('Bamboo', 'Commodities', 'Java', 'Versatile plant for construction.', 'crates', 3.00, 0.10),
    ('Jade', 'Luxury Goods', 'China', 'Green stone for ornaments.', 'pounds', 400.00, 0.05),
    ('Coral', 'Luxury Goods', 'Indian Ocean', 'Red coral for jewelry.', 'pounds', 200.00, 0.05),
    ('Mother-of-Pearl', 'Luxury Goods', 'Persian Gulf', 'Shell for inlays.', 'pounds', 150.00, 0.05),
    ('Sago', 'Commodities', 'Moluccas', 'Starch for food provisions.', 'barrels', 3.00, 0.40),
    ('Gum Arabic', 'Resins', 'Arabia', 'Resin for adhesives and food.', 'pounds', 10.00, 0.20),
    ('Civet Musk', 'Perfumes', 'Indonesia', 'Animal secretion for perfumes.', 'pounds', 300.00, 0.30),
    ('Ebony', 'Commodities', 'Ceylon', 'Dark wood for furniture.', 'barrels', 12.00, 0.10),
    ('Peppercorns', 'Spices', 'Java', 'Spice for seasoning.', 'pounds', 14.00, 0.50),
    ('Clove Oil', 'Medicinals', 'Ambon', 'Essential oil from cloves.', 'pounds', 140.00, 0.70),
    ('Safflower', 'Dyes', 'India', 'Red dye for textiles.', 'pounds', 20.00, 0.30),
    ('Henna', 'Dyes', 'India', 'Natural dye for hair and skin.', 'pounds', 15.00, 0.40),
    ('Cardamom Pods', 'Spices', 'Ceylon', 'Green spice for flavor.', 'pounds', 45.00, 0.50),
    ('Dried Apricots', 'Food', 'Persia', 'Preserved fruit for trade.', 'pounds', 6.00, 0.50),
    ('Pistachios', 'Food', 'Persia', 'Nuts for luxury consumption.', 'pounds', 10.00, 0.40),
    ('Almonds', 'Food', 'Persia', 'Nuts for trade and provisions.', 'pounds', 8.00, 0.40),
    ('Sisal', 'Commodities', 'Java', 'Fiber for ropes and mats.', 'crates', 4.00, 0.15),
    ('Gambier', 'Dyes', 'Indonesia', 'Extract for tanning and dyeing.', 'pounds', 6.00, 0.30),
    ('Madder Root', 'Dyes', 'India', 'Red dye for textiles.', 'pounds', 12.00, 0.30),
    ('Cinnamon Oil', 'Medicinals', 'Ceylon', 'Essential oil from cinnamon.', 'pounds', 130.00, 0.70),
    ('Sharkskin', 'Commodities', 'Indian Ocean', 'Leather for grips and polishing.', 'crates', 20.00, 0.10),
    ('Sea Salt', 'Commodities', 'India', 'Salt for preservation.', 'barrels', 2.00, 0.20),
    ('Wheat', 'Commodities', 'Netherlands', 'Grain for provisions.', 'barrels', 3.00, 0.40),
    ('Barley', 'Commodities', 'Netherlands', 'Grain for brewing and food.', 'barrels', 3.00, 0.40),
    ('Oats', 'Commodities', 'Netherlands', 'Grain for provisions.', 'barrels', 2.50, 0.40),
    ('Rye', 'Commodities', 'Netherlands', 'Grain for bread.', 'barrels', 2.50, 0.40),
    ('Tallow', 'Commodities', 'India', 'Animal fat for candles.', 'barrels', 4.00, 0.30),
    ('Lard', 'Commodities', 'Netherlands', 'Fat for cooking.', 'barrels', 3.00, 0.40),
    ('Hemp', 'Commodities', 'India', 'Fiber for ropes and sails.', 'crates', 5.00, 0.15),
    ('Flax', 'Commodities', 'Netherlands', 'Fiber for linen production.', 'crates', 6.00, 0.15);