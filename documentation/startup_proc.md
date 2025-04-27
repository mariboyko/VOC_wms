
### **Startup Steps**

#### 1. **Set Up the Virtual Environment**
   - Create and activate the virtual environment:
     ```bash
     python3 -m venv venv
     source venv/bin/activate  # On Windows: venv\Scripts\activate
     ```
   - Install the required Python dependencies:
     ```bash
     pip install fastapi psycopg2 uvicorn
     ```

#### 2. **Start the Database**
   - Ensure Docker is installed and running.
   - Start the PostgreSQL database using Docker Compose:
     ```bash
     docker-compose up -d
     ```
   - Verify the database is running:
     ```bash
     docker ps
     ```
   - (Optional) Access the database:
     ```bash
     docker exec -it wms_postgres psql -U wms_admin -d wms_db
     ```

     The error indicates that port `5432` (used by PostgreSQL) is already in use on your system. To resolve this, you can either stop the process currently using the port or configure Docker Compose to use a different port.

### **Option 1: Stop the Process Using Port 5432**
1. Find the process using port `5432`:
   ```bash
   lsof -i :5432
   ```
2. Kill the process (replace `<PID>` with the process ID from the previous command):
   ```bash
   kill -9 <PID>
   ```
3. Retry starting the database:
   ```bash
   docker-compose up -d
   ```

---

### **Option 2: Change the Port in docker-compose.yml**
1. Open the docker-compose.yml file in your project directory.
2. Locate the PostgreSQL service configuration and update the port mapping. For example:
   ```yaml
   ports:
     - "5433:5432"  # Change the host port to 5433
   ```
3. Save the file and restart Docker Compose:
   ```bash
   docker-compose up -d
   ```
4. Update your backend configuration (e.g., .env file) to use the new port (`5433`).

---

Let me know if you need help with either approach!

#### 3. **Run the Backend**
   - Navigate to the backend directory:
     ```bash
     cd backend
     ```
   - Start the FastAPI server:
     ```bash
     uvicorn main:app --reload
     ```
   - Verify the backend is running by visiting [http://127.0.0.1:8000](http://127.0.0.1:8000).

#### 4. **Run the Frontend**
   - Navigate to the frontend directory:
     ```bash
     cd frontend
     ```
   - Install the required Node.js dependencies:
     ```bash
     npm install
     ```
   - Start the React development server:
     ```bash
     npm start
     ```
   - Open [http://localhost:3000](http://localhost:3000) to view the frontend.

---

### **Summary**
1. **Virtual Environment**: Set up and activate the Python virtual environment.
2. **Database**: Start the PostgreSQL database using Docker Compose.
3. **Backend**: Run the FastAPI server.
4. **Frontend**: Start the React development server.

This order ensures the backend and database are ready before the frontend attempts to fetch data.