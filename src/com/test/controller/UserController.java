package com.test.controller;

import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.test.dao.UserDao;
import com.test.model.UserBean;

@Controller
@RequestMapping(value="user.do")
public class UserController extends BaseController{

	@Resource(name="userDao")
	private UserDao userDao;
	
	
	@RequestMapping(value="tologin.do",method=RequestMethod.GET)
	public String tologin(){
		return "login"; 
	}
	
	
	@RequestMapping(value="login.do",method=RequestMethod.POST)
	public String login(UserBean user,HttpSession session,Model model){
        Subject currentUser = SecurityUtils.getSubject();  
        UsernamePasswordToken token = new UsernamePasswordToken(  
                user.getLoginName(), user.getPasswd());  
        token.setRememberMe(true);  
        try {  
            currentUser.login(token);  
        } catch (AuthenticationException e) {
        	model.addAttribute("status", 1);
         	return "error/error";
        }
        if(currentUser.isAuthenticated()){  
        	UserBean u = userDao.login(user).get(0);
            session.setAttribute("userinfo", u);  
            return "redirect:/page/newIndex.jsp";
        }else{  
        	return "login";
        }  
		
	}
	
	
	@RequestMapping(value="logout.do",method=RequestMethod.GET)
	public String logout(HttpSession session){
		UserBean user = (UserBean) session.getAttribute("userinfo");  
        Subject currentUser = SecurityUtils.getSubject();  
        UsernamePasswordToken token = new UsernamePasswordToken(  
                user.getLoginName(), user.getPasswd());  
        token.setRememberMe(true);   
        currentUser.logout();  
//        session.removeAttribute("userinfo"); 
        return "redirect:/login.jsp";
		
	}
	
	@RequestMapping(value="toUpdate.do",method=RequestMethod.GET)
	public String toUpdate(HttpSession session,Model model){
		UserBean user = (UserBean) session.getAttribute("userinfo");
		model.addAttribute("user", user);
		return "page/user";
	}
	
	
	@RequestMapping(value="update.do",method=RequestMethod.POST)
	public String update(UserBean user,Model model){
		int count = userDao.updateEntityById(user);
		if(count==1){
			model.addAttribute("status", count);
			return "login";
		}else{
			model.addAttribute("user", user);
			model.addAttribute("status", count);
			return "page/user";
		}
	}
	
	@SuppressWarnings("deprecation")
	@RequestMapping(value="selectHY.do")
	public void selectHY(Integer year,HttpSession session,PrintWriter printWriter) throws ParseException{
		UserBean user = (UserBean) session.getAttribute("userinfo");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
		Date date = sdf.parse(user.getCreateTime());
		Date now = new Date();
		int i=1;
		//判断是否是第一次查询，第一次查询 查询蛋生年
		if(year==null || year==0){
			year = date.getYear()+1900;
			i = date.getMonth()+1;
		}
		List list = new ArrayList();
		if(i>1){
			for(int n = 1;n<i;n++){
				list.add(null);
			}
		}
		int month=13;
		if(year == (now.getYear()+1900)){
			month=now.getMonth()+2;
		}
		for(;i<month;i++){
			String time ="";
			if(i<10){
				time= year+"-0"+i;
			}else{
				time= year+"-"+i;;
			}
			Integer count = userDao.selectHYbyDate(time,user.getId());
			list.add(count);
		}
		if(month<13){
			for(int n = 1;n<(13-month);n++){
				list.add(null);
			}
		}
		Map map = new HashMap();
		map.put("year", year);
		map.put("month", date.getMonth()+1);
		map.put("list", list);
		ajaxSend(printWriter, map);
	}
}
