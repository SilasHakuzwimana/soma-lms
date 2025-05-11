/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utils;

/**
 *
 * @author hakus
 */
// File: utils/OTPGenerator.java

import java.security.SecureRandom;



public class OTPGenerator {

    public static String generateOTP(int length) {
        SecureRandom random = new SecureRandom();
        StringBuilder otp = new StringBuilder();
        for (int i = 0; i < length; i++) {
            otp.append(random.nextInt(6));
        }
        return otp.toString();
    }
}
