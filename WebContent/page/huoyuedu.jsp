<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../page/common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
${demo.css}
</style>
<script type="text/javascript">
var date = new Date();
var nowYear = date.getFullYear();
var dataYear,birthYear;
$(function () {
	ajaxData(0);
});

function toAjax(num){
	if(num==0){
		dataYear = dataYear-1;
		if(dataYear==birthYear){
			ajaxData(0);	
		}else{
			ajaxData(dataYear);	
		}
	}else{
		ajaxData(dataYear+1);	
	}
}

var monthList =['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
function ajaxData(year){
	$.ajax({
		url:'<%=basePath%>user.do/selectHY.do',
		type:'get',
		data:{year:year},
		dataType:'json',
		success:function(data){
			dataYear = data.year;
			var month = data.month-1;
			var dataList = data.list;
			if(dataYear==nowYear){
				$('#nextYear').hide();
			}else{
				$('#nextYear').show();
			}
			if(year==0){
				birthYear = data.year;
				$('#preYear').hide();
			}else{
				$('#preYear').show();
			}
			$('#container').highcharts({
		        title: {
		            text: 'User 活跃度走向图',
		            x: -20 //center
		        },
		        subtitle: {
		            text: dataYear,
		            x: -20
		        },
		        xAxis: {
		        	title:'xxx',
		            categories: monthList
		        },
		        yAxis: {
		        	gridLineWidth:2,
		            title: {
		                text: '活跃度'
		            },
		            plotLines: [{
		                value: 0,
		                width: 2,
		                color: '#808080'
		            }]
		        },
		        tooltip: {
		            /* valueSuffix: '°C' */
		            formatter:function(){
		            	if(year==0){
		            		if(monthList[month]==this.x){
		            			return "您的蛋生日";
		            		}else {
		            			return dataYear+" "+this.x+"的活跃度:"+this.y;
		            		}
		            	}else {
	            			return dataYear+" "+this.x+"的活跃度:"+this.y;
	            		}
		            }
		        }, 
		        legend: {
		            layout: 'vertical',
		            align: 'right',
		            verticalAlign: 'middle',
		            borderWidth: 0
		        },
		        series: [{
		            name: 'user',
		            data: dataList,
		        }]
		    });
		}
	})
}
</script>
<script src="<%=basePath%>js/highcharts/highcharts.js"></script>
<script src="<%=basePath%>js/highcharts/exporting.js"></script>
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
	<div id="container" style="min-width: 310px;max-width: 1110px; height: 400px; margin:40px auto"></div>
	<div style="min-width: 310px;max-width: 1110px; margin:40px auto">
		<button type="button" class="pull-left" id="preYear" onclick="toAjax(0)">上一年</button>
		<button type="button" class="pull-right" id="nextYear" onclick="toAjax(1)">下一年</button>
	</div>
</body>
</html>