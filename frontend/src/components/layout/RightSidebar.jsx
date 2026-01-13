

import React from 'react';


function RightSidebar() {
  return (
    <div className="py-[30px]">
      {/* Search Box */}
      <div className="bg-white/8 backdrop-blur-[10px] border border-white/10 rounded-2xl 
                      px-[18px] py-3.5 flex items-center gap-3 mb-5 sticky top-[30px] 
                      transition-all duration-300
                      focus-within:bg-white/12 focus-within:border-veritas-pink 
                      focus-within:shadow-[0_0_20px_rgba(255,107,157,0.2)]">
        <div className="text-white/50 text-xl">🔍</div>
        <input 
          type="text" 
          placeholder="Search posts, people, hashtags..." 
          className="bg-transparent border-none outline-none text-white w-full 
                     font-['Plus_Jakarta_Sans'] text-[15px] placeholder:text-white/40"
        />
      </div>
      
      {/* AI Tools Widget */}
      <div className="bg-white/5 backdrop-blur-[10px] border border-white/10 rounded-[20px] 
                      overflow-hidden mb-5 transition-all duration-300
                      hover:border-veritas-pink/30 hover:shadow-[0_8px_32px_rgba(255,107,157,0.1)]">
        <div className="px-5 py-5 border-b border-white/10 font-extrabold text-xl flex items-center gap-2.5">
          <span>🤖</span>
          <span>AI Tools</span>
        </div>
        <div className="px-5 py-5">
          <p className="text-white/70 text-sm">
            AI widgets coming soon...
          </p>
        </div>
      </div>

      {/* Filters & Sort Widget */}
      <div className="bg-white/5 backdrop-blur-[10px] border border-white/10 rounded-[20px] 
                      overflow-hidden mb-5 transition-all duration-300
                      hover:border-veritas-pink/30 hover:shadow-[0_8px_32px_rgba(255,107,157,0.1)]">
        <div className="px-5 py-5 border-b border-white/10 font-extrabold text-xl flex items-center gap-2.5">
          <span>🎯</span>
          <span>Filters & Sort</span>
        </div>
        <div className="px-5 py-5">
          <p className="text-white/70 text-sm">
            Filter options coming soon...
          </p>
        </div>
      </div>
    </div>
  );
}

export default RightSidebar;
