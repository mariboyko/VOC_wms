import React, { useState, useEffect } from 'react';
import GoodsList from './components/GoodsList';
import './App.css';

function App() {
  const [goods, setGoods] = useState([]);

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
        console.error('Error fetching data:', error);
        setGoods([]);
      });
  }, []);

  return (
    <div>
      <h1>Battleship WMS</h1>
      <GoodsList goods={goods} />
    </div>
  );
}

export default App;