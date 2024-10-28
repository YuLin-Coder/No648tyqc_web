<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
     <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<link rel="stylesheet" type="text/css" href="<%=path %>/layui/css/layui.css"> 
<link rel="stylesheet" type="text/css" href="<%=path %>/layui/css/admin.css"> 
<link rel="stylesheet" type="text/css" href="<%=path %>/layui/css/login.css">  
<link href="<%=path %>/layui/css/modules/laydate/default/laydate.css" rel="stylesheet">
<style>
	.layui-form-radio {
		font-size: 10px;
	}
</style>
</head>
<body>
 
  <div class="layui-form" lay-filter="layuiadmin-form-useradmin" id="layuiadmin-form-useradmin" style="padding: 20px 0 0 0;">
   <div class="layui-form-item">
      <label class="layui-form-label">起始时间</label>
      <div class="layui-input-inline">
       <input type="text" class="layui-input" name="start_time" id="start_time" placeholder=" 起始时间 ">
      </div>
    </div>
  	<div class="layui-form-item">
	      <label class="layui-form-label">结束时间</label>
	      <div class="layui-input-inline">
	        <input type="text" name="end_time"id="end_time" lay-verify="end_time" placeholder="请输入结束时间" autocomplete="off" class="layui-input" >
	      </div>
    </div>
   <div class="layui-form-item">
	      <label class="layui-form-label">器材数量</label>
	      <div class="layui-input-inline">
	        <input type="number" name="quantity"id="quantity" lay-verify="quantity" placeholder="数量"value="1" autocomplete="off" class="layui-input" >
	      </div>
    </div>
    
	              
    <div class="layui-form-item layui-hide">
      <input type="button" lay-submit lay-filter="LAY-user-front-submit" id="LAY-user-front-submit" value="确认">
    </div>
  </div>
		

<script src="<%=path %>/layui/layui.js"></script>
<script src="<%=path %>/layui/lay/modules/laydate.js"></script>
<script>

layui.use('laydate', function(){
	var laydate = layui.laydate;
	//执行一个laydate实例
	laydate.render({
	elem: '#start_time' //指定元素
		,type: 'datetime' 
	,format: 'yyyy-MM-dd HH:mm:ss'
	});
	
	laydate.render({
		elem: '#end_time' //指定元素
			,type: 'datetime' 
		,format: 'yyyy-MM-dd HH:mm:ss'
		});
	});
				   

</script>

</body>
</html>