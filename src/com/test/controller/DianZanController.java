package com.test.controller;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.test.dao.DianZanDao;
import com.test.model.DianZan;
@Controller
@RequestMapping(value="dianzan.do")
public class DianZanController extends BaseController{
	
	@Resource(name="dianZanDao")
	private DianZanDao dianZanDao;
	
	@RequestMapping(value="InsertDianZan.do")
	public void InsertDianZan(DianZan dz,PrintWriter printWriter){
		List<DianZan> list = dianZanDao.findEntity(dz);
		if(list.isEmpty()){
			dianZanDao.insertEntity(dz);
		}else{
			dianZanDao.updateEntityById(list.get(0));
		}
		Map map = new HashMap();
		map.put("userId", dz.getUserId());
		map.put("textId", dz.getTextId());
		String result = dianZanDao.selectDianZan(map);
		ajaxSend(printWriter, result);
	}
}
