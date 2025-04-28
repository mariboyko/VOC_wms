import React from 'react';

function GoodsList({ goods }) {
  return (
    <div>
      <h2>Goods</h2>
      {goods.length === 0 ? (
        <p>No goods available.</p>
      ) : (
        <table>
          <thead>
            <tr>
              <th>Name</th>
              <th>Category</th>
              <th>Origin Country</th>
              <th>Unit Measure</th>
              <th>Price per Unit</th>
              <th>Spoilage Risk</th>
            </tr>
          </thead>
          <tbody>
            {goods.map(good => (
              <tr key={good.good_id}>
                <td>{good.name}</td>
                <td>{good.category || 'N/A'}</td>
                <td>{good.origin_country || 'N/A'}</td>
                <td>{good.unit_measure}</td>
                <td>{good.price_per_unit.toFixed(2)}</td>
                <td>{(good.spoilage_risk * 100).toFixed(2)}%</td>
              </tr>
            ))}
          </tbody>
        </table>
      )}
    </div>
  );
}

export default GoodsList;