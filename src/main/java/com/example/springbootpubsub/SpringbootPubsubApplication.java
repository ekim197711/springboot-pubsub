package com.example.springbootpubsub;

import com.example.springbootpubsub.config.PubSubConfiguration;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;

@SpringBootApplication
@EnableConfigurationProperties(PubSubConfiguration.class)
public class SpringbootPubsubApplication {

    public static void main(String[] args) {
        SpringApplication.run(SpringbootPubsubApplication.class, args);
    }

}
