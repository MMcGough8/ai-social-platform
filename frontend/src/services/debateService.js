
import api from './api';

const debateService = {
  createChallenge: async (challengerId, defenderId, topic) => {
    const response = await api.post('/api/debates', {
      defenderId: defenderId,
      topic: topic
    }, {
      headers: { 'X-User-Id': challengerId }
    });
    return response.data;
  },

  getDebateById: async (debateId) => {
    const response = await api.get(`/api/debates/${debateId}`);
    return response.data;
  },

  getActiveDebates: async () => {
    const response = await api.get('/api/debates');
    return response.data;
  },

  getVotingDebates: async () => {
    const response = await api.get('/api/debates/voting');
    return response.data;
  },

  acceptChallenge: async (debateId, userId) => {
    const response = await api.post(`/api/debates/${debateId}/accept`, null, {
      headers: { 'X-User-Id': userId }
    });
    return response.data;
  },

  declineChallenge: async (debateId, userId) => {
    await api.post(`/api/debates/${debateId}/decline`, null, {
      headers: { 'X-User-Id': userId }
    });
  },

  getDebatesByUser: async (userId) => {
    const response = await api.get(`/api/debates/user/${userId}`);
    return response.data;
  },

  getPendingChallenges: async (userId) => {
    const response = await api.get('/api/debates/pending', {
      headers: { 'X-User-Id': userId }
    });
    return response.data;
  },

  submitArgument: async (debateId, userId, content) => {
    const response = await api.post(`/api/debates/${debateId}/arguments`, {
      content: content
    }, {
      headers: { 'X-User-Id': userId }
    });
    return response.data;
  },
};

export default debateService;
