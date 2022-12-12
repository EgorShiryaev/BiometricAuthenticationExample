package com.example.biometricauthexample;

import android.app.Activity;

import androidx.annotation.NonNull;
import androidx.biometric.BiometricManager;
import androidx.biometric.BiometricPrompt;
import androidx.fragment.app.FragmentActivity;

import java.util.concurrent.Executor;


public class BiometricAuth {

    interface AuthCompletionHandler {
        void onSuccess();

        void onFailure();

        void onError(Integer code, String error);
    }

    private Activity activity;
    private Executor executor;

    BiometricAuth(Activity activity, Executor executor){
        this.activity = activity;
        this.executor = executor;
    }

    public void run(AuthCompletionHandler handler){
        BiometricPrompt prompt = new BiometricPrompt((FragmentActivity) activity, executor, new BiometricPrompt.AuthenticationCallback() {
            @Override
            public void onAuthenticationError(int errorCode, @NonNull CharSequence errString) {
                handler.onError(errorCode, errString.toString());
                super.onAuthenticationError(errorCode, errString);
            }

            @Override
            public void onAuthenticationSucceeded(@NonNull BiometricPrompt.AuthenticationResult result) {
                handler.onSuccess();
                super.onAuthenticationSucceeded(result);
            }

            @Override
            public void onAuthenticationFailed() {
                handler.onFailure();
                super.onAuthenticationFailed();
            }
        });

        BiometricPrompt.PromptInfo info = new BiometricPrompt.PromptInfo.Builder().setTitle("Авторизовать").setDescription("Авторизуйтесь с помощью биометрии").setNegativeButtonText("Отмена").build();

        prompt.authenticate(info);
    }


    public Integer getStatus(){
        BiometricManager manager =  MainActivity.biometricManager;
        return manager.canAuthenticate(BiometricManager.Authenticators.BIOMETRIC_WEAK);
    }
}
