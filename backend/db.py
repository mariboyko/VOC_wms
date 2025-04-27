import psycopg2
from fastapi import Depends
from psycopg2 import sql

DATABASE_URL = "postgresql://user:password@localhost/dbname"

def get_db():
    conn = psycopg2.connect(DATABASE_URL)
    return conn