import React from 'react';
import { Search, CheckCircle, Loader2 } from 'lucide-react';

// #151 - FactCheckButton on PostCard
// #156 - Add fact-check button loading state
function FactCheckButton({ onClick, isLoading, isChecked }) {
  return (
    <button
      onClick={onClick}
      disabled={isLoading}
      className={`
        flex items-center justify-center cursor-pointer transition-all duration-300
        p-1.5 rounded-[10px] bg-transparent border-none
        text-white/50 w-8
        hover:text-[#c9a35e] hover:bg-[#c9a35e]/10
        disabled:opacity-50 disabled:cursor-not-allowed
      `}
      title={isChecked ? 'View fact-check results' : 'Fact-check this post'}
    >
      {isLoading ? (
        <Loader2 className="w-5 h-5 animate-spin" />
      ) : isChecked ? (
        <Search className="w-5 h-5" />
      ) : (
        <CheckCircle className="w-5 h-5" />
      )}
    </button>
  );
}

export default FactCheckButton;
