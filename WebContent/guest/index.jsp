<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../page/common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
.col-md-3 {
	padding-left:0;
	padding-right:0;
}
</style>
<script type="text/javascript">
$(function(){
	$.ajax({
		url:"<%=basePath%>guest.do/selectShow.do",
		method:"post",
		dataType:"json",
		success:function(data){
			var html ="";
			$.each(data,function(i,n){
				html = html+"<div class='g-title' title='"+n.title+"'><a href='<%=basePath%>guest/show.jsp?id="+n.id+"'>"+n.title+"</a><small style='float:right'>"+n.userName+"&nbsp;&nbsp;"+n.createTime+"</small></div>";
			})
			$(".g-news").append(html);
		}
	})
	$.ajax({
		url:"<%=basePath%>guest.do/selectShowVisitMost.do",
		method:"post",
		dataType:"json",
		success:function(data){
			var html ="";
			$.each(data,function(i,n){
				html = html+"<div class='g-title' title='"+n.title+"'><a href='<%=basePath%>guest/show.jsp?id="+n.id+"'>"+n.title+"</a><small style='float:right'>"+n.userName+"&nbsp;&nbsp;"+n.createTime+"</small></div>";
			})
			$(".g-most").append(html);
		}
	})
	$.ajax({
		url:"<%=basePath%>guest.do/selectUserVisitMost.do",
		method:"post",
		dataType:"json",
		success:function(data){
			var html ="<div style='padding-top:15px;'>";
			$.each(data,function(i,n){
				html = html+"<div style='margin:7px 15px;'><img src='<%=basePath%>download/"+n.url+"' class='img'/>"+
				"<a class='username' href='<%=basePath%>guest.do/visitUser.do?id="+n.id+"'>"+n.loginName+"</a></div>";
			})
			html = html+"</div>";
			$(".g-users").append(html);
		}
	})
	$.ajax({
		url:"<%=basePath%>guest.do/selectTiWenNew.do",
		method:"post",
		dataType:"json",
		sync:"false",
		success:function(data){
			
			var html ="<div style='padding-top:20px;'>";
			$.each(data,function(i,n){
				html = html+"<div class='m-tiwen' ><p><a href='<%=basePath%>guest.do/toShowTiWen.do?id="+n.id+"'>"+n.title+"</a></p><p>"+n.userName+"&nbsp;&nbsp;"+n.createTime+"</p>"+
				"<div><pre><xmp>"+n.text+"</xmp></pre></div></div>";
			})
			html = html+"</div>";
			$(".g-tiwen").append(html);
			setTimeout(lunbo,5000);

		}
	})
	
})

var i=-1;
function lunbo(){
	i++;
	$('.g-tiwen .m-tiwen').fadeOut().eq(i+1).fadeIn();
	$('.g-tiwen .m-tiwen').eq(i+2).fadeIn();
	if(i==($('.g-tiwen .m-tiwen').length-1)){
		$('.g-tiwen .m-tiwen').fadeOut().fadeIn();
		i=-1;
	}
	setTimeout(lunbo,5000);
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
	<div class="cn-body container">
			<div class="col-md-3  pull-left">
				<div class="g-div g-users">
					<div class="g-title" >访客量最多的博客主<small style="float:right;"><a href="">更多</a></small></div>
				</div>
			</div>
			<div class="col-md-6">
				<div class="col-md-12 pull-left">
					<div class="g-div g-news">
						<div class="g-title" >博客最新分享<small style="float:right;"><a href="<%=basePath%>guest.do/toMore.do?type=1">更多</a></small></div>
					</div>
				</div>
				<div class="col-md-12 pull-left">
					<div class="g-div g-most">
						<div class="g-title" >访客量最多的分享<small style="float:right;"><a href="<%=basePath%>guest.do/toMore.do?type=2">更多</a></small></div>
					</div>
				</div>
			</div>
			<div class="col-md-3 pull-left">
				<div class="g-div g-tiwen">
					<div class="g-title" >最新提问<small style="float:right;"><a href="<%=basePath%>guest.do/toMore.do?type=3">更多</a></small></div>
				</div>
			</div>
		</div>
	<div class="cn-footer container">
	</div>
</body>
</html>