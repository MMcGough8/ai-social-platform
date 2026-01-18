import React, { useState, useEffect } from 'react';
import { Vote } from 'lucide-react';
import debateService from '../../services/debateService';

function DebateVotingPanel({ debate, currentUserId, onVoteSubmitted }) {
  const [userVote, setUserVote] = useState(null);
  const [isVoting, setIsVoting] = useState(false);
  const [isLoadingVote, setIsLoadingVote] = useState(true);

  const isChallenger = currentUserId === debate.challenger?.id;
  const isDefender = currentUserId === debate.defender?.id;
  const isParticipant = isChallenger || isDefender;

  useEffect(() => {
    const loadUserVote = async () => {
      if (!currentUserId || debate.status !== 'VOTING') {
        setIsLoadingVote(false);
        return;
      }

      try {
        const voteData = await debateService.getUserVote(debate.id, currentUserId);
        setUserVote(voteData?.vote || null);
      } catch (err) {
        // 404 means no vote yet, which is fine
        if (err.response?.status !== 404) {
          console.error('Error loading vote:', err);
        }
      } finally {
        setIsLoadingVote(false);
      }
    };

    loadUserVote();
  }, [debate.id, currentUserId, debate.status]);

  const handleVote = async (voteType) => {
    if (isVoting || isParticipant) return;

    try {
      setIsVoting(true);
      await debateService.submitVote(debate.id, currentUserId, voteType);
      setUserVote(voteType);
      if (onVoteSubmitted) {
        onVoteSubmitted();
      }
    } catch (err) {
      console.error('Error submitting vote:', err);
    } finally {
      setIsVoting(false);
    }
  };

  if (debate.status !== 'VOTING') {
    return null;
  }

  const getVotePercentages = () => {
    if (!debate.totalVotes || debate.totalVotes === 0) {
      return { challenger: 0, defender: 0, tie: 0 };
    }
    return {
      challenger: Math.round((debate.votesChallenger / debate.totalVotes) * 100),
      defender: Math.round((debate.votesDefender / debate.totalVotes) * 100),
      tie: Math.round((debate.votesTie / debate.totalVotes) * 100),
    };
  };

  const percentages = getVotePercentages();

  if (isParticipant) {
    return (
      <div className="mt-4 p-4 bg-white/5 border border-white/10 rounded-xl">
        <div className="flex items-center gap-2 mb-3">
          <Vote className="w-5 h-5 text-[#c9a35e]" />
          <span className="font-bold text-white/80">Voting in Progress</span>
        </div>
        <p className="text-white/50 text-sm mb-4">
          As a participant, you cannot vote on this debate.
        </p>

        <div className="space-y-2">
          <VoteBar label="Challenger" percentage={percentages.challenger} color="blue" />
          <VoteBar label="Defender" percentage={percentages.defender} color="red" />
          <VoteBar label="Tie" percentage={percentages.tie} color="gray" />
        </div>

        <div className="text-xs text-white/40 text-center mt-3">
          {debate.totalVotes} total votes
        </div>
      </div>
    );
  }

  if (isLoadingVote) {
    return (
      <div className="mt-4 p-4 bg-white/5 border border-white/10 rounded-xl">
        <div className="text-center text-white/50">Loading...</div>
      </div>
    );
  }

  return (
    <div className="mt-4 p-4 bg-white/5 border border-white/10 rounded-xl">
      <div className="flex items-center gap-2 mb-3">
        <Vote className="w-5 h-5 text-[#c9a35e]" />
        <span className="font-bold text-white/80">Cast Your Vote</span>
      </div>

      {userVote && (
        <p className="text-white/50 text-sm mb-3">
          You voted for: <span className="font-semibold text-[#c9a35e]">{userVote}</span>
          <span className="text-white/40 ml-2">(click to change)</span>
        </p>
      )}

      <div className="grid grid-cols-3 gap-2 mb-4">
        <button
          onClick={() => handleVote('CHALLENGER')}
          disabled={isVoting}
          className={`px-4 py-3 rounded-xl font-bold text-sm transition-all
                      ${userVote === 'CHALLENGER'
                        ? 'bg-blue-500 text-white border-2 border-blue-400'
                        : 'bg-blue-500/20 text-blue-300 border border-blue-500/50 hover:bg-blue-500/30'}
                      disabled:opacity-50 disabled:cursor-not-allowed`}
        >
          Challenger
        </button>
        <button
          onClick={() => handleVote('DEFENDER')}
          disabled={isVoting}
          className={`px-4 py-3 rounded-xl font-bold text-sm transition-all
                      ${userVote === 'DEFENDER'
                        ? 'bg-red-500 text-white border-2 border-red-400'
                        : 'bg-red-500/20 text-red-300 border border-red-500/50 hover:bg-red-500/30'}
                      disabled:opacity-50 disabled:cursor-not-allowed`}
        >
          Defender
        </button>
        <button
          onClick={() => handleVote('TIE')}
          disabled={isVoting}
          className={`px-4 py-3 rounded-xl font-bold text-sm transition-all
                      ${userVote === 'TIE'
                        ? 'bg-gray-500 text-white border-2 border-gray-400'
                        : 'bg-gray-500/20 text-gray-300 border border-gray-500/50 hover:bg-gray-500/30'}
                      disabled:opacity-50 disabled:cursor-not-allowed`}
        >
          Tie
        </button>
      </div>

      <div className="space-y-2">
        <VoteBar label="Challenger" percentage={percentages.challenger} color="blue" />
        <VoteBar label="Defender" percentage={percentages.defender} color="red" />
        <VoteBar label="Tie" percentage={percentages.tie} color="gray" />
      </div>

      <div className="text-xs text-white/40 text-center mt-3">
        {debate.totalVotes} total votes
      </div>
    </div>
  );
}

function VoteBar({ label, percentage, color }) {
  const colorClasses = {
    blue: 'bg-blue-500',
    red: 'bg-red-500',
    gray: 'bg-gray-500',
  };

  return (
    <div>
      <div className="flex justify-between text-xs mb-1">
        <span className="text-white/60">{label}</span>
        <span className="text-white/80 font-semibold">{percentage}%</span>
      </div>
      <div className="h-2 bg-white/10 rounded-full overflow-hidden">
        <div
          className={`h-full ${colorClasses[color]} transition-all duration-500`}
          style={{ width: `${percentage}%` }}
        />
      </div>
    </div>
  );
}

export default DebateVotingPanel;
