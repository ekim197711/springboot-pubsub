package com.example.springbootpubsub.outbound;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.*;
@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)

public class OutboundRestControllerTest {

    @Autowired
    OutboundRestController controller;
    @Test
    void sendMessage() {
        controller.sendMessage("Test 123");
        controller.sendMessage("Hello");
        controller.sendMessage("Is pub and sub working?");
        controller.sendMessage("it might be");

    }
}