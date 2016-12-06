<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../page/common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
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
function login(){
	if(checkBefore()){
		var lName = $('#loginName').val();
		var pass = $('#passwd').val();
		$.ajax({
			url:'<%=basePath%>guest.do/login.do',
			type:'post',
			data:{loginName:lName,passwd:pass},
			dataType:'json',
			success:function(data){
				if(data==1){
					alert('用户名或密码不正确，请重新输入');
					$('#passwd').val('');
				}else{
					alert('登录成功');
					window.parent.location.reload();
					var index = window.parent.layer.getFrameIndex(window.name);
					window.parent.layer.close(index);
				}
			}
		})
	}
	
}
</script>
</head>
<body>
<div class="container" style="padding-top:10px;">
	<form class="form-horizontal">
		<div class="form-group">
		    <label for="loginName" class="col-xs-3 control-label">用户名:</label>
		    <div class="col-xs-9">
		     	 <input type="text" class="form-control" id="loginName" placeholder="用户名">
		    </div>
		</div>
		<div class="form-group">
		    <label for="passwd" class="col-xs-3 control-label">密码:</label>
		    <div class="col-xs-9">
		     	 <input type="password" class="form-control" id="passwd">
		    </div>
		</div>
		<div class="form-group">
		    <div class="col-xs-offset-3 col-xs-9">
		     	 <button type="button" class="btn btn-default" onclick="login()">登录</button>
		    </div>
		</div>
	</form>
</div>
</body>
</html>