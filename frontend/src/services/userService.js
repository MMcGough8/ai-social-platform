
import api from './api';

const userService = {
  getAllUsers: async () => {
    const response = await api.get('/users');
    return response.data;
  },

  getCurrentUser: async (userId) => {
    const response = await api.get('/users/me', {
      headers: { 'X-User-Id': userId }
    });
    return response.data;
  },

  getUserById: async (id, currentUserId = null) => {
    const headers = currentUserId ? { 'X-User-Id': currentUserId } : {};
    const response = await api.get(`/users/${id}`, { headers });
    return response.data;
  },

  getUserByUsername: async (username, currentUserId = null) => {
    const headers = currentUserId ? { 'X-User-Id': currentUserId } : {};
    const response = await api.get(`/users/username/${username}`, { headers });
    return response.data;
  },

  getTrustBreakdown: async (userId) => {
    const response = await api.get(`/users/${userId}/trust-breakdown`);
    return response.data;
  },
};

export default userService;
