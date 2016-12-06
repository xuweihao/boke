<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../page/common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
var userId = "${user.id}";
$(function(){
	ajaxData(1);
	ajaxTiWen();
})

function toPage(btn){
	var page= $('#page').text();
	var total = $('#total').text();
	if(btn=="next" && page<total){
		page = Number(page)+1;
	}else if(btn=="pre" && page>1){
		page = Number(page)-1;
	}else{
		return false;
	}
	ajaxData(page);
}

function ajaxTiWen(){
	$.ajax({
		url:"<%=basePath%>guest.do/selectTiWenByUser.do",
		type:"post",
		data:{UserId:dengluId},
		dataType:"json",
		success:function(data){
			var html ="";
			$.each(data,function(i,n){
				html=html+"<div style='border-radius:10px;background-color:#ccc;padding:10px;margin-bottom:10px;'><p>标题:<a href='<%=basePath%>text.do/toShowTiWen.do?id="+n.id+"'>"+n.title+"</a></p><p>提问时间:"+n.createTime+"</p></div>";
			})	
			if(html==""){
				html="<div class='text-center row' style='height:100px;line-height:100px;'>暂无提问</div>";
			}
			$('.m-tiwen .panel-body').html(html);
		}
	})
}

function ajaxData(page){
	$.ajax({
		url:"<%=basePath%>guest.do/selectTextByUser.do",
		type:"post",
		data:{UserId:userId,page:page},
		dataType:"json",
		success:function(data){
			var html ="";
			$.each(data,function(i,n){
				html=html+"<div class='row'>"+
						 "<div class='panel panel-default' >"+
						 "<div class='panel-heading'>"+
						 "<h3 class='panel-title'><a href='<%=basePath%>guest/show.jsp?id="+n.id+"'>"+n.title+"</a>"+
						 /* "<h3 class='panel-title'><a href='javascript:void(0)' onclick='openLayer("+n.id+",\""+n.title+"\")'>"+n.title+"</a>"+ */
						 "&nbsp;&nbsp;<small>"+n.userName+"&nbsp;&nbsp;"+n.createTime+"&nbsp;&nbsp;赞"+n.dianzan+"&nbsp;&nbsp;评论"+n.dianzan+
						 "</small></h3></div>"+
						 "<div class='panel-body' style='height:120px;overflow:hidden;'>"+n.text+"</div></div></div>";
			})	
			if(html==""){
				html="<div class='text-center row' style='height:100px;line-height:100px;'>暂无文章</div>";
			}
			$('#textList').html(html);
		}
	})
	$.ajax({
		url:"<%=basePath%>guest.do/selectCountByUser.do",
		type:"post",
		data:{UserId:userId},
		dataType:"json",
		success:function(data){
			var html ="第<span id='page'>"+page+"</span>页/共<span id='total'>"+data+"</span>页";
			if(page==1 && data==1){
				$('#pagination button').hide();
			}else{
				$('#pagination button').show();
			}
			$('#pager').html(html);
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
		<div style="padding:20px 0;">
			<div class="container b-left">
				<div class="row">
					<div class="col-xs-4">
						<img src="<%=basePath%>download/${user.url}" style="width: 100px;height: 100px;"/>
					</div>
					<div class="col-xs-8" style="padding-top:10px;height:100px;">
						<p>Name:${user.loginName }</p>
						<p>Description:
							<c:choose>
								<c:when test="${user.description==''}">
									该主人太懒，什么都没留下
								</c:when>
								<c:when test="${user.description==null}">
									该主人太懒，什么都没留下
								</c:when>
								<c:when test="${user.description!=''}">
									${user.description}
								</c:when>
							</c:choose>
						</p>
					</div>
				</div>
			</div>
			<div class="container b-right">
				<div id="textList"></div>
				<div class="row" id="pagination">
					<div class="col-md-4 text-left">
						<button type="button" class="btn btn-success" onclick="toPage('pre')">上一页</button>
					</div>
					<div class="col-md-4 text-center" style="margin-top:5px;" id="pager"></div>
					<div class="col-md-4 text-right">
						<button type="button" class="btn btn-success" onclick="toPage('next')">下一页</button>
					</div>
				</div>
				<div class="row" id="pagination">
					<div class="col-md-4 text-left">
						<button type="button" class="btn btn-success" onclick="toPage('pre')">上一页</button>
					</div>
					<div class="col-md-4 text-center" style="margin-top:5px;" id="pager"></div>
					<div class="col-md-4 text-right">
						<button type="button" class="btn btn-success" onclick="toPage('next')">下一页</button>
					</div>
				</div>
			</div>
			<div class="clear"></div> 
		</div>
	</div>
	<div class="cn-footer container">
	</div>



</body>
</html>