<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../page/common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
var status = "${status}";
$(function(){
	if(status=="0"){
		alert("更新失败,请重新更新")
	}
})
function selectPicture(){
	layer.open({
        type: 2,
        //skin: 'layui-layer-lan',
        title: '选择头像',
        name:'aa',
        fix: false,
        shadeClose: false,
        maxmin: false,
        area: ['550px','450px'],
        content: '<%=basePath%>guest/picture.jsp',
        success:function(layero, index){

        },
        end: function(){
        	
            /* layer.tips('试试相册模块？', '#photosDemo', {tips: 1}) */
        }
    });
}

function checkForm(){
	if($("#checkMessage").css('display')!="none"){
		$("#loginName").focus();
		return false;
	}
	var tel = $("#telephone").val();
	var group = ["loginName","name","password","email","telephone"];
	var value;
	for(var i =0 ; i<group.length;i++){
		value = $("#"+group[i]).val();
		if(value==""){
			alert('请检查带 * 必填项！');
			$("#"+group[i]).parent().addClass("has-error");
	        $("#"+group[i]).focus();
	        return false;
		}else{
			$("#"+group[i]).parent().removeClass("has-error").addClass("has-success");
		}
	}
 	var myreg = /^(((13[0-9]{1})|159|153)+\d{8})$/;
    if(!myreg.test(tel)){
        alert('请输入有效的手机号码！');
        $("#telephone").parent().addClass("has-error");
        $("#telephone").focus();
        return false;
    }else{
    	return true;
    }
}

function checkLoginName(name){
	$.ajax({
		url:"<%=basePath%>guest.do/selectLoginName.do",
		type:"get",
		data:{name:name},
		dataType:"json",
		success:function(data){
			if(data==1){
				$("#checkMessage").show();
			}else{
				$("#checkMessage").hide();
			}
		}
	})
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
		<div style="margin-top:5px;">
			<a href="<%=basePath%>page/newIndex.jsp">返回首页</a>
		</div>
		<div class="col-sm-2"></div>
		<div class="col-sm-6">
			<form class="form-horizontal" action="<%=basePath%>user.do/update.do" method="post" onsubmit="return checkForm()">
				<div class="form-group">
					<label for="loginName" class="col-sm-3 control-label">用户名:</label>
					<div class="col-sm-8">
						<input type="text" style="width: 200px;display:inline-block;" class="form-control" id="loginName" name="loginName" placeholder="your login name" value="${user.loginName}" readonly="readonly">
						<input type="hidden" class="form-control" id="url" name="url" value="imges01.png">
						<input type="hidden" class="form-control" id="id" name="id" value="${user.id }">
						<span id="checkMessage" style="display:none;color:red;">已存在</span>
					</div>
					<font color="red" size="5px">*</font>
				</div>
				<div class="form-group">
					<label for="passwd" class="col-sm-3 control-label">密码:</label>
					<div class="col-sm-8">
						<input type="password" style="width: 200px;" class="form-control" id="passwd" name="passwd">
					</div>
					<font color="red" size="5px">*</font>
				</div>
				<div class="form-group">
					<label for="name" class="col-sm-3 control-label">姓名:</label>
					<div class="col-sm-8">
						<input type="text" style="width: 200px;" class="form-control" id="name" name="name" placeholder="your ready name" value="${user.name }">
					</div>
					<font color="red" size="5px">*</font>
				</div>
				<div class="form-group">
					<label for="sex" class="col-sm-3 control-label">性别:</label>
					<div class="col-sm-8">
						<label class="radio-inline">
						  <input type="radio" name="sex" id="sex1" value="0" <c:if test="${user.sex==0}">checked</c:if>> 男
						</label>
						<label class="radio-inline">
						  <input type="radio" name="sex" id="sex2" value="1" <c:if test="${user.sex==1}">checked</c:if>> 女
						</label>
					</div>
					<font color="red" size="5px">*</font>
				</div>
				<div class="form-group">
					<label for="email" class="col-sm-3 control-label">邮箱:</label>
					<div class="col-sm-8">
						<input type="email" class="form-control" id="email" name="email" placeholder="your Email" value="${user.email }">
					</div>
					<font color="red" size="5px">*</font>
				</div>
				<div class="form-group">
					<label for="description" class="col-sm-3 control-label">手机:</label>
					<div class="col-sm-8">
						<input type="tel" class="form-control" id="telephone" name="telephone" placeholder="135XXXXXXXX" value="${user.telephone }">
					</div>
					<font color="red" size="5px">*</font>
				</div>
				<div class="form-group">
					<label for="telephone" class="col-sm-3 control-label">简介:</label>
					<div class="col-sm-8">
						<textarea class="form-control" id="description" name="description" placeholder="I am User" rows="2">${user.description }</textarea>
					</div>
					<font color="red" size="5px">*</font>
				</div>
				<div class="form-group">
					<div class="col-sm-offset-6 col-sm-6">
						<button class="btn btn-primary" style="width: 100px;">保存</button>
					</div>
				</div>
			</form>
		</div>
		<div class="col-sm-2 text-center">
			<div style="margin-bottom:5px;">
				<img id="touxiang" src="<%=basePath%>download/${user.url}" style="width:100px;height:100px;">
			</div>
			<button type="button" onclick="selectPicture()">选择头像</button>
		</div>
	</div>
	<div class="cn-footer container">
	</div>
</body>
</html>