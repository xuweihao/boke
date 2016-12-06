<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<%@include file="../page/common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="<%=basePath %>js/editor.js"></script>
<link href="<%=basePath %>css/editor.css" type="text/css" rel="stylesheet"/>
<style type="text/css">
.Editor-editor {
	background-color: #fff;
}

</style>
<script type="text/javascript">
var BASEPATH = '<%=basePath%>';
$(document).ready( function(){
	$("#txtEditor").Editor();
	$("#txtEditor").Editor("setText",'${text.text}');
});
function submitForm(){
	var text = $("#txtEditor").Editor("getText");
	var title = $("#title").val();
	var id = $("#id").val();
	if(title==""){
		alert("标题不能为空");
		return false;
	}else{
		$.ajax({
			url:'<%=basePath%>text.do/updateText.do',
			type:'post',
			data:{title:title,text:text,id:id},
			dataType:'json',
			success:function(data){
				alert('保存成功');
				window.location.href="<%=basePath%>text.do/toShow.do?id="+data;
			}
		})
	}
	
}
</script>
</head>
<body>
	<div class="cn-header container" >
		<div class="h-logo col-md-5">
			<ul>  
				<li><a href="javascript:void(0)"><h1>个</h1></a></li>
				<li><a href="javascript:void(0)"><h1>人</h1></a></li> 
				<li><a href="javascript:void(0)"><h1>博</h1></a></li> 
				<li><a href="javascript:void(0)"><h1>客</h1></a></li> 
			</ul>
		</div>
		<div class="col-md-7">
			<%@include file="../guest/menu.jsp" %>
		</div>
	</div>
	<div class="cn-body container" >
		<div style="margin-top:40px;">
			<h2 class="demo-text">LineControl Demo</h2>
			<div class="text-center">
			    <label class="control-label" for="title" style="width: 80px;">Title</label>
			    <input type="text" id="title" placeholder="Title" value="${text.title }">
			    <input type="hidden" id="id" value="${text.id }">
			</div>
			<div>
		    	<textarea id="txtEditor"></textarea> 
		    </div>
			<div style="width:100%;margin:20px 0 50px;text-align: center;">
				<input type="button" class="btn btn-success" onclick="submitForm()" value="提交">
				<input type="button" class="btn btn-danger" onclick="javascript:history.go(-1);" value="取消">
			</div> 
		</div>
	</div>
	<div class="cn-footer container">
	</div>
</body>
</html>