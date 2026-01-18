import React, { useState, useEffect } from 'react';
import { createPortal } from 'react-dom';
import { X, Trophy } from 'lucide-react';
import debateService from '../../services/debateService';
import TurnIndicator from './TurnIndicator';
import ArgumentThread from './ArgumentThread';
import ArgumentComposer from './ArgumentComposer';
import DebateVotingPanel from './DebateVotingPanel';

function DebateDetailModal({ isOpen, onClose, debate: initialDebate, currentUserId, onDebateUpdated }) {
  const [debate, setDebate] = useState(initialDebate);
  const [arguments_, setArguments] = useState([]);
  const [isLoading, setIsLoading] = useState(true);

  useEffect(() => {
    if (isOpen && initialDebate?.id) {
      loadDebateData();
    }
  }, [isOpen, initialDebate?.id]);

  const loadDebateData = async () => {
    try {
      setIsLoading(true);

      const [debateData, argsData] = await Promise.all([
        debateService.getDebateById(initialDebate.id),
        debateService.getDebateArguments(initialDebate.id),
      ]);

      setDebate(debateData);
      setArguments(argsData || []);
    } catch (err) {
      console.error('Error loading debate data:', err);
    } finally {
      setIsLoading(false);
    }
  };

  const handleArgumentSubmitted = () => {
    loadDebateData();
    if (onDebateUpdated) {
      onDebateUpdated();
    }
  };

  const handleVoteSubmitted = () => {
    loadDebateData();
    if (onDebateUpdated) {
      onDebateUpdated();
    }
  };

  if (!isOpen) return null;

  const getStatusBadge = (status) => {
    const badges = {
      PENDING: { bg: 'bg-yellow-500/20', border: 'border-yellow-500/50', text: 'text-yellow-300', label: 'Pending' },
      ACTIVE: { bg: 'bg-red-500/20', border: 'border-red-500/50', text: 'text-red-300', label: 'Active' },
      VOTING: { bg: 'bg-blue-500/20', border: 'border-blue-500/50', text: 'text-blue-300', label: 'Voting' },
      COMPLETED: { bg: 'bg-green-500/20', border: 'border-green-500/50', text: 'text-green-300', label: 'Completed' },
    };
    const badge = badges[status] || badges.PENDING;

    return (
      <span className={`px-3 py-1 rounded-lg text-xs font-bold ${badge.bg} border ${badge.border} ${badge.text}`}>
        {badge.label}
      </span>
    );
  };

  const modalContent = (
    <div className="fixed inset-0 bg-black/60 backdrop-blur-sm z-[9999] flex items-center justify-center p-4">
      <div className="bg-gradient-to-br from-[#1a3a52] to-[#234562] border-2 border-white/20
                      rounded-3xl max-w-4xl w-full max-h-[90vh] overflow-hidden shadow-2xl flex flex-col">
        {/* Header */}
        <div className="p-6 border-b border-white/10 flex-shrink-0">
          <div className="flex items-center justify-between mb-4">
            <div className="flex items-center gap-3">
              <span className="text-3xl">⚔️</span>
              <h2 className="text-2xl font-bold">Debate</h2>
              {getStatusBadge(debate?.status)}
            </div>
            <button
              onClick={onClose}
              className="text-white/50 hover:text-white p-2 hover:bg-white/10 rounded-lg transition-all"
            >
              <X className="w-6 h-6" />
            </button>
          </div>

          {/* Topic */}
          <div className="mb-4">
            <div className="text-xs text-white/50 font-bold mb-1 uppercase tracking-wider">Topic</div>
            <div className="text-white/90 text-lg">{debate?.topic}</div>
          </div>

          {/* Participants */}
          <div className="grid grid-cols-2 gap-4">
            <div className="bg-blue-500/10 border border-blue-500/30 rounded-xl p-3">
              <div className="text-xs text-blue-300 font-bold mb-1">CHALLENGER</div>
              <div className="font-bold">{debate?.challenger?.displayName}</div>
              <div className="text-sm text-white/50">@{debate?.challenger?.username}</div>
            </div>
            <div className="bg-red-500/10 border border-red-500/30 rounded-xl p-3">
              <div className="text-xs text-red-300 font-bold mb-1">DEFENDER</div>
              <div className="font-bold">{debate?.defender?.displayName}</div>
              <div className="text-sm text-white/50">@{debate?.defender?.username}</div>
            </div>
          </div>
        </div>

        {/* Body - Scrollable */}
        <div className="flex-1 overflow-y-auto p-6">
          {isLoading ? (
            <div className="flex items-center justify-center py-12">
              <div className="animate-spin w-8 h-8 border-2 border-[#c9a35e] border-t-transparent rounded-full" />
            </div>
          ) : (
            <>
              {/* Winner Banner for Completed */}
              {debate?.status === 'COMPLETED' && debate?.winnerId && (
                <div className="mb-4 p-4 bg-[#c9a35e]/20 border border-[#c9a35e]/50 rounded-xl">
                  <div className="flex items-center justify-center gap-3">
                    <Trophy className="w-8 h-8 text-[#c9a35e]" />
                    <div className="text-center">
                      <div className="text-sm text-white/60">Winner</div>
                      <div className="text-xl font-bold text-[#c9a35e]">
                        {debate.winnerId === debate.challenger?.id
                          ? debate.challenger?.displayName
                          : debate.defender?.displayName}
                      </div>
                    </div>
                    <Trophy className="w-8 h-8 text-[#c9a35e]" />
                  </div>
                </div>
              )}

              {/* Turn Indicator */}
              <TurnIndicator debate={debate} currentUserId={currentUserId} />

              {/* Arguments Thread */}
              <ArgumentThread debate={debate} arguments={arguments_} />

              {/* Argument Composer */}
              <ArgumentComposer
                debate={debate}
                currentUserId={currentUserId}
                onArgumentSubmitted={handleArgumentSubmitted}
              />

              {/* Voting Panel */}
              <DebateVotingPanel
                debate={debate}
                currentUserId={currentUserId}
                onVoteSubmitted={handleVoteSubmitted}
              />
            </>
          )}
        </div>
      </div>
    </div>
  );

  return createPortal(modalContent, document.body);
}

export default DebateDetailModal;
