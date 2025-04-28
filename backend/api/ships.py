from fastapi import APIRouter, Depends, HTTPException
from psycopg2 import sql
from ..db import get_db

router = APIRouter(prefix="/ships", tags=["ships"])

@router.get("/", response_model=dict)
@router.get("", response_model=dict)
async def get_ships(limit: int = 100, offset: int = 0, db=Depends(get_db)):
    try:
        with db.cursor() as cur:
            cur.execute("CALL get_ships(NULL, %s, %s)", (limit, offset))
            result = cur.fetchone()
            ships_json = result[0] if result else {"ships": []}
            return ships_json
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Database error: {str(e)}")
    finally:
        db.commit()