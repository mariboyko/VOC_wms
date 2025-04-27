launch from the root folder

uvicorn backend.main:app --reload

lsof -i :8000
kill -9 <PID>
