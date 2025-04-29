from fastapi import APIRouter, Depends, HTTPException
from pydantic import BaseModel
from psycopg2 import sql
from ..db import get_db

router = APIRouter(prefix="/personnel", tags=["personnel"])

class PersonnelCreate(BaseModel):
    name: str
    role: str  # personnel_role ENUM
    status: str  # personnel_status ENUM
    rank: str  # personnel_rank ENUM
    ship_id: int | None = None
    port_id: int | None = None

@router.post("/", response_model=dict)
async def create_personnel(personnel: PersonnelCreate, db=Depends(get_db)):
    try:
        with db.cursor() as cur:
            cur.execute(
                "CALL add_personnel(%s, %s::personnel_role, %s::personnel_status, %s::personnel_rank, %s, %s, NULL)",
                (
                    personnel.name,
                    personnel.role,
                    personnel.status,
                    personnel.rank,
                    personnel.ship_id,
                    personnel.port_id,
                ),
            )
            result = cur.fetchone()
            db.commit()
            if result is None or result[0]["status"] != "success":
                raise HTTPException(status_code=400, detail=result[0]["message"])
            return result[0]
    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=500, detail=f"Database error: {str(e)}")