from fastapi import APIRouter
from ..db import get_db

router = APIRouter()

@router.get("/items")
def get_items():
    conn = get_db()
    cur = conn.cursor()
    cur.execute("SELECT * FROM items;")
    items = cur.fetchall()
    return {"items": items}