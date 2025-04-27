from fastapi import APIRouter
from ..db import get_db

router = APIRouter()

@router.get("/orders")
def get_orders():
    conn = get_db()
    cur = conn.cursor()
    cur.execute("SELECT * FROM orders;")
    orders = cur.fetchall()
    return {"orders": orders}