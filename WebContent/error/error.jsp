<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String UserName = (String)request.getSession().getAttribute("UserName");
	%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="<%=basePath %>js/jquery.js"></script>
<script type="text/javascript">
var status = "${status}";
$(function(){
	if(status==1){
		alert("用户名或密码错误,请重新登录");
		window.location.href="<%=basePath%>user.do/tologin.do";
	}
})
</script>
</head>
<body>

</body>
</html>