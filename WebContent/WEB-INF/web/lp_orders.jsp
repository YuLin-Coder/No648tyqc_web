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
<style>
	.layui-form-radio {
		font-size: 10px;
	}
</style>
</head>
<body>

 
  <div class="layui-form" lay-filter="layuiadmin-form-useradmin" id="layuiadmin-form-useradmin" style="padding: 20px 0 0 0;">
  	<div class="layui-form-item">
	      <label class="layui-form-label">申请理赔金额</label>
	      <div class="layui-input-inline">
	        <input type="number" name="lp_price"id="lp_price"placeholder="请输入金额" autocomplete="off" class="layui-input" >
	      </div>
    </div>
    <div class="layui-form-item">
      <label class="layui-form-label">申请理由</label>
      <div class="layui-input-inline">
        <input type="text" name="reason" id="reason" placeholder="请输入理由" autocomplete="off" class="layui-input" >
      </div>
    </div>
      
    <div class="layui-form-item layui-hide">
      <input type="button" lay-submit lay-filter="LAY-user-front-submit" id="LAY-user-front-submit" value="确认">
    </div>
  </div>
		

<script src="<%=path %>/layui/layui.js"></script>
<script>
	    
		   

</script>
</body>
</html>