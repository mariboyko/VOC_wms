test


wms_project/
├── backend/         ← FastAPI app
│   ├── main.py
│   ├── db.py        ← connection, utils
│   ├── api/         ← route handlers
│   │   ├── items.py
│   │   └── orders.py
│   └── models/      ← optional, DTOs or data classes
│
├── database/              ← Database-related stuff
│   ├── schema.sql   ← table definitions
│   ├── functions/   ← stored procs (SQL files)
│   └── seeds.sql    ← optional test data
│
├── frontend/        ← React
│   ├── public/
│   └── src/
│
│── docker/
│   ├── Dockerfile.postgres
│   └── init/
├── docker-compose.yml
├── .env             ← db creds, config
└── README.md