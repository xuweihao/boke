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
	var index = parent.layer.getFrameIndex(window.name); 
	$.ajax({
		url:"<%=basePath%>guest.do/selectPicture.do",
		dataType:"json",
		success:function(data){
			//debugger;
			var html = "";
			$.each(data,function(i,n){
				html=html+"<img id='"+n.name+"' src='<%=basePath%>download/"+n.url+"' style='width:100px;height:100px;border:3px solid #fff;' onclick='checkPicture(this.id,\""+n.url+"\")'/>";
			})
			$("#pictureList").append(html);
		}
	})
	$('#transmit').on('click', function(){
	    parent.$('#touxiang').attr("src","<%=basePath%>download/"+url);
	    parent.$('#url').val(url);
	    parent.layer.close(index);
	});
})
var url="imges01.png";
function checkPicture(obj,uri){
	$('#'+obj).css('border','3px solid #44cbd8').siblings().css('border','3px solid #fff');
	url=uri;
}

</script>
</head>
<body>
	<div style="width:550px;height:380px;background-color:#0080FF">
		<div id="pictureList" >
	
		</div>
		<button type="button" class="btn btn-default" id="transmit">确定</button>
	</div>
</body>
</html>