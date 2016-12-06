package com.test.controller;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.test.util.UUIDUtil;
@Controller
@RequestMapping(value="file.do")
public class FileController extends BaseController{

	@RequestMapping(value="upload.do",method=RequestMethod.POST)
	public void uploadFile(String img,String fileName,HttpServletRequest request,PrintWriter printWriter) throws Exception{
		System.out.println("获取文件名:"+fileName);
		String ctxPath = request.getSession().getServletContext().getRealPath("/")+"download/";
		System.out.println(ctxPath);
		File dirpath = new File(ctxPath);
		if(!dirpath.exists()){
			dirpath.mkdir();
		}
		String type = fileName.substring(fileName.lastIndexOf(".")+1);
		fileName = "tup"+UUIDUtil.getUUID()+"."+type;
		File uploadFile = new File(ctxPath+fileName);
		InputStream ins = new ByteArrayInputStream(img.getBytes("ISO-8859-1"));
		OutputStream os = new FileOutputStream(uploadFile);
		try{
			int bytesRead = 0;
			byte[] buffer = new byte[8192];
			while ((bytesRead = ins.read(buffer, 0, 8192)) != -1) {
				os.write(buffer, 0, bytesRead);
			}
			os.flush();
		}catch(Exception e){
			fileName="1";
		}finally{
			ins.close();
			os.close();
			ajaxSend(printWriter,fileName);
		}
		
	}
}
