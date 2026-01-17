import React, { useState, useEffect } from 'react';
import { useUser } from '../../context/UserContext';
import postService from '../../services/postService';
import Tweet from './Tweet';
import debateService from '../../services/debateService';
import DebateCard from '../debates/DebateCard';

function MainFeed({ refreshTrigger }) {
  const { currentUser } = useUser();
  const [activeTab, setActiveTab] = useState('following');
  const [posts, setPosts] = useState([]);
  const [debates, setDebates] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [searchQuery, setSearchQuery] = useState('');

  useEffect(() => {
    if (currentUser) {
      loadPosts();
    }
  }, [currentUser, activeTab, refreshTrigger]);

  const loadPosts = async () => {
  try {
    setLoading(true);
    setError(null);
    
    let feed;
    if (activeTab === 'following') {
      feed = await postService.getFeed(currentUser.id);
      const sortedFeed = feed.sort((a, b) => 
        new Date(b.createdAt) - new Date(a.createdAt)
      );
      setPosts(sortedFeed);
    } else if (activeTab === 'yourPosts') {
      feed = await postService.searchPosts({
        authorId: currentUser.id,
        page: 0,
        size: 50
      });
      feed = feed.content || [];
      const sortedFeed = feed.sort((a, b) => 
        new Date(b.createdAt) - new Date(a.createdAt)
      );
      setPosts(sortedFeed);
    } else if (activeTab === 'debates') {
      const activeDebates = await debateService.getActiveDebates();
      const allDebates = [...activeDebates];
      const sortedDebates = allDebates.sort((a, b) => 
        new Date(b.createdAt) - new Date(a.createdAt)
      );
      setDebates(sortedDebates);
    }
  } catch (err) {
    console.error('Error loading posts:', err);
    setError('Failed to load content');
  } finally {
    setLoading(false);
  }
};

  // Update local post state without reloading from server
  const handlePostUpdated = (updatedPost) => {
    if (updatedPost) {
      setPosts(prevPosts => 
        prevPosts.map(post => 
          post.id === updatedPost.id ? updatedPost : post
        )
      );
    }
  };

  // Update author follow state across all posts by that author
  const handleAuthorFollowChange = (authorId, isNowFollowing) => {
    setPosts(prevPosts =>
      prevPosts.map(post => {
        if (post.author.id === authorId) {
          return {
            ...post,
            author: {
              ...post.author,
              isFollowing: isNowFollowing
            }
          };
        }
        return post;
      })
    );
  };

  const handlePostDeleted = (postId) => {
    setPosts(prevPosts =>
      prevPosts.filter(post => post.id !== postId)
    );
  };

  if (!currentUser) {
    return (
      <div className="bg-gradient-to-br from-veritas-purple/20 to-veritas-pink/20
                      rounded-2xl overflow-hidden backdrop-blur-[10px] border-2 border-veritas-pink/30
                      flex items-center justify-center p-20">
        <div className="text-white/50">Loading user...</div>
      </div>
    );
  }

  return (
    <div className="bg-gradient-to-br from-veritas-purple/20 to-veritas-pink/20
                    rounded-2xl overflow-hidden backdrop-blur-[10px] border-2 border-veritas-pink/30">
      {/* Tabs */}
      <div className="flex sticky top-0 bg-[rgba(15,5,25,0.95)] backdrop-blur-[20px] z-10
                      p-2 border-b border-veritas-pink/20">
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
                     ${activeTab === 'yourPosts' 
                       ? 'text-white bg-gradient-to-br from-veritas-pink/20 to-veritas-purple/20' 
                       : 'text-white/50 hover:text-white/80 hover:bg-white/5'}`}
          onClick={() => setActiveTab('yourPosts')}
        >
          Your Posts
        </div>
        <div
          className={`flex-1 p-3.5 text-center font-bold cursor-pointer relative
                     text-[15px] rounded-xl transition-all duration-300
                     ${activeTab === 'debates'
                       ? 'text-white bg-gradient-to-br from-veritas-pink/20 to-veritas-purple/20'
                       : 'text-white/50 hover:text-white/80 hover:bg-white/5'}`}
          onClick={() => setActiveTab('debates')}
        >
          ⚔️ Debates
        </div>
      </div>

      {/* Search Bar */}
      <div className="px-4 py-3 border-b border-veritas-pink/20">
        <div className="bg-white/8 backdrop-blur-[10px] border border-veritas-pink/20 rounded-2xl
                        px-[18px] py-3.5 flex items-center gap-3
                        transition-all duration-300
                        focus-within:bg-white/12 focus-within:border-veritas-pink
                        focus-within:shadow-[0_0_20px_rgba(255,107,157,0.2)]">
          <div className="text-white/50 text-xl">🔍</div>
          <input
            type="text"
            placeholder="Search posts, people, hashtags..."
            value={searchQuery}
            onChange={(e) => setSearchQuery(e.target.value)}
            className="bg-transparent border-none outline-none text-white w-full
                       font-['Plus_Jakarta_Sans'] text-[15px] placeholder:text-white/40"
          />
        </div>
      </div>

      {loading && (
        <div className="p-20 text-center text-white/50">
          Loading posts...
        </div>
      )}

      {error && (
        <div className="p-20 text-center text-red-400">
          {error}
        </div>
      )}

      {!loading && !error && activeTab === 'debates' && debates.length === 0 && (
        <div className="p-20 text-center text-white/50">
          No active debates. Create a debate challenge to get started!
        </div>
      )}

      {!loading && !error && activeTab !== 'debates' && posts.length > 0 && (
        <div>
          {posts.map(post => (
            <Tweet 
              key={post.id} 
              post={post}
              currentUserId={currentUser.id}
              onPostUpdated={handlePostUpdated}
              onAuthorFollowChange={handleAuthorFollowChange}
              canDelete={activeTab === 'yourPosts'}
              onPostDeleted={handlePostDeleted}
            />
          ))}
        </div>
      )}

      {!loading && !error && activeTab === 'debates' && debates.length > 0 && (
        <div>
          {debates.map(debate => (
            <DebateCard 
              key={debate.id} 
              debate={debate}
              onDebateUpdated={loadPosts}
            />
          ))}
        </div>
      )}
  </div>
)}

export default MainFeed;