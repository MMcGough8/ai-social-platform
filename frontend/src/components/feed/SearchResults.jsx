import React from 'react';
import Tweet from './Tweet';
import { TrustScoreBadge } from '../trustscore';
import followService from '../../services/followService';
import logo from '../../assets/CondorTransparent.png';

function SearchResults({ 
  searchType, 
  userResults, 
  postResults, 
  loading, 
  currentUserId,
  onPostUpdated,
  onFactCheckCompleted,
  onAuthorFollowChange,
  onUserClick,
  onLoadMoreUsers,
  onLoadMorePosts,
  hasMoreUsers,
  hasMorePosts,
  onUserFollowChange
}) {
  
  if (loading) {
    return (
      <div className="p-20 text-center text-white/50" style={{ minWidth: '600px' }}>
        <div className="animate-pulse">Searching...</div>
      </div>
    );
  }

  const showUsers = searchType === 'all' || searchType === 'users';
  const showPosts = searchType === 'all' || searchType === 'posts';

  const hasUserResults = userResults && userResults.length > 0;
  const hasPostResults = postResults && postResults.length > 0;
  const hasAnyResults = hasUserResults || hasPostResults;

  if (!hasAnyResults) {
    return (
      <div className="p-20 text-center text-white/50" style={{ minWidth: '600px' }}>
        <div className="text-lg">No results found</div>
        <div className="text-sm text-white/30 mt-2">Try a different search term</div>
      </div>
    );
  }

  return (
    <div style={{ minWidth: '600px' }}>
      {/* User Results Section */}
      {showUsers && hasUserResults && (
        <div>
          <div className="px-5 py-3 border-b border-white/10 bg-white/5">
            <h3 className="text-white font-bold text-sm uppercase tracking-wider">
              Users ({userResults.length})
            </h3>
          </div>
          <div>
            {userResults.map(user => (
              <UserSearchItem
                key={user.id}
                user={user}
                currentUserId={currentUserId}
                onUserClick={onUserClick}
                onUserFollowChange={onUserFollowChange}
              />
            ))}
          </div>
          {hasMoreUsers && (
            <button
              onClick={onLoadMoreUsers}
              className="w-full py-3 text-center text-veritas-pink hover:bg-veritas-pink/10 
                         transition-colors border-b border-white/10 text-sm font-semibold"
            >
              Load more users
            </button>
          )}
        </div>
      )}

      {/* Post Results Section */}
      {showPosts && hasPostResults && (
        <div>
          {showUsers && hasUserResults && (
            <div className="px-5 py-3 border-b border-white/10 bg-white/5 mt-6">
              <h3 className="text-white font-bold text-sm uppercase tracking-wider">
                Posts ({postResults.length})
              </h3>
            </div>
          )}
          <div>
            {postResults.map(post => (
              <Tweet
                key={post.id}
                post={post}
                currentUserId={currentUserId}
                onPostUpdated={onPostUpdated}
                onFactCheckCompleted={onFactCheckCompleted}
                onAuthorFollowChange={onAuthorFollowChange}
              />
            ))}
          </div>
          {hasMorePosts && (
            <button
              onClick={onLoadMorePosts}
              className="w-full py-3 text-center text-veritas-pink hover:bg-veritas-pink/10 
                         transition-colors border-b border-white/10 text-sm font-semibold"
            >
              Load more posts
            </button>
          )}
        </div>
      )}
    </div>
  );
}

// User Search Item Component - copied follow functionality exactly from Tweet.jsx
function UserSearchItem({ user, currentUserId, onUserClick, onUserFollowChange }) {
  // Copy the exact follow state management from Tweet.jsx
  const [isFollowing, setIsFollowing] = React.useState(Boolean(user.isFollowing));
  const [isFollowLoading, setIsFollowLoading] = React.useState(false);
  const [isFollowHovering, setIsFollowHovering] = React.useState(false);

  // Update local state when prop changes (for when follow state is updated from outside)
  React.useEffect(() => {
    setIsFollowing(Boolean(user.isFollowing));
  }, [user.isFollowing]);

  // Copy the exact follow handler from Tweet.jsx
  const handleFollowToggle = async (e) => {
    e.preventDefault();
    e.stopPropagation();
    
    if (isFollowLoading || !currentUserId || !user) return;
    
    if (currentUserId === user.id) return;

    try {
      setIsFollowLoading(true);
      
      const response = await followService.toggleFollow(currentUserId, user.id);
      setIsFollowing(response.following);

      if (onUserFollowChange) {
        onUserFollowChange(user.id, response.following);
      }
    } catch (error) {
      console.error('Error toggling follow:', error);
    } finally {
      setIsFollowLoading(false);
    }
  };

  const isOwnProfile = currentUserId === user.id;

  return (
    <div className="border-b border-white/[0.08] p-5 hover:bg-veritas-pink/5 transition-all duration-300">
      <div className="flex items-start justify-between gap-4">
        {/* Left side: Avatar and user info */}
        <div 
          className="flex items-start gap-4 flex-1 cursor-pointer"
          onClick={() => onUserClick && onUserClick(user)}
        >
          <div className="w-12 h-12 rounded-xl bg-veritas-blue-dark 
                          flex items-center justify-center text-xl">
            <img 
              src={logo} 
              alt="Candor Logo" 
              className="w-10 h-10 object-contain"
            />
          </div>
          <div className="flex-1 min-w-0">
            <div className="flex items-center gap-2 mb-1 flex-wrap">
              <span className="font-bold text-white text-[15px]">
                {user.displayName}
              </span>
              <span className="text-white/50 text-sm">@{user.username}</span>
              {user.trustScore != null && (
                <TrustScoreBadge
                  score={user.trustScore}
                  size="sm"
                  showTooltip={true}
                  userId={user.id}
                />
              )}
            </div>
            {user.bio && (
              <p className="text-white/70 text-sm">{user.bio}</p>
            )}
          </div>
        </div>
        
        {/* Right side: Follow button - copied exact styling and logic from Tweet.jsx */}
        {!isOwnProfile && currentUserId && (
          <div className="flex-shrink-0 w-[100px]">
            <button
              onClick={handleFollowToggle}
              onMouseEnter={() => setIsFollowHovering(true)}
              onMouseLeave={() => setIsFollowHovering(false)}
              disabled={isFollowLoading}
              className={`
                w-full px-4 py-1.5 rounded-full font-bold text-xs transition-all duration-300
                disabled:opacity-50 disabled:cursor-not-allowed
                ${isFollowing 
                  ? 'bg-white/10 border border-white/20 text-white hover:bg-red-500/20 hover:border-red-500 hover:text-red-400' 
                  : 'bg-gradient-to-br from-veritas-pink to-veritas-pink-dark text-white border border-transparent hover:shadow-[0_4px_12px_rgba(255,107,157,0.3)]'
                }
              `}
            >
              {isFollowLoading 
                ? '...' 
                : isFollowing && isFollowHovering 
                  ? 'Unfollow' 
                  : isFollowing 
                    ? 'Following' 
                    : 'Follow'}
            </button>
          </div>
        )}
      </div>
    </div>
  );
}

export default SearchResults;