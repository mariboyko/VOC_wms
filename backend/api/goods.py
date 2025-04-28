from fastapi import APIRouter, Depends, HTTPException
from psycopg2 import sql
from ..db import get_db

router = APIRouter(prefix="/goods", tags=["goods"])

@router.get("/")
async def get_goods(limit: int = 100, offset: int = 0, db=Depends(get_db)):
    try:
        with db.cursor() as cur:
            # Call the stored procedure and fetch JSON result
            cur.execute("CALL get_goods(%s, %s, NULL)", (limit, offset))
            result = cur.fetchone()
            goods_json = result[0] if result else {"goods": []}
            return goods_json
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Database error: {str(e)}")
    finally:
        db.commit()