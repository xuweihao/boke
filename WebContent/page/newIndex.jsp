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
		url:"<%=basePath%>text.do/selectTiWenByUser.do",
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
		url:"<%=basePath%>text.do/selectTextByUser.do",
		type:"post",
		data:{UserId:dengluId,page:page},
		dataType:"json",
		success:function(data){
			var html ="";
			$.each(data,function(i,n){
				html=html+"<div class='row'>"+
						 "<div class='panel panel-default' >"+
						 "<div class='panel-heading'>"+
						 "<h3 class='panel-title'><a href='<%=basePath%>text.do/toShow.do?id="+n.id+"'>"+n.title+"</a>"+
						 /* "<h3 class='panel-title'><a href='javascript:void(0)' onclick='openLayer("+n.id+",\""+n.title+"\")'>"+n.title+"</a>"+ */
						 "&nbsp;&nbsp;<small>"+n.userName+"&nbsp;&nbsp;"+n.createTime+"&nbsp;&nbsp;赞"+n.dianzanCount+"&nbsp;&nbsp;评论"+n.dianzan+
						 "</small><a style='float:right;font-size:10px;margin-left:10px;' href='javascript:void(0)' onclick='delText("+n.id+")'>删除</a>"+
						 "<a style='float:right;font-size:10px;' href='<%=basePath%>text.do/toUpdateText.do?id="+n.id+"'>编辑</a></h3></div>"+
						 "<div class='panel-body' style='height:120px;overflow:hidden;'>"+n.text+"</div></div></div>";
			})	
			if(html==""){
				html="<div class='text-center row' style='height:100px;line-height:100px;'>暂无文章</div>";
			}
			$('#textList').html(html);
		}
	})
	$.ajax({
		url:"<%=basePath%>text.do/selectCountByUser.do",
		type:"post",
		data:{UserId:dengluId},
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

function delText(textId){
	if(confirm("确定删除此分享?")){
		$.ajax({
			url:"<%=basePath%>text.do/delText.do",
			type:"post",
			data:{textId:textId},
			dataType:"json",
			success:function(data){
				if(data==1){
					alert("删除成功");
					window.location.reload();
				}else{
					alert("删除失败，请联系管理员");
				}
			}
		})
	}
}

function edit(){
	window.location.href="<%=basePath%>user.do/toUpdate.do";
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
		<!-- <input type="text" id="page" name="page" value="1"> -->
		<div style="padding:20px 0;">
			<div class="container b-left">
				<div class="row m-left">
					<div class="ml-top">
						<img src="<%=basePath%>download/<%=user.getUrl()%>" class="img"/>
						<div style="float:right;padding-right:10px;"><button class="btn btn-primary" type="button" onclick="edit()">修改</button></div>
						<div class="toolbar">
							<p>ID:<%=user.getId()%></p>
							<p>姓名:<%=user.getLoginName()%></p>
							<p>描述:
								<c:choose>
									<c:when test="${sessionScope.userinfo.description==null}">
										该主人太懒，什么都没留下
									</c:when>
									<c:when test="${sessionScope.userinfo.description==''}">
										该主人太懒，什么都没留下
									</c:when>
									<c:when test="${sessionScope.userinfo.description!=''}">
										${sessionScope.userinfo.description}
									</c:when>
								</c:choose>
							</p>
						</div>
							
						<!-- </div> -->
					</div>
					<div class="ml-footer">
						<table class="table" style="margin-top:10px;">
							<tr>
								<th>手机</th>
								<td><%=user.getTelephone()%></td>
							</tr>
							<tr>
								<th>邮箱</th>
								<td><%=user.getEmail()%></td>
							</tr>
							<tr>
								<td colspan="2"><a href="<%=basePath%>page/huoyuedu.jsp">查看活跃度</a></td>
							</tr>
						</table>
					</div>
				</div>
				<div class="row m-tiwen">
					<div class="panel panel-success">
						<div class='panel-heading'><h3 class="panel-title">提问</h3></div>
					  	<div class="panel-body" style="max-height:700px;overflow-y:scroll;"></div>
					  	<!-- <div class="panel-footer text-center"><a href="javascript:void(0)">查看更多</a></div> -->
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
			</div>
			<div class="clear"></div> 
		</div>
	</div>
	<div class="cn-footer container">
	</div>



</body>
</html>