<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="com.test.model.UserBean"%>
    <%String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	UserBean user = (UserBean)request.getSession().getAttribute("userinfo");
	if(user==null){
		user = new UserBean();
	}
	%>
	<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
	<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="<%=basePath %>js/jquery.js"></script>
<script src="<%=basePath %>js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/layer.js"></script>
<script type="text/javascript" src="<%=basePath%>js/layer.ext.js"></script>
<link href="<%=basePath %>css/FontAwesome/css/font-awesome.min.css" rel="stylesheet">
<link href="<%=basePath %>css/FontAwesome/css/font-awesome-ie7.min.css" rel="stylesheet">
<link href="<%=basePath %>css/bootstrap.min.css" rel="stylesheet">
<link href="<%=basePath %>css/common.css" rel="stylesheet"/>
<link href="<%=basePath %>css/reset.css" rel="stylesheet"/>
<script type="text/javascript">
var system ={
	win : false,
	mac : false,
	xll : false
};

//检测平台
<%-- var p = navigator.platform;
system.win = p.indexOf("Win") == 0;
system.mac = p.indexOf("Mac") == 0;
system.x11 = (p == "X11") || (p.indexOf("Linux") == 0);
//跳转语句
if(system.win||system.mac||system.xll){
	alert(1);
	var fileref = document.createElement('script');
	fileref.setAttribute("type","text/javascript");
	fileref.setAttribute("src","<%=basePath%>js/layer.js");
}else{
	alert(2);
	var fileref = document.createElement('script');
	fileref.setAttribute("type","text/javascript");
	fileref.setAttribute("src","<%=basePath%>js/layer-mobile.js");
} --%>



var dengluId = "<%=user.getId()%>"
String.prototype.endWith=function(s){
	  if(s==null||s==""||this.length==0||s.length>this.length)
	     return false;
	  if(this.substring(this.length-s.length)==s)
	     return true;
	  else
	     return false;
	  return true;
	 }
$(function(){
	var hNav = $('.nav');
	if(hNav){
		var uri = location.href;
		if(uri!=""){
			var nav = hNav.find("li a");
			for(var i =0;i<nav.length;i++){
				var nowUri= nav[i].href.toString();
				if(nowUri.endWith(uri)){
					nav[i].parentNode.className="active";
					$('.nav').find(nav[i]).parent().parent().parent("li").addClass("active");
				}	
			}
		}
	}
})

function checkLogin(){
	<%-- if(dengluId==""){
		window.location.href="<%=basePath%>/login.jsp";
	} --%>
	if(dengluId=="" || dengluId=="null"){
		layer.open({
	        type: 2,
	        //skin: 'layui-layer-lan',
	        title: '请登录',
	        fix: false,
	        shadeClose: true,
	        maxmin: false,
	        area: ['350px','200px'],
	        content: '<%=basePath%>guest/login.jsp',
	        success:function(layero, index){
	        	/* layer.iframeAuto(index); */
	        },
	        end: function(){
	        	
	            /* layer.tips('试试相册模块？', '#photosDemo', {tips: 1}) */
	        }
	    });
		<%-- layer.open({
		    type: 1,
		    content:'<%=basePath%>guest/login.jsp',
		    style: 'position:fixed; left:0; top:0; width:100%; height:100%; border:none;'
		}); --%>
		return false;
	}else{
		return true;
	}
}
</script>
</head>
<body>

</body>
</html>