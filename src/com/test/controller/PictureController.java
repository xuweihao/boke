package com.test.controller;

import java.io.PrintWriter;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.test.dao.PictureDao;
import com.test.model.Picture;

@Controller
@RequestMapping(value="picture.do")
public class PictureController extends BaseController{

	@Resource(name="pictureDao")
	private PictureDao pictureDao;
	
	public void selectPicture(PrintWriter printWriter){
		List<Picture> list = pictureDao.findEntity(null);
		ajaxSend(printWriter, list);
	}
}
