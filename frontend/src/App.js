import React, { useState, useEffect } from 'react';
import GoodsList from './components/GoodsList';
import ShipsList from './components/ShipsList';
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
    <div>
      <h1>Battleship WMS</h1>
      <GoodsList goods={goods} />
      <ShipsList ships={ships} />
    </div>
  );
}

export default App;