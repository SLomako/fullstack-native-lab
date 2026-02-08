package com.slomako.android

import androidx.compose.ui.test.junit4.createAndroidComposeRule
import androidx.compose.ui.test.onNodeWithText
import androidx.compose.ui.test.performClick
import androidx.test.ext.junit.runners.AndroidJUnit4
import org.junit.Rule
import org.junit.Test
import org.junit.runner.RunWith

@RunWith(AndroidJUnit4::class)
class StatusCheckUiTest {

    @get:Rule
    val rule = createAndroidComposeRule<MainActivity>()

    @Test
    fun tapCheckStatus_showsCorrectVersion() {
        rule.onNodeWithText("Check Status").assertExists().performClick()

        rule.onNodeWithText(
            "Status: ok\nVersion: 0.0.1-SNAPSHOT",
            useUnmergedTree = true
        ).assertExists()
    }
}