import React from 'react';

function ItemList({ items }) {
  return (
    <div>
      <h2>Items in Inventory</h2>
      <ul>
        {items.map(item => (
          <li key={item.item_id}>{item.name}</li>
        ))}
      </ul>
    </div>
  );
}

export default ItemList;