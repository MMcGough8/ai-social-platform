import React from 'react';
import { UserProvider } from './context/UserContext';
import Layout from './components/layout/Layout';
import './styles/App.css';

function App() {
  return (
    <UserProvider>
      <div className="App">
        <Layout />
      </div>
    </UserProvider>
  );
}

export default App;

