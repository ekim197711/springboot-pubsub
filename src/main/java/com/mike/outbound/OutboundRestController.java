package com.mike.outbound;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/send")
@RequiredArgsConstructor
@Slf4j
public class OutboundRestController {
    private final OutboundConfiguration.PubsubOutboundGateway messagingGateway;

    @PostMapping("/")
    public void sendMessage(@RequestBody String message){
        log.info("Send this message to outbound channgel {}", message);
        messagingGateway.sendToPubsub(message);
    }

}
