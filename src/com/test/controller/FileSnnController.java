package com.test.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value="file.do")
public class FileSnnController {
	
	/*@Resource(name="fileBeanDao")
	private FileBeanDao fileBeanDao;
	
	@RequestMapping(value="upload.do",method=RequestMethod.POST)
	public String onSubmit(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		CommonsMultipartFile file = (CommonsMultipartFile) multipartRequest.getFile("filename");
		String name = multipartRequest.getParameter("filename");
		System.out.println("name:"+name);
		String realFilename = file.getOriginalFilename();
		System.out.println("获取文件名:"+realFilename);
		String ctxPath = request.getSession().getServletContext().getRealPath("/")+"download/";
		System.out.println(ctxPath);
		File dirpath = new File(ctxPath);
		if(!dirpath.exists()){
			dirpath.mkdir();
		}
		String s = String.format("aaa %d", "a");
		File uploadFile = new File(ctxPath+realFilename);
		FileCopyUtils.copy(file.getBytes(),uploadFile);
		request.setAttribute("fx", "上传成功");
		return "views/upload";
	}
	
	@RequestMapping(value="list.do",method=RequestMethod.POST)
	public @ResponseBody String loadFiles(HttpServletRequest request){
		List<FileBean> files = new ArrayList<FileBean>();
		String ctxpath = request.getSession().getServletContext().getRealPath("/")+"\\"+"download\\";
		File file = new File(ctxpath);
		if(file.exists()){
			File[] fs = file.listFiles();
			for(File f : fs){
				FileBean filebean = new FileBean();
				filebean.setFilename(f.getName());
				filebean.setSize(FormetFileSize(f.length()));
				if(f.isFile()){
					files.add(filebean);
				}
			}
		}
		Gson gs = new Gson();
		String listJson = gs.toJson(files);
		return listJson;
	}
	
	
	@RequestMapping(value="download.do")
	public void download(String fileName, HttpServletRequest request,
			HttpServletResponse response) {
		response.setCharacterEncoding("utf-8");
		response.setContentType("multipart/form-data");
		response.setHeader("Content-Disposition", "attachment;fileName="
				+ fileName);
		try {
			String path =  request.getSession().getServletContext().getRealPath("/")+"download/";
			InputStream inputStream = new FileInputStream(new File(path
					+ File.separator + fileName));
			OutputStream os = response.getOutputStream();
			byte[] b = new byte[2048];
			int length;
			while ((length = inputStream.read(b)) > 0) {
				os.write(b, 0, length);
			}
			os.close();
			inputStream.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public String FormetFileSize(long fileS) {// 转换文件大小
		DecimalFormat df = new DecimalFormat("#");
		String fileSizeString = "";
		if (fileS < 1024) {
			fileSizeString = df.format((double) fileS) + "B";
		} else if (fileS < 1048576) {
			fileSizeString = df.format((double) fileS / 1024) + "K";
		} else if (fileS < 1073741824) {
			fileSizeString = df.format((double) fileS / 1048576) + "M";
		} else {
			fileSizeString = df.format((double) fileS / 1073741824) + "G";
		}
		return fileSizeString;
	}
	
	@RequestMapping(value="onload.do",method=RequestMethod.POST)
	public String onload(HttpServletRequest request,
			HttpServletResponse response) throws Exception{
		FileBean filebean = new  FileBean();
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		CommonsMultipartFile file = (CommonsMultipartFile) multipartRequest.getFile("filename");
		String realFilename = file.getOriginalFilename();
		System.out.println("获取文件名:"+realFilename);
		byte[] bb = file.getBytes();
		System.out.println();
		filebean.setContent(bb);
		filebean.setFilename(realFilename);
		filebean.setSize(FormetFileSize(bb.length));
		fileBeanDao.insertEntity(filebean); 
		FileBean fb = fileBeanDao.findEntityById(filebean.getId());
		request.setAttribute("fb", fb);
		request.setAttribute("fx", "上传成功");
		return "views/upload";
	}
	
	@RequestMapping(value="listOne.do",method=RequestMethod.POST)
	public @ResponseBody String listFile(HttpServletRequest request) throws Exception{
		FileBean fb = fileBeanDao.findEntityById(2);
		fb.setCon(new String(fb.getContent()));
		System.out.println(fb.getCon());
		List<FileBean> list = new ArrayList<FileBean>();
		list.add(fb);
		Gson gs = new Gson();
		String listJson = gs.toJson(list);
		return listJson;
	}
	
	@RequestMapping(value="listall.do",method=RequestMethod.POST)
	public @ResponseBody String listallFile(HttpServletRequest request) throws Exception{
		Map<String,Object> map = new HashMap<String,Object>();
		List<FileBean> list = fileBeanDao.findEntity(map);
		for(FileBean f:list){
			if(f.getFilename().endsWith(".txt")){				
				f.setCon(new String(f.getContent()));
			}
		}
		Gson gs = new Gson();
		String listJson = gs.toJson(list);
		return listJson;
	}
	
	@RequestMapping(value="dlFile.do")
	public void dlFile(int id,String fileName, HttpServletRequest request,
			HttpServletResponse response) {
		response.setCharacterEncoding("utf-8");
		response.setContentType("multipart/form-data");
		response.setHeader("Content-Disposition", "attachment;fileName="
				+ fileName);
		try {
			FileBean filebean = fileBeanDao.findEntityById(id);
			OutputStream os = response.getOutputStream();
			os.write(filebean.getContent());
			os.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}*/
}
