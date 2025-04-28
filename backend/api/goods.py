from fastapi import APIRouter, Depends, HTTPException
from psycopg2 import sql
from ..db import get_db

router = APIRouter(prefix="/goods", tags=["goods"])

@router.get("/", response_model=dict)
@router.get("", response_model=dict)  # Handle /goods without trailing slash
async def get_goods(limit: int = 100, offset: int = 0, db=Depends(get_db)):
    try:
        with db.cursor() as cur:
            # Call the stored procedure with p_result first
            cur.execute("CALL get_goods(NULL, %s, %s)", (limit, offset))
            result = cur.fetchone()
            goods_json = result[0] if result else {"goods": []}
            return goods_json
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Database error: {str(e)}")
    finally:
        db.commit()