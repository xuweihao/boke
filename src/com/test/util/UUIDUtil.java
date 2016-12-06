package com.test.util;

import java.util.Date;
import java.util.UUID;

public class UUIDUtil {
	
	 public static String getUUID(){ 
	        /*String s = UUID.randomUUID().toString();*/
	        Date date = new Date();
	        String ss = Long.toString(date.getTime());
	        //È¥µô¡°-¡±·ûºÅ 
	        return /*s.substring(0,8)+*/ss; 
	 }
}
