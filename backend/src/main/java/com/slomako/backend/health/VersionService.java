package com.slomako.backend.health;

import org.springframework.stereotype.Component;

@Component
public class VersionService {

    public String getVersion() {
        String version = getClass().getPackage().getImplementationVersion();
        return version != null ? version : "dev";
    }
}
