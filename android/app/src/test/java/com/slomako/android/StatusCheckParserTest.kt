package com.slomako.android

import com.slomako.android.features.StatusCheckParser
import org.junit.Test

import org.junit.Assert.*

class StatusCheckParserTest {

    @Test
    fun parse_ok() {
        val json = """{"status":"ok","version":"0.0.2-SNAPSHOT","time":"2026-02-01T17:05:04.016Z"}"""
        val model = StatusCheckParser.parse(json)

        assertEquals("ok", model.status)
        assertEquals("0.0.2-SNAPSHOT", model.version)
    }
}