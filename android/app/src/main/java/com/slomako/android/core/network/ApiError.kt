package com.slomako.android.core.network

sealed class ApiError(message: String) : Exception(message) {
    data class Http(val code: Int, val body: String) : ApiError("HTTP $code: $body")
    data class Network(val throwable: Throwable) : ApiError("Network error: ${throwable.message}")
}