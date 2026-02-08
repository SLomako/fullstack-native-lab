package com.slomako.android.features

import com.slomako.android.core.network.ApiError
import okhttp3.OkHttpClient
import okhttp3.Request

class StatusCheckService(
    private val client: OkHttpClient = OkHttpClient()
) {

    fun getStatus(host: String): StatusCheckModel {
        val url = "http://$host:8080/health"
        val request = Request.Builder().url(url).get().build()

        try {
            client.newCall(request).execute().use { response ->
                val body = response.body.string()
                if (!response.isSuccessful) throw ApiError.Http(response.code, body)
                return StatusCheckParser.parse(body)
            }
        } catch (e: ApiError) {
            throw e
        } catch (t: Throwable) {
            throw ApiError.Network(t)
        }
    }
}