package com.slomako.backend.health;

import java.time.Instant;

public record HealthResponse(String status, String version, Instant time) {
}
