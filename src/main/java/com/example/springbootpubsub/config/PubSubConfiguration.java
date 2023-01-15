package com.example.springbootpubsub.config;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.boot.context.properties.ConfigurationProperties;

@ConfigurationProperties(prefix = "mike.pubsub")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class PubSubConfiguration {
    private String topic;
    private String subscription;
}
