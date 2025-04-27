docker exec -it wms_postgres psql -U wms_admin -d wms_db

Startup Steps
1. Set Up the Virtual Environment

python3 -m venv wms_venv
source wms_venv/bin/activate
pip install fastapi psycopg2 uvicorn




2. Start the Database
docker-compose up -d

docker ps

docker exec -it wms_postgres psql -U wms_admin -d wms_db

Goods: Represents the catalog of tradeable items (e.g., spices, timber) with attributes like name, category, and price.
Cargo: Represents specific instances of goods being transported or stored, linked to ships or warehouses.
Orders: Represents customer requests for goods, tied to cargo for fulfillment.
I'll simplify relationships, add constraints, and remove potential redundancies (e.g., warehouse_id in goods).


git config --global user.name "mariboyko"
git config --global user.email "marina.boyko369@gmail.com"