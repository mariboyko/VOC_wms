import psycopg2
from fastapi import Depends
from psycopg2 import sql
from dotenv import load_dotenv
import os

# Load .env file
load_dotenv()

# Build DATABASE_URL from environment variables
DATABASE_URL = (
    f"postgresql://{os.getenv('POSTGRES_USER')}:{os.getenv('POSTGRES_PASSWORD')}"
    f"@{os.getenv('POSTGRES_HOST', 'localhost')}:{os.getenv('POSTGRES_PORT', '5432')}"
    f"/{os.getenv('POSTGRES_DB')}"
)

def get_db():
    conn = psycopg2.connect(DATABASE_URL)
    return conn