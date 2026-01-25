package com.slomako.backend.health;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.Instant;

@RestController
@Tag(name = "Health", description = "App status check")
public class HealthController {

    private final VersionService versionService;

    public HealthController(VersionService versionService) {
        this.versionService = versionService;
    }

    @GetMapping("/health")
    @Operation(summary = "Check if app is running", description = "Returns status, version and time")
    public HealthResponse health() {
        return new HealthResponse("ok", versionService.getVersion(), Instant.now());
    }

}
