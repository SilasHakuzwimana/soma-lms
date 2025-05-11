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

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;

public class TimeUtils {
    private static final ZoneId KIGALI_ZONE = ZoneId.of("Africa/Kigali");

    public static Timestamp getCurrentKigaliTimestamp() {
        ZonedDateTime kigaliTime = ZonedDateTime.now(KIGALI_ZONE);
        return Timestamp.valueOf(kigaliTime.toLocalDateTime());
    }

//     public static Timestamp getCurrentKigaliTimestamp() {
//        return Timestamp.valueOf(LocalDateTime.now(KIGALI_ZONE));
//    }

    public static Timestamp getExpiryKigaliTimestamp(int minutesValid) {
        return Timestamp.valueOf(LocalDateTime.now(KIGALI_ZONE).plusMinutes(minutesValid));
    }
}
