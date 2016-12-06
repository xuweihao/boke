<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<%@include file="../page/common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
var textId ='<%=request.getParameter("id")%>';
var userId;
$(function(){
	if(textId!=""){
		$.ajax({
			url:'<%=basePath %>text.do/selectOneText.do',
			type:'post',
			data:{id:textId},
			dataType:'json',
			success:function(data){
				$('#showTitle h1').html(data.title);
				/* $('#showTitle p').html("<small><small>&nbsp;&nbsp;作者:"+data.userName+"&nbsp;&nbsp;时间: "+data.createTime+"&nbsp;&nbsp;浏览次数: "+data.visitTimes+"</small></small>"); */
				$('#showTitle p').html("<li><small>作者:"+data.userName+"</small></li><li class='text-muted'>|</li>"+
									   "<li><small>"+data.createTime+"</small></li><li class='text-muted'>|</li>"+
									   "<li><small>浏览: "+data.visitTimes+"</small></li><li class='text-muted'>|</li>"+
									   "<li><small>点赞: "+data.dianzanCount+"</small></li>");
				$('#showText').html(data.text);
				/* $('#showText').html("<xmp>"+data.text+"</xmp>"); */
				if(data.dianzan==1){
					$('#btnDz0').hide();
					$('#btnDz1').show();
				}else{
					$('#btnDz1').hide();
					$('#btnDz0').show();
				}
				userId=data.userId;
				showPinglunList(textId);
			}
		})
	}
})

function showPinglunList(id){
	$.ajax({
		url:'<%=basePath %>pinglun.do/selectPinglunByTextId.do',
		type:'post',
		data:{id:id},
		dataType:'json',
		success:function(data){
			var html = "";
			var huifu,neirong,huifukuang,huifuNeirong,delbtn;
			$.each(data,function(i,n){
				huifukuang ="<div class='panel panel-primary' id='panel"+n.id+"' style='display:none;margin:5px 0;'><div class='panel-heading'>"+
							"<h4 class='panel-title'><small>您的回复：</small></h4></div><div class='panel-body text-left' style='height:110px;'>"+
							"<textarea id='plText"+n.id+"' style='width: 100%; height: 50px;margin-bottom: 5px;'></textarea>"+
							"<button type='button' class='btn btn-default' onclick='pinglun("+n.id+","+n.id+")'>提交</button>"+
							"<button type='button' class='btn btn-default' onclick='showPinglun(\"panel"+n.id+"\",2)'>取消</button>"+
							"</div></div>";
				neirong ="<div class='panel-body text-left'><pre>"+n.text+"</pre>";
				if(dengluId == n.userId || userId == dengluId){
					huifu = "<a style='float:right;font-size:10px;' href='#panel"+n.id+"' onclick='showPinglun(\"panel"+n.id+"\",1)'>回复</a>";
				}else{
					huifu = "";
				}
				if(dengluId == n.userId){
					delbtn="<a style='float:right;font-size:10px;margin-left:10px;' href='javascript:void(0)' onclick='delPinglun("+n.id+")'>删除</a>";
				}else{
					delbtn="";
				}
				huifuNeirong=selectHuifu(n.id);
				html = html +"<div class='panel panel-info'><div class='panel-heading'>"+
				 "<h4 class='panel-title'><small>"+n.userName+"&nbsp;的评论："+n.createTime+delbtn+huifu+"</small></h4></div>"+neirong+huifuNeirong+huifukuang+"</div></div>";
			});
			$("#pinglunlist").html(html);
		}
	})
}


