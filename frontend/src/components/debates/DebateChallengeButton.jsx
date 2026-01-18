import React, { useState } from 'react';
import { Swords } from 'lucide-react';
import CreateDebateModal from './CreateDebateModal';

function DebateChallengeButton({ postAuthor, postContent, currentUserId, onDebateCreated }) {
  const [showModal, setShowModal] = useState(false);

  // Don't show challenge button on own posts
  if (!postAuthor || currentUserId === postAuthor.id) {
    return null;
  }

  const handleClick = (e) => {
    e.preventDefault();
    e.stopPropagation();
    setShowModal(true);
  };

  const handleClose = () => {
    setShowModal(false);
  };

  const handleDebateCreated = () => {
    setShowModal(false);
    if (onDebateCreated) {
      onDebateCreated();
    }
  };

  // Truncate post content for topic suggestion
  const suggestedTopic = postContent?.length > 200
    ? postContent.substring(0, 200) + '...'
    : postContent;

  return (
    <>
      <button
        onClick={handleClick}
        className="flex items-center gap-2 cursor-pointer transition-all duration-300
                   p-1.5 rounded-[10px] relative bg-transparent border-none
                   text-white/50 text-[13px] font-semibold
                   hover:text-[#c9a35e] hover:bg-[#c9a35e]/10"
        title="Challenge to Debate"
      >
        <Swords className="w-5 h-5" />
      </button>

      <CreateDebateModal
        isOpen={showModal}
        onClose={handleClose}
        onDebateCreated={handleDebateCreated}
        prefilledDefender={postAuthor}
        prefilledTopic={suggestedTopic}
      />
    </>
  );
}

export default DebateChallengeButton;
