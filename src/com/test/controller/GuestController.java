package com.test.controller;

import java.io.PrintWriter;
import java.util.ArrayList;
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
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.test.dao.PictureDao;
import com.test.dao.PinglunDao;
import com.test.dao.TextDao;
import com.test.dao.UserDao;
import com.test.model.Picture;
import com.test.model.Pinglun;
import com.test.model.Text;
import com.test.model.UserBean;
@Controller
@RequestMapping(value="guest.do")
public class GuestController extends BaseController{

	@Resource(name="textDao")
	private TextDao textDao;
	
	@Resource(name="pinglunDao")
	private PinglunDao pinglunDao;
	
	@Resource(name="userDao")
	private UserDao userDao;
	
	@Resource(name="pictureDao")
	private PictureDao pictureDao;
	
	@RequestMapping(value="selectShow.do")
	public void selectShow(PrintWriter out){
		List<Text> list = textDao.findEntity(1);
		ajaxSend(out, list);
	}
	
	@RequestMapping(value="selectShowVisitMost.do")
	public void selectShowVisitMost(PrintWriter out){
		List<Text> list = textDao.findEntityMost(1);
		ajaxSend(out, list);
	}
	
	@RequestMapping(value="selectOneText.do")
	public void selectOneText(int id,PrintWriter printWriter,HttpSession session){
		Text text = textDao.findEntityById(id);
		UserBean user = (UserBean)session.getAttribute("userinfo");
		if(user==null || text.getUserId()!=user.getId()){
			int viTimes = Integer.parseInt(text.getVisitTimes())+1;
			text.setVisitTimes(String.valueOf(viTimes));
			textDao.updateEntityById(text);
		}
		ajaxSend(printWriter, text);
	}
	
	@RequestMapping(value="selectPinglunByTextId.do")
	public void selectPinglunByTextId(int id,PrintWriter printWriter){
		List<Pinglun> list = pinglunDao.findPinglunByTextId(id);
		ajaxSend(printWriter,list);
	}
	
	@RequestMapping(value="selectPinglunByNO.do")
	public void selectPinglunByNO(int id,PrintWriter printWriter){
		List<Pinglun> list = pinglunDao.findPinglunByNO(id);
		ajaxSend(printWriter,list);
	}
	
	
	@RequestMapping(value="login.do",method=RequestMethod.POST)
	public void login(UserBean user,HttpSession session,PrintWriter printWriter){
        Subject currentUser = SecurityUtils.getSubject();  
        UsernamePasswordToken token = new UsernamePasswordToken(  
                user.getLoginName(), user.getPasswd());  
        token.setRememberMe(true);  
        try {  
            currentUser.login(token);  
        } catch (AuthenticationException e) {
        	ajaxSend(printWriter, "1");
        }
        if(currentUser.isAuthenticated()){  
        	UserBean u = userDao.login(user).get(0);
            session.setAttribute("userinfo", u);  
            ajaxSend(printWriter, "2");
        }else{  
        	ajaxSend(printWriter, "1");
        }  
	}
	
	@RequestMapping(value="showUser.do")
	public String showUser(int userId,Model model){
		UserBean user = userDao.findEntityById(userId);
		model.addAttribute("user", user);
		return "guest/userIndex";
	}
	
	@RequestMapping(value="selectTextByUser.do")
	public void selectTextByUser(int UserId,int page,PrintWriter printWriter){
		Map map = new HashMap();
		map.put("UserId",UserId);
		map.put("page",(page-1)*num);
		map.put("num", num);
		List<Text> list = textDao.selectTextByUserId(map);
		ajaxSend(printWriter, list);
	}
	
	@RequestMapping(value="selectCountByUser.do")
	public void selectCountByUser(int UserId,PrintWriter printWriter){
		int count = textDao.selectCountByUserId(UserId);
		int pagenum = getPageNum(count);
		ajaxSend(printWriter, pagenum);
	}
	
	@RequestMapping(value="selectUserVisitMost.do")
	public void selectUserVisitMost(PrintWriter printWriter){
		List<UserBean> list = userDao.selectUserMost();
		ajaxSend(printWriter, list);
	}
	
	@RequestMapping(value="selectPicture.do")
	public void selectPicture(PrintWriter printWriter){
		List<Picture> list = pictureDao.findEntity(null);
		ajaxSend(printWriter, list);
	}
	
	
	@RequestMapping(value="selectLoginName.do")
	public void selectLoginName(String name,PrintWriter printWriter){
		UserBean user = userDao.findUserByName(name);
		if(user!=null){
			ajaxSend(printWriter, 1);
		}else{
			ajaxSend(printWriter, 0);
		}
	}
	
	
	@RequestMapping(value="insertUser.do")
	public String insertUser(UserBean user,Model model){
		int count = userDao.insertEntity(user);
		if(count==1){
			model.addAttribute("status", count);
			return "login";
		}else{
			model.addAttribute("status", count);
			return "guest/user";
		}
		
	}
	
	@RequestMapping(value="visitUser.do")
	public String visitUser(int id,Model model,HttpSession session){
		UserBean user1 = userDao.findEntityById(id);
		UserBean user = (UserBean)session.getAttribute("userinfo");
		if(user==null || user1.getId()!=user.getId()){
			int viTimes = Integer.parseInt(user1.getVisitTimes())+1;
			user1.setVisitTimes(String.valueOf(viTimes));
			userDao.updateUserById(user1);
		}
		model.addAttribute("user", user1);
		return "guest/userIndex";
	}
	
	@RequestMapping(value="selectTiWenNew.do")
	public void selectTiWenNew(PrintWriter printWriter){
		List<Text> list = textDao.findEntity(2);
		ajaxSend(printWriter, list);
	}
	
	@RequestMapping(value="selectTiWenByUser.do")
	public void selectTiWenByUser(int UserId,PrintWriter printWriter){
		Map map = new HashMap();
		map.put("UserId",UserId);
		List<Text> list = textDao.selectTiWenByUserId(map);
		ajaxSend(printWriter, list);
	}
	
	@RequestMapping(value="toShowTiWen.do")
	public ModelAndView  toShowTiWen(int id,RedirectAttributes attr){
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("id", id);
		return new ModelAndView("redirect:/guest/showTiWen.jsp",map);
	}
	
	@RequestMapping(value="toMore.do")
	public String  toMore(int type,Model model){
		model.addAttribute("type", type);
		return "guest/toMore";
	}
	
	
	@RequestMapping(value="selectThingByType.do")
	public void selectThingByType(String type,int page,PrintWriter printWriter){
		Map map = new HashMap();
		map.put("page",(page-1)*num);
		map.put("num", num);
		List<Text> list = new ArrayList<Text>();
		if("1".equals(type)){
			map.put("type",1);
			list = textDao.selectThingByType(map);
		}else if("2".equals(type)){
			map.put("type",1);
			list = textDao.selectThingByType2(map);
		}else if("3".equals(type)){
			map.put("type",2);
			list = textDao.selectThingByType(map);
		}
		ajaxSend(printWriter, list);
	}
	
	
	@RequestMapping(value="selectCountByType.do")
	public void selectCountByType(String type,PrintWriter printWriter){
		int count=0;
		if("1".equals(type)){
			count = textDao.selectCountByType(1);
		}else if("2".equals(type)){
			count = textDao.selectCountByType(2);
		}else if("3".equals(type)){
			count = textDao.selectCountByType(4);
		}
		int pagenum = getPageNum(count);
		ajaxSend(printWriter, pagenum);
	}
}