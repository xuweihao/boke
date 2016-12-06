package com.test.controller;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.authz.annotation.RequiresRoles;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.test.dao.DianZanDao;
import com.test.dao.TextDao;
import com.test.model.Text;
import com.test.model.UserBean;

@Controller
@RequestMapping(value="text.do")
public class TextController extends BaseController{
//	value={"user1","admin"},logical=Logical.OR
	@Resource(name="textDao")
	private TextDao textDao;
	
	@Resource(name="dianZanDao")
	private DianZanDao dianZanDao;
	
	@RequestMapping(value="toInsertText.do")
	/*@RequiresPermissions(value="toInsert")*/
	@RequiresRoles(value="user1")
	public String toInsertText(){
		return "page/insert";
	}
	
	@RequestMapping(value="toInsertTiWen.do")
	/*@RequiresPermissions(value="toInsert")*/
	@RequiresRoles(value="user1")
	public String toInsertTiWen(){
		return "page/insertTiWen";
	}
	
	@RequestMapping(value="toUpdateText.do")
	@RequiresRoles(value="user1")
	public String toUpdateText(int id,Model model){
		Text text = textDao.findEntityById(id);
		model.addAttribute("text", text);
		return "page/update";
	}
	
	
	@RequestMapping(value="toShow.do")
	public ModelAndView  toShow(int id,RedirectAttributes attr){
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("id", id);
		return new ModelAndView("redirect:/page/show.jsp",map);
	}
	
	
	@RequestMapping(value="toShowTiWen.do")
	public ModelAndView  toShowTiWen(int id,RedirectAttributes attr){
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("id", id);
		return new ModelAndView("redirect:/page/showTiWen.jsp",map);
	}
	
	
	@RequestMapping(value="selectOneText.do")
	public void selectOneText(int id,PrintWriter printWriter,HttpSession session){
		Text text = textDao.findEntityById(id);
		UserBean user = (UserBean)session.getAttribute("userinfo");
		if(text.getUserId()!=user.getId()){
			int viTimes = Integer.parseInt(text.getVisitTimes())+1;
			text.setVisitTimes(String.valueOf(viTimes));
			textDao.updateEntityById(text);
		}
		Map map = new HashMap();
		map.put("userId", user.getId());
		map.put("textId", text.getId());
		String result = dianZanDao.selectDianZan(map);
		text.setDianzan(Integer.parseInt(result==null?"0":result));
		ajaxSend(printWriter, text);
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
	
	@RequestMapping(value="insertText.do")
	public void insertText(String title,String text,int type,PrintWriter printWriter,HttpSession session){
		Text t = new Text();
		t.setText(text);
		t.setTitle(title);
		t.setType(type);
		t.setUserId(getSessionUser(session).getId());
		int count = textDao.insertEntity(t);
		ajaxSend(printWriter, t.getId());
	}
	
	
	@RequestMapping(value="updateText.do")
	public void updateText(String title,String text,int id,PrintWriter printWriter,HttpSession session){
		Text t = new Text();
		t.setText(text);
		t.setTitle(title);
		t.setId(id);
		t.setUserId(getSessionUser(session).getId());
		int count = textDao.updateEntityById(t);
		ajaxSend(printWriter, t.getId());
	}
	
	@RequestMapping(value="delText.do")
	public void delText(int textId,PrintWriter printWriter,HttpSession session){
		int count = textDao.deleteEntityById(textId);
		ajaxSend(printWriter, count);
	}
	
	
	@RequestMapping(value="insertTiWen.do")
	public void insertTiWen(String title,String text,int type,String fileUrl,PrintWriter printWriter,HttpSession session){
		Text t = new Text();
		t.setText(text);
		t.setTitle(title);
		t.setType(type);
		t.setFileUrl(fileUrl);
		t.setUserId(getSessionUser(session).getId());
		int count = textDao.insertEntity(t);
		ajaxSend(printWriter, t.getId());
	}
	
	
	@RequestMapping(value="selectTiWenByUser.do")
	public void selectTiWenByUser(int UserId,PrintWriter printWriter){
		Map map = new HashMap();
		map.put("UserId",UserId);
		List<Text> list = textDao.selectTiWenByUserId(map);
		ajaxSend(printWriter, list);
	}
	
	
	
}
