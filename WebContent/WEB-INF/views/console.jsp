<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>


<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>管理系统</title>
  <meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
  <link rel="stylesheet" type="text/css" href="layui/css/layui.css" media="all">
  <link rel="stylesheet" href="layui/css/admin.css" media="all"> 
</head>
<body>
  
  <div class="layui-fluid">
    <div class="layui-row layui-col-space15">
      
      <div class="layui-col-md4">
        <div class="layui-card">
          <div class="layui-card-header">欢迎来到体育器材预约管理系统</div>
        </div>
       	
      
      </div>
       <div class="layui-col-md12">
       <div class="layui-card">
          <div class="layui-card-header">器材数量统计分析</div>
          <div class="layui-card-body">
       
          		
 			 <div id="chartmain" style="width:600px; height: 400px;"></div>
          
          </div>
        </div>
      </div>
    </div>
  </div>

 
</body>
<script src="layui/layui.all.js"></script>
<script src="js/jquery-3.3.1.js"></script>
<script src="static/js/echarts-all.min.js"></script>
<script type="text/javascript">
	 //指定图标的配置和数据
	 var myChart = echarts.init(document.getElementById('chartmain'));
	 var option = {
	     title:{
	         text:'器材数量统计分析'
	     },
	     tooltip:{},
	     legend:{
	         data:['用户来源']
	     },
	     xAxis:{
	         data:["11","123"]
	     },
	     yAxis:{
	
	     },
	     series:[{
	         name:'库存数量',
	         type:'bar',
	         data:[500,200,360,100]
	     }]
	 };
	 //初始化echarts实例
	 //var myChart = echarts.init(document.getElementById('chartmain'));
	 $.ajax({
	    					  type: 'POST',
	    					  url: '${pageContext.request.contextPath}/report1Data',
	    					  data: {},
	    					  dataType: "json",
	    					  success:function(result){
	    						  console.log(result)
	    			    			var Item = function() {
	    			    				return {
	    			    					name : '库存数量',
	    			    					type : 'bar',
	    			    					data : []
	    			    				}
	    			    			};
	    			    			var legends = [];//线条类型
	    			    			var Series = [];//数据
	    			    			var names=[];//类别数组（实际用来盛放X轴坐标值）
	    			    			var xContent=result;
	    			    			var data = [];
	    			    			var data2 = [];
	    			    			var it = new Item();
	    			    			for (var key in xContent) { 
	    			    				console.log(xContent[key],key);
	    			    				
	    			    				
	    			    				data.push(key);
	    			    				data2.push(xContent[key]);
	    			    				
	    			    				
	    			    				
	    			    			}
	    			    			it.data = data2;
	    			    			console.log("data:"+data);
	    			    			console.log("Series:"+Series);
	    			    			option.xAxis.data = data;
	    			    			option.legend.data = legends;
	    			    			option.series = it; // 设置图表  
	    			    			myChart.hideLoading(); //隐藏加载动画
	    			    			myChart.setOption(option);// 重新加载图表  
	    					 },
	    					  error:function(req){
	    					         //请求出错处理
	    							console.log(req);
	    						      }
	    					});
	
	 //使用制定的配置项和数据显示图表
	 myChart.setOption(option);

  </script>     
</html>

    