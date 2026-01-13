package com.aisocial.platform.repository;

import com.aisocial.platform.entity.Post;
import com.aisocial.platform.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.UUID;

public interface PostRepository extends JpaRepository<Post, UUID> {

    List<Post> findByAuthor(User author);

    List<Post> findByReplyTo(Post replyTo);

    List<Post> findByRepostOf(Post repostOf);
}
