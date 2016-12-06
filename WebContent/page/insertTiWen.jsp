<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../page/common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
$(function(){
	$('#chooseFile').on('change', onloadFile);		
})
function onloadFile(evt){
	var value = $('#fileUrl').val();
	var files = evt.target.files; 
	for (var i = 0, f; f = files[i]; i++) {
		//Loop thorugh all the files
		if(!f.type.match('image.*') || !f.name.match(/(?:gif|jpg|png|jpeg)$/)){ //Process only Images
			alert("文件类型不是图片,请重新选择")
			continue;
		}
		var fileName;
		var reader = new FileReader();
		reader.onload = (function(imageFile){
			fileName = escape(imageFile.name);
			fileName = fileName.replace(/%/g, "");
		})(f);
		reader.readAsDataURL(f);
		var reader2= new FileReader();
		reader2.readAsBinaryString(f);
		reader2.onload = function(e) {
			imgBinaryString = this.result;
			$.ajax({
				url:"<%=basePath%>file.do/upload.do",
				type:"post",
				data:{img: imgBinaryString,fileName:fileName},
				dataType:"json",
				success:function(data){
					if(data!=1){
						var li = $('<li/>',{class:"col-xs-8 col-sm-4 col-md-2 col-lg-2"});
						var a = $('<a/>',{
							href:"javascript:openPhoto('"+data+"')",
							class:"thumbnail"
						});
						/* var dela = $('<a/>',{
							href:"javascript:delPhoto('"+data+"')",
							
						}); */
						var image = $('<img/>',{
							src:"<%=basePath%>download/"+data,
							title:fileName
						}).appendTo(a).click(function(){
							$('#imageList').data('current', $(this).attr('src'));
							});
						li.append(a).appendTo($('#imageList'));
						if(value==""){
							$('#fileUrl').val(data);
						}else{
							$('#fileUrl').val(value+","+data);
						}
					}else{
						alert("上传失败")
					}
				}
			});
		};
	}
}

function openPhoto(url){
	var json = {"title":"","id":"123","data":[{ "alt": "","pid": 666, "src":"<%=basePath%>download/"+url}]};
	layer.photos({
        photos: json //格式见API文档手册页
    });
}


function submitForm(){
	var text = $("#text").val();
	var title = $("#title").val();
	var fileUrl= $("#fileUrl").val();
	if(title==""){
		alert("标题不能为空");
		return false;
	}else{
		$.ajax({
			url:'<%=basePath%>text.do/insertTiWen.do',
			type:'post',
			data:{title:title,text:text,type:2,fileUrl:fileUrl},
			dataType:'json',
			success:function(data){
				alert('保存成功');
				window.location.href="<%=basePath%>text.do/toShowTiWen.do?id="+data;
			}
		})
	}
}
</script>
</head>
<body>
	<div class="cn-header container">
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
		<form class="form-horizontal">
			<div class="form-group">
				<label for="title" class="col-sm-3 control-label">标题:</label>
				<div class="col-sm-8">
					<input type="text" class="form-control" id="title" name="title" placeholder="title">
					<input type="hidden" id="fileUrl" name="fileUrl">
				</div>
				<font color="red" size="5px">*</font>
			</div>
			<div class="form-group">
				<label for="text" class="col-sm-3 control-label">提问内容:</label>
				<div class="col-sm-8">
					<textarea class="form-control" rows="8" id="text"></textarea>
				</div>
				<font color="red" size="5px">*</font>
			</div>
			<div class="form-group">
				<label for="chooseFile" class="col-sm-3 control-label">上传附件:</label>
				<div class="col-sm-8">
					<input type="file" class="form-control" style="width: 200px;" id="chooseFile" onchange="onloadFile()"/>
					<div id="imageList" style="margin-top:5px;"></div>
				</div>
			</div>
			<div class="form-group">
				<div class="col-sm-offset-5 col-sm-7">
					<button type="button" class="btn btn-primary" style="width: 100px;" onclick="submitForm()">提交</button>
					<button type="button" class="btn btn-primary" style="width: 100px;" onclick="javascript:history.go(-1);">取消</button>
				</div>
			</div>
		</form>
	</div>
	<div class="cn-footer container">
	</div>
</body>
</html>