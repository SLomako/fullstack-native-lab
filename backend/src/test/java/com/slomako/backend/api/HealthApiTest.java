package com.slomako.backend.api;

import org.json.JSONObject;
import org.junit.jupiter.api.Test;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

public class HealthApiTest {

    @Test
    void healthEndpointReturnsCorrectVersion() throws Exception {
        var client = HttpClient.newHttpClient();
        var request = HttpRequest.newBuilder()
                .uri(URI.create("http://localhost:8080/health"))
                .build();

        var response = client.send(request, HttpResponse.BodyHandlers.ofString());
        var json = new JSONObject(response.body());

        assertEquals("ok", json.getString("status"));
        assertNotNull(json.getString("time"));
        assertEquals("0.0.1-SNAPSHOT", json.getString("version"));
    }
}