function selectHuifu(NO){
	var huifuHtml = "";
	$.ajax({
		url:'<%=basePath %>pinglun.do/selectPinglunByNO.do',
		type:'post',
		data:{id:NO},
		dataType:'json',
		async:false,
		success:function(data){
			$.each(data,function(i,n){
				var delbtn="";
				if(dengluId == n.userId){
					delbtn="<a style='float:right;font-size:10px;color:#fff;' href='javascript:void(0)' onclick='delPinglun("+n.id+")'>删除</a>";
				}
				huifuHtml= huifuHtml+"<div class='panel panel-primary' style='margin:5px 0;'><div class='panel-heading'>"+
						   "<h6 class='panel-title'><small>"+n.userName+"&nbsp;的回复："+n.createTime+delbtn+"</small></h6></div>"+
						   "<div class='panel-body text-left' style='min-height:80px;'><pre>"+n.text+"</pre></div></div>";
			});
		}
	})
	return huifuHtml;
}


/* + */

function showPinglun(id,type){
	if(type==1){
		/* $("#"+id).show("fast",function(){
			$("#"+id).find("textarea").focus();
		}); */
		$("#"+id).show();
	}else{
		$("#"+id).hide();
	}
}

function pinglun(id,NO){
	var text=$("#plText"+id).val();
	if(NO==0){
		URL="<%=basePath %>pinglun.do/insertPinglun.do";
	}else{
		URL="<%=basePath %>pinglun.do/insertHuifu.do";
	}
	if(text!=""){
		$.ajax({
			url:URL,
			type:'post',
			data:{textId:textId,text:text,NO:NO},
			dataType:'json',
			success:function(data){
				if(data==1){
					alert("评论成功");
					showPinglunList(textId);
					if(NO==0){
						showPinglun('pinglun',2);
					}else{
						showPinglun('panel'+id,2);
					}
				}else{
					alert("评论失败");
				}
			}
		})
	}
}

function dianZan(){
	$.ajax({
		url:'<%=basePath %>dianzan.do/InsertDianZan.do',
		type:'post',
		data:{textId:textId,userId:dengluId},
		dataType:'json',
		success:function(data){
			if(data==1){
				$('#btnDz0').hide();
				$('#btnDz1').show();
			}else{
				$('#btnDz1').hide();
				$('#btnDz0').show();
			}
		}
	})
}

function delPinglun(id){
	if(confirm("是否确定删除此评论")){
		$.ajax({
			url:'<%=basePath %>pinglun.do/delPinglunById.do',
			type:'post',
			data:{id:id},
			dataType:'json',
			success:function(data){
				if(data==1){
					alert("删除成功");
					showPinglunList(textId);
				}else{
					alert("删除失败");
				}
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
		<div style="margin-top:5px;">
			<a href="<%=basePath%>page/newIndex.jsp">返回首页</a>
		</div>
		<div id="showDiv">
			<div id="showTitle" class="text-center">
				<h1></h1>
				<p class="list-inline"></p>
			</div>
			<div class="panel panel-default">
				<div id="showText" class="panel-body" style="min-height: 500px;max-height: 700px;overflow:scroll; ">
				
				</div>
			</div>
		</div>
		<div class="text-center" style="width:100%;margin-bottom:20px;">
			<button type="button" class="btn btn-danger" id="btnDz0" title="请点赞" style="width: 80px;height: 40px;" onclick="dianZan()">点赞</button>
			<button type="button" class="btn btn-primary" id="btnDz1" title="取消点赞" style="width: 80px;height: 40px;" onclick="dianZan()">已赞</button>
			<button type="button" class="btn btn-danger" style="width: 80px;height: 40px;" onclick="showPinglun('pinglun',1)">评论</button>
		</div>
		<div id="pinglun" style="display: none">
			<div class="panel panel-info">
				<div class="panel-heading">
					<h3 class='panel-title'>你的评论:</h3>
				</div>
				<div class="panel-body text-left" style="height:180px;">
					<textarea id="plText0" style="width: 100%; height: 120px;margin-bottom: 5px;"></textarea>
					<button type="button" class="btn btn-default" onclick="pinglun(0,0)">提交</button>
					<button type="button" class="btn btn-default" onclick="showPinglun('pinglun',2)">取消</button>
				</div>
			</div>
		</div>
		<div id="pinglunlist">
		
		</div>
	</div>
	<div class="cn-footer container">
	</div>
</body>
</html>