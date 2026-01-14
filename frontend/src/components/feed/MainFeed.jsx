
import React, { useState } from 'react';
import ComposeBox from './ComposeBox';
import Tweet from './Tweet';

function MainFeed() {
  const [activeTab, setActiveTab] = useState('forYou');

  const tweets = [
    {
      id: 1,
      author: 'Emily Parker',
      handle: '@emilyparker',
      avatar: '👩‍💻',
      time: '1h',
      verified: true,
      trustScore: 87,
      content: 'Which programming language should I learn next? #WebDev #Coding',
      type: 'poll',
      poll: {
        options: [
          { text: 'Solidity', percentage: 45, votes: 562 },
          { text: 'Rust', percentage: 30, votes: 375 },
          { text: 'Go', percentage: 15, votes: 187 },
          { text: 'Python', percentage: 10, votes: 125 }
        ],
        totalVotes: 1247,
        timeLeft: '2 days left'
      },
      likes: 567,
      retweets: 234,
      replies: 89
    },
    {
      id: 2,
      author: 'Marcus Rivera',
      handle: '@marcusrivera',
      avatar: '🧑‍⚖️',
      time: '3h',
      verified: false,
      trustScore: 94,
      content: 'Remote work is more productive than office work. Change my mind.',
      type: 'debate',
      debate: {
        agree: 724,
        disagree: 456
      },
      likes: 156,
      retweets: 567,
      replies: 312
    },
    {
      id: 3,
      author: 'NewsDaily',
      handle: '@newsdaily',
      avatar: '📰',
      time: '2h',
      verified: true,
      trustScore: 98,
      content: 'Breaking: Scientists discover new renewable energy source that could power entire cities. Study published in Nature Journal. #Science #Energy',
      type: 'fact-checked',
      factCheck: {
        status: 'verified',
        sources: ['Nature Journal', 'MIT Research Team'],
        date: 'Jan 2026'
      },
      likes: 1500,
      retweets: 1200,
      replies: 234
    }
  ];

  return (
    <div className="bg-white/[0.03] rounded-3xl overflow-hidden backdrop-blur-[10px] border border-white/10">
      {/* Feed Header with Tabs */}
      <div className="flex sticky top-0 bg-[rgba(15,5,25,0.95)] backdrop-blur-[20px] z-10 
                      p-2 border-b border-white/10">
        <div 
          className={`flex-1 p-3.5 text-center font-bold cursor-pointer relative 
                     text-[15px] rounded-xl transition-all duration-300
                     ${activeTab === 'forYou' 
                       ? 'text-white bg-gradient-to-br from-veritas-pink/20 to-veritas-purple/20' 
                       : 'text-white/50 hover:text-white/80 hover:bg-white/5'}`}
          onClick={() => setActiveTab('forYou')}
        >
          For You
        </div>
        <div 
          className={`flex-1 p-3.5 text-center font-bold cursor-pointer relative 
                     text-[15px] rounded-xl transition-all duration-300
                     ${activeTab === 'following' 
                       ? 'text-white bg-gradient-to-br from-veritas-pink/20 to-veritas-purple/20' 
                       : 'text-white/50 hover:text-white/80 hover:bg-white/5'}`}
          onClick={() => setActiveTab('following')}
        >
          Following
        </div>
        <div 
          className={`flex-1 p-3.5 text-center font-bold cursor-pointer relative 
                     text-[15px] rounded-xl transition-all duration-300
                     ${activeTab === 'trending' 
                       ? 'text-white bg-gradient-to-br from-veritas-pink/20 to-veritas-purple/20' 
                       : 'text-white/50 hover:text-white/80 hover:bg-white/5'}`}
          onClick={() => setActiveTab('trending')}
        >
          Trending
        </div>
      </div>

      {/* Compose Box */}
      <ComposeBox />

      {/* Info Banner */}
      <div className="p-4 bg-veritas-pink/5 border-b border-white/10">
        <div className="text-[13px] font-bold text-veritas-coral mb-2">
          📚 EXPLORE FEATURES BELOW:
        </div>
        <div className="text-xs text-white/70 leading-relaxed">
          Scroll down to see examples of <strong className="text-white font-semibold">Polls</strong> (Feature #5), <strong className="text-white font-semibold">Debates</strong> (Feature #11), 
          <strong className="text-white font-semibold">Reactions</strong> (Feature #10), <strong className="text-white font-semibold">Edit</strong> (Feature #8), and more!
        </div>
      </div>

      {/* Tweet List */}
      <div>
        {tweets.map(tweet => (
          <Tweet key={tweet.id} {...tweet} />
        ))}
      </div>
    </div>
  );
}

export default MainFeed;
