

import React from 'react';
import Sidebar from './Sidebar';
import MainFeed from '../feed/MainFeed';
import RightSidebar from './RightSidebar';

function Layout() {
  return (
    <div className="max-w-[1400px] mx-auto grid grid-cols-[280px_1fr_380px] gap-5 px-5 
                    lg:grid-cols-[280px_1fr_380px] 
                    md:grid-cols-[80px_1fr_300px] 
                    sm:grid-cols-1">
      <Sidebar />
      <MainFeed />
      <RightSidebar />
    </div>
  );
}

export default Layout;