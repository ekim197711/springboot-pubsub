package com.mike.outbound;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
@ActiveProfiles("local")
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