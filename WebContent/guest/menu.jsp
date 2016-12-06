<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<ul class="nav nav-pills text-center h-menu">
	  <li>
	    <a href="<%=basePath%>guest/index.jsp">首页</a>
	  </li>
	  <li>
	    <a href="<%=basePath%>page/newIndex.jsp">我的博客</a>
	  </li>
	  <li class="dropdown">
	  	<a class="dropdown-toggle" data-toggle="dropdown" href="#">发表内容<span class="caret"></span></a>
	  	<ul class="dropdown-menu">
  			<li><a href="<%=basePath%>text.do/toInsertText.do">分享</a></li>
	  		<li><a href="<%=basePath%>text.do/toInsertTiWen.do">提问</a></li>
	  	</ul>
	  </li>
	  <shiro:hasRole name="admin">
	  <li>
	  	<a href="javascript:void(0)">AdminManage</a>
	  </li>
	  </shiro:hasRole>
	  <c:if test="${sessionScope.userinfo!=null}">
	  	<li><a href="<%=basePath%>page/toNews.jsp">查看最新动态</a></li>
	  </c:if>
	  <c:if test="${sessionScope.userinfo!=null}">
	  	<li><a href="<%=basePath%>user.do/logout.do">logout</a></li>
	  </c:if>
	</ul>
</body>
</html>