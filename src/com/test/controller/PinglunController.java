package com.test.controller;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.test.dao.PinglunDao;
import com.test.model.Pinglun;
import com.test.model.UserBean;
@Controller
@RequestMapping(value="pinglun.do")
public class PinglunController extends BaseController{

	@Resource(name="pinglunDao")
	private PinglunDao pinglunDao;
	
	@RequestMapping(value="insertPinglun.do")
	public void insertPinglun(Pinglun pl,PrintWriter printWriter,HttpSession session){
		UserBean user = (UserBean)session.getAttribute("userinfo");
		pl.setUserId(user.getId());
		pl.setUserName(user.getLoginName());
		int count = pinglunDao.insertEntity(pl);
		ajaxSend(printWriter,count);
	}
	
	@RequestMapping(value="insertHuifu.do")
	public void insertHuifu(Pinglun pl,PrintWriter printWriter,HttpSession session){
		UserBean user = (UserBean)session.getAttribute("userinfo");
		pl.setUserId(user.getId());
		pl.setUserName(user.getLoginName());
		int count = pinglunDao.insertHuifu(pl);
		ajaxSend(printWriter,count);
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
	
	@RequestMapping(value="selectPinglunByPinglunId.do")
	public void selectPinglunByPinglunId(int id,PrintWriter printWriter){
		List<Pinglun> list = pinglunDao.findPinglunByNO(id);
		ajaxSend(printWriter,list);
	}
	
	@RequestMapping(value="delPinglunById.do")
	public void delPinglunById(int id,PrintWriter printWriter){
		int count = pinglunDao.deleteEntityById(id);
		ajaxSend(printWriter,count);
	}
	
	
	
	@RequestMapping(value="selectPLByUser.do")
	public void selectPLByUser(int page,PrintWriter printWriter,HttpSession session){
		UserBean user = (UserBean)session.getAttribute("userinfo");
		Map map = new HashMap();
		map.put("page",(page-1)*num);
		map.put("num", num);
		map.put("userId", user.getId());
		List<Pinglun> list = pinglunDao.findPinglunByUser(map);
		ajaxSend(printWriter,list);
	}
	
	@RequestMapping(value="selectPLCountByUser.do")
	public void selectPLCountByUser(PrintWriter printWriter,HttpSession session){
		UserBean user = (UserBean)session.getAttribute("userinfo");
		int count = pinglunDao.selectPLCountByUser(user.getId());
		int pagenum = getPageNum(count);
		ajaxSend(printWriter,pagenum);
	}
	
}
