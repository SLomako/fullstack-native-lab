package com.slomako.android.features

import com.google.gson.Gson

object StatusCheckParser {
    private val gson = Gson()

    fun parse(data: String): StatusCheckModel {
        return gson.fromJson(data, StatusCheckModel::class.java)
    }
}