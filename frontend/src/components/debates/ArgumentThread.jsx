import React, { useState } from 'react';
import FactCheckBadge from '../factcheck/FactCheckBadge';
import FactCheckButton from '../factcheck/FactCheckButton';
import FactCheckModal from '../factcheck/FactCheckModal';
import factcheckService from '../../services/factcheckService';

function ArgumentThread({ debate, arguments: args, currentUserId, onArgumentUpdated }) {
  const [loadingArgumentId, setLoadingArgumentId] = useState(null);
  const [selectedArgument, setSelectedArgument] = useState(null);
  const [factCheckResult, setFactCheckResult] = useState(null);
  const [isModalOpen, setIsModalOpen] = useState(false);

  // Group arguments by round
  const rounds = [1, 2, 3];

  const getArgumentForRound = (round, role) => {
    // Match argument by round number and by comparing user ID with challenger/defender ID
    const targetUserId = role === 'CHALLENGER'
      ? debate.challenger?.id
      : debate.defender?.id;

    return args.find(
      (arg) => arg.roundNumber === round &&
               String(arg.user?.id) === String(targetUserId)
    );
  };

  // Determine whose turn it is based on whoseTurnId
  const isWaitingForChallenger = debate.whoseTurnId &&
    String(debate.whoseTurnId) === String(debate.challenger?.id);
  const isWaitingForDefender = debate.whoseTurnId &&
    String(debate.whoseTurnId) === String(debate.defender?.id);

  const formatTime = (timestamp) => {
    if (!timestamp) return '';
    const date = new Date(timestamp);
    return date.toLocaleString('en-US', {
      month: 'short',
      day: 'numeric',
      hour: 'numeric',
      minute: '2-digit',
    });
  };

  const handleFactCheck = async (argument) => {
    setLoadingArgumentId(argument.id);
    try {
      const result = await factcheckService.checkArgument(argument.id, currentUserId);
      setFactCheckResult(result);
      setSelectedArgument(argument);
      setIsModalOpen(true);
      // Notify parent to refresh arguments data
      if (onArgumentUpdated) {
        onArgumentUpdated();
      }
    } catch (error) {
      console.error('Error fact-checking argument:', error);
      setFactCheckResult({ error: 'Failed to fact-check argument. Please try again.' });
      setSelectedArgument(argument);
      setIsModalOpen(true);
    } finally {
      setLoadingArgumentId(null);
    }
  };

  const handleViewFactCheck = (argument) => {
    // Parse stored fact-check data if available
    if (argument.factCheckData) {
      try {
        const parsedData = JSON.parse(argument.factCheckData);
        setFactCheckResult(parsedData);
      } catch (e) {
        setFactCheckResult({
          verdict: argument.factCheckStatus,
          confidence: argument.factCheckScore ? argument.factCheckScore * 100 : null
        });
      }
    } else {
      setFactCheckResult({
        verdict: argument.factCheckStatus,
        confidence: argument.factCheckScore ? argument.factCheckScore * 100 : null
      });
    }
    setSelectedArgument(argument);
    setIsModalOpen(true);
  };

  const renderArgumentContent = (arg, label) => {
    if (!arg) return null;

    const isChecked = arg.factCheckStatus && arg.factCheckStatus !== 'UNCHECKED';
    const isLoading = loadingArgumentId === arg.id;

    return (
      <div>
        <p className="text-white/90 text-sm leading-relaxed">
          {arg.content}
        </p>
        <div className="flex items-center justify-between mt-2">
          <p className="text-white/40 text-xs">
            {formatTime(arg.createdAt)}
          </p>
          <div className="flex items-center gap-2">
            {isChecked ? (
              <FactCheckBadge
                status={arg.factCheckStatus}
                score={arg.factCheckScore}
                size="xs"
                onClick={() => handleViewFactCheck(arg)}
              />
            ) : (
              <FactCheckButton
                onClick={() => handleFactCheck(arg)}
                isLoading={isLoading}
                isChecked={false}
              />
            )}
          </div>
        </div>
      </div>
    );
  };

  return (
    <div className="space-y-4">
      {rounds.map((round) => {
        const challengerArg = getArgumentForRound(round, 'CHALLENGER');
        const defenderArg = getArgumentForRound(round, 'DEFENDER');

        // Skip rounds that haven't started yet
        if (!challengerArg && !defenderArg && round > debate.currentRound) {
          return null;
        }

        return (
          <div key={round} className="border border-veritas-pink/20 rounded-xl overflow-hidden">
            <div className="bg-gradient-to-r from-veritas-purple/10 to-veritas-pink/10 px-4 py-2 border-b border-veritas-pink/20">
              <span className="text-sm font-bold text-white/70">Round {round}</span>
            </div>

            <div className="grid grid-cols-2 divide-x divide-veritas-pink/20">
              {/* Challenger Column */}
              <div className="p-4">
                <div className="text-xs font-bold text-veritas-coral mb-2 uppercase tracking-wider">
                  Challenger
                </div>
                {challengerArg ? (
                  renderArgumentContent(challengerArg, 'Challenger')
                ) : (
                  debate.currentRound === round && isWaitingForChallenger ? (
                    <div className="text-white/30 text-sm italic">
                      Waiting for argument...
                    </div>
                  ) : (
                    <div className="text-white/20 text-sm">-</div>
                  )
                )}
              </div>

              {/* Defender Column */}
              <div className="p-4">
                <div className="text-xs font-bold text-veritas-coral mb-2 uppercase tracking-wider">
                  Defender
                </div>
                {defenderArg ? (
                  renderArgumentContent(defenderArg, 'Defender')
                ) : (
                  debate.currentRound === round && isWaitingForDefender ? (
                    <div className="text-white/30 text-sm italic">
                      Waiting for argument...
                    </div>
                  ) : challengerArg ? (
                    <div className="text-white/30 text-sm italic">
                      Waiting for argument...
                    </div>
                  ) : (
                    <div className="text-white/20 text-sm">-</div>
                  )
                )}
              </div>
            </div>
          </div>
        );
      })}

      {args.length === 0 && debate.status === 'ACTIVE' && (
        <div className="text-center py-8 text-white/40">
          No arguments yet. The debate is just getting started!
        </div>
      )}

      {/* Fact Check Modal */}
      <FactCheckModal
        isOpen={isModalOpen}
        onClose={() => {
          setIsModalOpen(false);
          setSelectedArgument(null);
          setFactCheckResult(null);
        }}
        result={factCheckResult}
        postContent={selectedArgument?.content}
      />
    </div>
  );
}

export default ArgumentThread;
