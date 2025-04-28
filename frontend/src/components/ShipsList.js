import React from 'react';

function ShipsList({ ships }) {
  return (
    <div>
      <h2>Ships</h2>
      {ships.length > 0 ? (
        <table>
          <thead>
            <tr>
              <th>ID</th>
              <th>Name</th>
              <th>Capacity (Tons)</th>
              <th>Status</th>
              <th>Home Port ID</th>
              <th>Owner ID</th>
              <th>Build Year</th>
              <th>Last Maintenance</th>
              <th>Last Trade</th>
            </tr>
          </thead>
          <tbody>
            {ships.map(ship => (
              <tr key={ship.ship_id}>
                <td>{ship.ship_id}</td>
                <td>{ship.ship_name}</td>
                <td>{ship.capacity_tons}</td>
                <td>{ship.status}</td>
                <td>{ship.home_port_id}</td>
                <td>{ship.owner_id}</td>
                <td>{ship.build_year}</td>
                <td>{ship.last_maintenance}</td>
                <td>{ship.last_trade}</td>
              </tr>
            ))}
          </tbody>
        </table>
      ) : (
        <p>No ships found.</p>
      )}
    </div>
  );
}

export default ShipsList;