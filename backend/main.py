from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from .db import get_db
from .api import items, orders

app = FastAPI()

# Add CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Replace "*" with specific origins if needed
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(items.router)
app.include_router(orders.router)

@app.get("/")
def read_root():
    return {"message": "Welcome to the Battleship WMS!"}