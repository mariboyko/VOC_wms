from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from .db import get_db
from .api import goods, orders, ships, personnel  # Ensure 'goods' is imported

app = FastAPI()

# Add CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Allows frontend at http://localhost:3000
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(goods.router)  # Include goods router
app.include_router(orders.router)
app.include_router(ships.router)
app.include_router(personnel.router)

@app.get("/")
def read_root():
    return {"message": "Welcome to the Battleship WMS!"}