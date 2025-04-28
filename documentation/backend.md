launch from the root folder

uvicorn backend.main:app --reload

lsof -i :8000
kill -9 <PID>

export PGPASSWORD='sails123' && psql -U wms_admin -h localhost -p 5433 -d wms_db

cd VOC_wms/backend
python -c "from dotenv import load_dotenv; import os; load_dotenv(); print(f'postgresql://{os.getenv('POSTGRES_USER')}:{os.getenv('POSTGRES_PASSWORD')}@{os.getenv('POSTGRES_HOST', 'localhost')}:{os.getenv('POSTGRES_PORT', '5432')}/{os.getenv('POSTGRES_DB')}')"


pkill uvicorn
uvicorn backend.main:app --reload
