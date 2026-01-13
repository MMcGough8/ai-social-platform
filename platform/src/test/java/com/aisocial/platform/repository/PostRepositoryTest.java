package com.aisocial.platform.repository;

import com.aisocial.platform.entity.Post;
import com.aisocial.platform.entity.User;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.test.context.ActiveProfiles;

import java.time.Instant;
import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;

@DataJpaTest
@AutoConfigureTestDatabase(replace = AutoConfigureTestDatabase.Replace.NONE)
@ActiveProfiles("test")
@DisplayName("Post Repository Tests")
class PostRepositoryTest {

    @Autowired
    private PostRepository postRepository;

    @Autowired
    private UserRepository userRepository;

    @Test
    @DisplayName("Should find posts by author")
    void shouldFindPostsByAuthor() {
        User user = userRepository.save(new User("alice", "Alice", "Bio"));

        Post post1 = new Post();
        post1.setAuthor(user);
        post1.setContent("Post 1");

        Post post2 = new Post();
        post2.setAuthor(user);
        post2.setContent("Post 2");

        postRepository.save(post1);
        postRepository.save(post2);

        List<Post> posts = postRepository.findByAuthor(user);

        assertThat(posts).hasSize(2);
        assertThat(posts).allMatch(p -> p.getAuthor().equals(user));
    }

    @Test
    @DisplayName("Should find replies to a post")
    void shouldFindReplies() {
        User user = userRepository.save(new User("bob", "Bob", "Bio"));

        Post parent = new Post();
        parent.setAuthor(user);
        parent.setContent("Parent");

        parent = postRepository.save(parent);

        Post reply = new Post();
        reply.setAuthor(user);
        reply.setContent("Reply");
        reply.setReplyTo(parent);

        postRepository.save(reply);

        List<Post> replies = postRepository.findByReplyTo(parent);

        assertThat(replies).hasSize(1);
        assertThat(replies.get(0).getReplyTo()).isEqualTo(parent);
    }

    @Test
    @DisplayName("Should find reposts of a post")
    void shouldFindReposts() {
        // Save a user
        User user = userRepository.save(new User("carol", "Carol", "Bio"));

        // Save the original post
        Post original = new Post();
        original.setAuthor(user);
        original.setContent("Original");
        original.setCreatedAt(Instant.now()); // optional if @PrePersist sets it
        original = postRepository.save(original);

        // Save the repost
        Post repost = new Post();
        repost.setAuthor(user);
        repost.setRepostOf(original);
        repost.setContent("Repost content"); // <-- must set content!
        repost.setCreatedAt(Instant.now()); // optional if @PrePersist sets it
        repost = postRepository.save(repost);

        // Fetch reposts of the original
        List<Post> reposts = postRepository.findByRepostOf(original);

        assertThat(reposts).hasSize(1);
        assertThat(reposts.get(0).getRepostOf()).isEqualTo(original);
        assertThat(reposts.get(0).getContent()).isEqualTo("Repost content"); // optional extra check
    }
}
