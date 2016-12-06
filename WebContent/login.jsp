<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../page/common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="<%=basePath %>js/jquery.js"></script>
<style type="text/css">
body {
	background-color:#fff;
}
.loginDiv {
	padding:20px 20px;
	background-color:#5bc0de;
	border-radius:20px;
}
ul,li{  
	list-style:none;  
}
ul li a{  
	text-decoration:none;  /* 定义是否有下划线 */
	font-weight: bold;
	color:#000  ;  
	background:#ffc;  
	display:block;  
	height:10em;  
	width:10em;
	text-align:center;
	-moz-box-shadow: 5px 5px 7px rgba(33,33,33,1)  ; /* firefox */  
	-webkit-box-shadow: 5px 5px 7px rgba(33,33,33,.7)  ; /* Safari and Chrome */
	box-shadow: 5px 5px 7px rgba(33,33,33,.7)  ;  
}
ul li a h1 {
	font-size:8em;
	font-weight: bold;
}
ul li{  
	float:left;  
}
ul li a{  
	-webkit-transform:rotate(-6deg);  /* 旋转 */
	-o-transform:rotate(-6deg); /* Opera */
	-moz-transform:rotate(-6deg); 
}
ul li:nth-child(even) a{  
	-webkit-transform:rotate(6deg);  /* 旋转 */
	-o-transform:rotate(6deg); /* Opera */
	-moz-transform:rotate(6deg); 
}
ul li a:hover{
	text-decoration:none;
	color:#000  ;
	-moz-transform: rotate(360deg);
	-webkit-transform: rotate(360deg);/* -- 2D旋转360°与放大有影响会没有效果  有待研究 */
	-o-transform: rotate(360deg);
	transform: rotate(360deg);
	
	-moz-transition: -moz-transform 0.8s ease-in-out; 
	-webkit-transition: -webkit-transform 0.8s ease-in-out; 
	-o-transition: -o-transform 0.8s ease-in-out; 
	transition: transform 0.8s ease-in-out; 
	position:relative;  
	z-index:5;  
}
</style>
<script type="text/javascript">
var status = "${status}";
$(function(){
	if(status=="1"){
		alert("注册成功请登录");
	}
})

function checkBefore(){
	if($('#loginName').val()==""){
		alert("用户名不能为空");
		return false;
	}else if ($('#passwd').val()=="") {
		alert("密码不能为空");
		return false;
	}else{
		return true;
	}
}
</script>
</head>
<body>
<div class="container">
	<div class="row" style="padding-top: 50px;">
		<div class="pull-right"><a href="<%=basePath%>guest/index.jsp">前往首页</a></div>
		<hr/>
	</div>
	<div class="row" style="padding-top: 50px;">
		<div class="col-md-8">
			<ul>  
				<li><a href="javascript:void(0)"><h1>个</h1></a></li>
				<li><a href="javascript:void(0)"><h1>人</h1></a></li> 
				<li><a href="javascript:void(0)"><h1>博</h1></a></li> 
				<li><a href="javascript:void(0)"><h1>客</h1></a></li> 
			</ul>  
		</div>
		<div class="col-md-4">
			<div class="loginDiv">
				<form class="form-horizontal" action="<%=basePath%>user.do/login.do" method="post" onsubmit="return checkBefore()">
					<div class="form-group">
					    <label for="loginName" class="col-sm-3 control-label">用户名</label>
					    <div class="col-sm-7">
					    	<input type="text" class="form-control" name="loginName" id="loginName" placeholder="YourName">
					    </div>
					</div>
					<div class="form-group">
					    <label for="passwd" class="col-sm-3 control-label">密码</label>
					    <div class="col-sm-7">
					    	<input type="password" class="form-control" name="passwd" id="passwd">
					    </div>
					</div>
					<div class="form-group">
					    <div class="col-sm-offset-2 col-sm-10">
					    	<button type="submit" style="width:100px;" class="btn btn-primary">登陆</button>
					    	<button type="button" style="width:100px;" class="btn btn-primary" onclick="window.location.href='<%=basePath%>guest/user.jsp'">注册</button>
					    </div>
					</div>
				</form>
			</div>
		</div>
	</div>
	<div class="row" style="padding-top: 50px;">
		<hr/>
	</div>
</div>
</body>
</html>