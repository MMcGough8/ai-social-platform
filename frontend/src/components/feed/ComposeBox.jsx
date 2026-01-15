

import React, { useState } from 'react';
import { useUser } from '../../context/UserContext';
import postService from '../../services/postService';

function ComposeBox({ onPostCreated }) {
  const { currentUser } = useUser();
  const [postText, setPostText] = useState('');
  const [isPosting, setIsPosting] = useState(false);
  const maxChars = 280;

  const getCharCountClass = () => {
    const remaining = maxChars - postText.length;
    if (remaining < 20) return 'text-red-500';
    if (remaining < 50) return 'text-yellow-400';
    return 'text-white/50';
  };

  const handlePost = async () => {
    if (postText.trim().length === 0 || !currentUser) return;
    
    try {
      setIsPosting(true);
      await postService.createPost(currentUser.id, postText);
      setPostText('');
      if (onPostCreated) {
        onPostCreated();
      }
    } catch (error) {
      console.error('Error creating post:', error);
      alert('Failed to create post. Please try again.');
    } finally {
      setIsPosting(false);
    }
  };

  if (!currentUser) {
    return null;
  }

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

        <textarea
          className="bg-transparent border-none text-white text-lg w-full min-h-[80px] 
                     resize-none outline-none font-['Plus_Jakarta_Sans'] placeholder:text-white/30"
          placeholder="What's on your mind?"
          value={postText}
          onChange={(e) => setPostText(e.target.value)}
          maxLength={maxChars}
          disabled={isPosting}
        />

        <div className="flex justify-between items-center mt-4 pt-4 border-t border-white/10">
          <div className="flex gap-1 flex-wrap">
            <button className="w-[38px] h-[38px] rounded-xl flex items-center justify-center 
                               cursor-pointer transition-all duration-300 text-xl relative
                               bg-transparent border-none hover:bg-veritas-pink/15 hover:scale-110"
                    title="Add image">
              🖼️
            </button>
            <button className="w-[38px] h-[38px] rounded-xl flex items-center justify-center 
                               cursor-pointer transition-all duration-300 text-xl relative
                               bg-transparent border-none hover:bg-veritas-pink/15 hover:scale-110"
                    title="Add video">
              🎬
            </button>
            <button className="w-[38px] h-[38px] rounded-xl flex items-center justify-center 
                               cursor-pointer transition-all duration-300 text-xl relative
                               bg-transparent border-none hover:bg-veritas-pink/15 hover:scale-110"
                    title="Create poll">
              📊
            </button>
            <button className="w-[38px] h-[38px] rounded-xl flex items-center justify-center 
                               cursor-pointer transition-all duration-300 text-xl relative
                               bg-transparent border-none hover:bg-veritas-pink/15 hover:scale-110"
                    title="Add emoji">
              😊
            </button>
            <button className="w-[38px] h-[38px] rounded-xl flex items-center justify-center 
                               cursor-pointer transition-all duration-300 text-xl relative
                               bg-transparent border-none hover:bg-veritas-pink/15 hover:scale-110"
                    title="Add hashtag">
              #
            </button>
            <button className="w-[38px] h-[38px] rounded-xl flex items-center justify-center 
                               cursor-pointer transition-all duration-300 text-xl relative
                               bg-transparent border-none hover:bg-veritas-pink/15 hover:scale-110"
                    title="Schedule post">
              ⏰
            </button>
          </div>
          <div className="flex items-center gap-3">
            <span className={`text-sm font-semibold flex items-center gap-1 ${getCharCountClass()}`}>
              {postText.length}/{maxChars}
            </span>
            <button 
              className="bg-gradient-to-br from-veritas-pink to-veritas-pink-dark 
                         px-7 py-2.5 rounded-xl font-bold cursor-pointer 
                         shadow-[0_4px_16px_rgba(255,107,157,0.3)] text-[15px] 
                         border-none text-white transition-all duration-300
                         hover:-translate-y-0.5 hover:shadow-[0_6px_20px_rgba(255,107,157,0.4)]
                         disabled:opacity-50 disabled:cursor-not-allowed"
              onClick={handlePost}
              disabled={postText.trim().length === 0 || isPosting}
            >
              {isPosting ? 'Posting...' : 'Share'}
            </button>
          </div>
        </div>
      </div>
    </div>
  );
}

export default ComposeBox;