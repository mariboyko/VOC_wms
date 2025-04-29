import React, { useState, useEffect } from 'react';
import { BrowserRouter as Router, Route, Routes, Link } from 'react-router-dom';
import GoodsList from './components/GoodsList';
import ShipsList from './components/ShipsList';
import AddPersonnel from './components/AddPersonnel';
import './App.css';

function App() {
  const [goods, setGoods] = useState([]);
  const [ships, setShips] = useState([]);

  useEffect(() => {
    fetch('http://127.0.0.1:8000/goods')
      .then(response => {
        if (!response.ok) {
          throw new Error(`HTTP error! status: ${response.status}`);
        }
        return response.json();
      })
      .then(data => {
        if (data.goods) {
          setGoods(data.goods);
        } else {
          console.warn('No goods found in response:', data);
          setGoods([]);
        }
      })
      .catch(error => {
        console.error('Error fetching goods:', error);
        setGoods([]);
      });

    fetch('http://127.0.0.1:8000/ships')
      .then(response => {
        if (!response.ok) {
          throw new Error(`HTTP error! status: ${response.status}`);
        }
        return response.json();
      })
      .then(data => {
        if (data.ships) {
          setShips(data.ships);
        } else {
          console.warn('No ships found in response:', data);
          setShips([]);
        }
      })
      .catch(error => {
        console.error('Error fetching ships:', error);
        setShips([]);
      });
  }, []);

  return (
    <Router>
      <div>
        <nav>
          <ul>
            <li><Link to="/">Home</Link></li>
            <li><Link to="/add-personnel">Add Personnel</Link></li>
          </ul>
        </nav>
        <h1>Battleship WMS</h1>
        <Routes>
          <Route
            path="/"
            element={
              <>
                <GoodsList goods={goods} />
                <ShipsList ships={ships} />
              </>
            }
          />
          <Route path="/add-personnel" element={<AddPersonnel />} />
        </Routes>
      </div>
    </Router>
  );
}

export default App;