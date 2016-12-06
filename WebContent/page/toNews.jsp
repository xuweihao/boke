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
	showPinglunList(1);
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

function showPinglunList(page){
	$.ajax({
		url:'<%=basePath %>pinglun.do/selectPLByUser.do',
		type:'post',
		data:{page:page},
		dataType:'json',
		success:function(data){
			var html = "";
			var huifu,neirong,huifukuang,huifuNeirong,delbtn;
			$.each(data,function(i,n){
				huifukuang ="<div class='panel panel-primary' id='panel"+n.id+"' style='display:none;margin:5px 0;'><div class='panel-heading'>"+
							"<h4 class='panel-title'><small>您的回复：</small></h4></div><div class='panel-body text-left' style='height:110px;'>"+
							"<textarea id='plText"+n.id+"' style='width: 100%; height: 50px;margin-bottom: 5px;'></textarea>"+
							"<button type='button' class='btn btn-default' onclick='pinglun("+n.id+","+n.id+","+n.textId+")'>提交</button>"+
							"<button type='button' class='btn btn-default' onclick='showPinglun(\"panel"+n.id+"\",2)'>取消</button>"+
							"</div></div>";
				neirong ="<div class='panel-body text-left'><pre>"+n.text+"</pre>";
				huifu = "<a style='float:right;font-size:10px;' href='#panel"+n.id+"' onclick='showPinglun(\"panel"+n.id+"\",1)'>回复</a>";
				if(dengluId == n.userId){
					delbtn="<a style='float:right;font-size:10px;margin-left:10px;' href='javascript:void(0)' onclick='delPinglun("+n.id+")'>删除</a>";
				}else{
					delbtn="";
				}
				huifuNeirong=selectHuifu(n.id);
				if(n.type==1){
					html = html +"<div class='panel panel-info'><div class='panel-heading'>"+
					 "<h4 class='panel-title'><a href='<%=basePath%>text.do/toShow.do?id="+n.textId+"'>"+n.textName+"</a>&nbsp;<small>"+n.userName+"&nbsp;的评论："+n.createTime+delbtn+huifu+"</small></h4></div>"+neirong+huifuNeirong+huifukuang+"</div></div>";
				}else{
					html = html +"<div class='panel panel-info'><div class='panel-heading'>"+
					 "<h4 class='panel-title'><a href='<%=basePath%>text.do/toShowTiWen.do?id="+n.textId+"'>"+n.textName+"</a>&nbsp;<small>"+n.userName+"&nbsp;的评论："+n.createTime+delbtn+huifu+"</small></h4></div>"+neirong+huifuNeirong+huifukuang+"</div></div>";
				}
				
			});
			$("#pinglunlist #textList").html(html);
		}
	})
	$.ajax({
		url:"<%=basePath%>pinglun.do/selectPLCountByUser.do",
		type:"post",
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
						   "<h6 class='panel-title'><small>"+n.userName+"&nbsp;的回复："+delbtn+"</small></h6></div>"+
						   "<div class='panel-body text-left' style='min-height:80px;'><pre>"+n.text+"</pre></div></div>";
			});
		}
	})
	return huifuHtml;
}

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

function pinglun(id,NO,textId){
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
					var page= $('#page').text();
					showPinglunList(page);
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
					var page= $('#page').text();
					showPinglunList(page);
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
		<div id="pinglunlist" style="padding:5px;">
			<div id="textList">
				
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
	</div>
	<div class="cn-footer container">
	</div>



</body>
</html>