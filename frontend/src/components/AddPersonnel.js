import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import './AddPersonnel.css';

function AddPersonnel() {
  const [formData, setFormData] = useState({
    name: '',
    role: 'Captain',
    status: 'Active',
    rank: 'Junior',
    ship_id: '',
    port_id: '',
  });
  const [message, setMessage] = useState('');
  const navigate = useNavigate();

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData({ ...formData, [name]: value });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      const response = await fetch('http://127.0.0.1:8000/personnel', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          ...formData,
          ship_id: formData.ship_id ? parseInt(formData.ship_id) : null,
          port_id: formData.port_id ? parseInt(formData.port_id) : null,
        }),
      });
      const data = await response.json();
      if (data.status === 'success') {
        setMessage('Personnel added successfully!');
        setTimeout(() => navigate('/'), 2000);
      } else {
        setMessage(data.message);
      }
    } catch (error) {
      setMessage('Error adding personnel: ' + error.message);
    }
  };

  return (
    <div>
      <h2>Add Personnel</h2>
      <form onSubmit={handleSubmit}>
        <div>
          <label>Name:</label>
          <input
            type="text"
            name="name"
            value={formData.name}
            onChange={handleChange}
            required
          />
        </div>
        <div>
          <label>Role:</label>
          <select name="role" value={formData.role} onChange={handleChange}>
            <option value="Captain">Captain</option>
            <option value="Merchant">Merchant</option>
            <option value="Warehouse Clerk">Warehouse Clerk</option>
            <option value="Navigator">Navigator</option>
            <option value="Dock Supervisor">Dock Supervisor</option>
            <option value="Sailor">Sailor</option>
          </select>
        </div>
        <div>
          <label>Status:</label>
          <select name="status" value={formData.status} onChange={handleChange}>
            <option value="Active">Active</option>
            <option value="Inactive">Inactive</option>
            <option value="On Leave">On Leave</option>
          </select>
        </div>
        <div>
          <label>Rank:</label>
          <select name="rank" value={formData.rank} onChange={handleChange}>
            <option value="Junior">Junior</option>
            <option value="Mid-level">Mid-level</option>
            <option value="Senior">Senior</option>
          </select>
        </div>
        <div>
          <label>Ship ID (optional):</label>
          <input
            type="number"
            name="ship_id"
            value={formData.ship_id}
            onChange={handleChange}
          />
        </div>
        <div>
          <label>Port ID (optional):</label>
          <input
            type="number"
            name="port_id"
            value={formData.port_id}
            onChange={handleChange}
          />
        </div>
        <button type="submit">Add Personnel</button>
      </form>
      {message && <p>{message}</p>}
    </div>
  );
}

export default AddPersonnel;