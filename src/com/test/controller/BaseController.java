package com.test.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.test.model.UserBean;

public class BaseController {

	public final int num=10;
	
	public void ajaxSend(PrintWriter printWriter,Object o){
		Gson gs = new Gson();
		String json = gs.toJson(o);
		printWriter.write(json);
        printWriter.flush(); 
        printWriter.close();
	}
	
	public UserBean getSessionUser(HttpSession session){
		UserBean user =(UserBean)session.getAttribute("userinfo");
		
		return user;
	}
	
	public int getPageNum(int count){
		int pagenum = count/num;
		if(count%num>0 || pagenum==0){
			pagenum++;
		}
		return pagenum;
	}
}
