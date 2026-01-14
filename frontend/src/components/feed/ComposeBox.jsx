

import React, { useState } from 'react';
import HelpBadge from '../common/HelpBadge';

function ComposeBox() {
  const [postText, setPostText] = useState('');
  const maxChars = 280;

  const getCharCountClass = () => {
    const remaining = maxChars - postText.length;
    if (remaining < 20) return 'text-red-500';
    if (remaining < 50) return 'text-yellow-400';
    return 'text-white/50';
  };

  const handlePost = () => {
    if (postText.trim().length === 0) return;
    console.log('Posting:', postText);
    setPostText('');
  };

  return (
    <div className="p-5 flex gap-3.5 border-b border-white/10 relative">
      <div className="w-11 h-11 rounded-[14px] bg-gradient-to-br from-veritas-blue to-veritas-blue-dark 
                      flex items-center justify-center text-xl 
                      shadow-[0_4px_12px_rgba(102,126,234,0.3)] flex-shrink-0">
        🎨
      </div>
      <div className="flex-1">
        <div className="bg-veritas-pink/10 border-l-4 border-veritas-pink px-3 py-2 mb-4
                        text-xs font-bold text-veritas-coral uppercase tracking-wider">
          🎯 CREATE A POST (Feature #3)
        </div>

        {/* AI Tools Panel */}
        <div className="mb-4 p-4 bg-gradient-to-br from-veritas-purple/10 to-veritas-pink/10 
                        border-2 border-veritas-pink/30 rounded-2xl">
          <div className="flex items-center gap-2.5 mb-3">
            <span className="text-xl">✨</span>
            <span className="font-bold text-veritas-coral text-sm">AI WRITING TOOLS</span>
          </div>
          <div className="flex flex-wrap gap-2">
            <button className="px-3.5 py-2 rounded-[10px] font-semibold cursor-pointer text-[13px] 
                               flex items-center gap-1.5 border-2 transition-all duration-300
                               bg-veritas-purple/30 border-veritas-purple/50 text-veritas-purple-light
                               hover:-translate-y-0.5">
              <span>🤖</span>
              <span>Post Assistant</span>
            </button>
            <button className="px-3.5 py-2 rounded-[10px] font-semibold cursor-pointer text-[13px] 
                               flex items-center gap-1.5 border-2 transition-all duration-300
                               bg-blue-600/30 border-blue-600/50 text-blue-300
                               hover:-translate-y-0.5">
              <span>✅</span>
              <span>Fact Check</span>
              <label className="flex items-center gap-1 ml-1 text-[11px]">
                <input type="checkbox" className="cursor-pointer" />
                <span>Auto</span>
              </label>
            </button>
            <button className="px-3.5 py-2 rounded-[10px] font-semibold cursor-pointer text-[13px] 
                               flex items-center gap-1.5 border-2 transition-all duration-300
                               bg-green-600/30 border-green-600/50 text-green-300
                               hover:-translate-y-0.5">
              <span>🔍</span>
              <span>Fact Crawler</span>
            </button>
          </div>
        </div>

        {/* Text Input */}
        <textarea
          className="bg-transparent border-none text-white text-lg w-full min-h-[80px] 
                     resize-none outline-none font-['Plus_Jakarta_Sans'] placeholder:text-white/30"
          placeholder="What's on your mind?"
          value={postText}
          onChange={(e) => setPostText(e.target.value)}
          maxLength={maxChars}
        />

        {/* Actions */}
        <div className="flex justify-between items-center mt-4 pt-4 border-t border-white/10">
          <div className="flex gap-1 flex-wrap">
            <button className="w-[38px] h-[38px] rounded-xl flex items-center justify-center 
                               cursor-pointer transition-all duration-300 text-xl relative
                               bg-transparent border-none hover:bg-veritas-pink/15 hover:scale-110"
                    title="Add image">
              🖼️
              <HelpBadge number="18" tooltip="Feature #18: Add Multimedia" />
            </button>
            <button className="w-[38px] h-[38px] rounded-xl flex items-center justify-center 
                               cursor-pointer transition-all duration-300 text-xl relative
                               bg-transparent border-none hover:bg-veritas-pink/15 hover:scale-110"
                    title="Add video">
              🎬
              <HelpBadge number="18" tooltip="Feature #18: Add Video" />
            </button>
            <button className="w-[38px] h-[38px] rounded-xl flex items-center justify-center 
                               cursor-pointer transition-all duration-300 text-xl relative
                               bg-transparent border-none hover:bg-veritas-pink/15 hover:scale-110"
                    title="Create poll">
              📊
              <HelpBadge number="5" tooltip="Feature #5: Create Poll" />
            </button>
            <button className="w-[38px] h-[38px] rounded-xl flex items-center justify-center 
                               cursor-pointer transition-all duration-300 text-xl relative
                               bg-transparent border-none hover:bg-veritas-pink/15 hover:scale-110"
                    title="Add emoji">
              😊
              <HelpBadge number="7" tooltip="Feature #7: Emoji Support" />
            </button>
            <button className="w-[38px] h-[38px] rounded-xl flex items-center justify-center 
                               cursor-pointer transition-all duration-300 text-xl relative
                               bg-transparent border-none hover:bg-veritas-pink/15 hover:scale-110"
                    title="Add hashtag">
              #
              <HelpBadge number="6" tooltip="Feature #6: Add Hashtag" />
            </button>
            <button className="w-[38px] h-[38px] rounded-xl flex items-center justify-center 
                               cursor-pointer transition-all duration-300 text-xl relative
                               bg-transparent border-none hover:bg-veritas-pink/15 hover:scale-110"
                    title="Schedule post">
              ⏰
              <HelpBadge number="9" tooltip="Feature #9: Timed Messages" />
            </button>
          </div>
          <div className="flex items-center gap-3">
            <span className={`text-sm font-semibold flex items-center gap-1 ${getCharCountClass()}`}>
              {postText.length}/{maxChars}
              <HelpBadge number="4" tooltip="Feature #4: Character Limit" bgColor="rgba(255,255,255,0.2)" />
            </span>
            <button 
              className="bg-gradient-to-br from-veritas-pink to-veritas-pink-dark 
                         px-7 py-2.5 rounded-xl font-bold cursor-pointer 
                         shadow-[0_4px_16px_rgba(255,107,157,0.3)] text-[15px] 
                         border-none text-white transition-all duration-300
                         hover:-translate-y-0.5 hover:shadow-[0_6px_20px_rgba(255,107,157,0.4)]
                         disabled:opacity-50 disabled:cursor-not-allowed"
              onClick={handlePost}
              disabled={postText.trim().length === 0}
            >
              Share
            </button>
          </div>
        </div>
      </div>
    </div>
  );
}

export default ComposeBox;