package com.slomako.android.features

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext

class StatusCheckViewModel(
    private val service: StatusCheckService = StatusCheckService()
) : ViewModel() {

    private val _state = MutableStateFlow(StatusUiState())
    val state: StateFlow<StatusUiState> = _state

    fun fetchStatus(host: String) {
        _state.value = StatusUiState(isLoading = true, statusText = "Loading...")

        viewModelScope.launch {
            val result = runCatching {
                withContext(Dispatchers.IO) {
                    service.getStatus(host)
                }
            }

            _state.value = result.fold(
                onSuccess = { model ->
                    StatusUiState(
                        isLoading = false,
                        statusText = "Status: ${model.status}\nVersion: ${model.version}"
                    )
                },
                onFailure = {
                    StatusUiState(
                        isLoading = false,
                        statusText = "Error loading status"
                    )
                }
            )
        }
    }
}