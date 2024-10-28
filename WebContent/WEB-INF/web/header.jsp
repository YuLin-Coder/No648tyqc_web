<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	
<div class="fly-header layui-bg-black">
  <div class="layui-container">
   <a class="fly-logo" href="javascript:void(0)" style="color: white;font-size:18px">
      		体育器材预约管理系统
    </a>
    <ul class="layui-nav fly-nav layui-hide-xs">
      <li class="layui-nav-item">
        <a href="webNews"><i class="iconfont icon-jiaoliu"></i>公告列表</a>
      </li>
      <li class="layui-nav-item ">
        <a href="webProduct"><i class="iconfont icon-iconmingxinganli"></i>体育器材列表</a>
      </li>
    </ul>
    
   <ul class="layui-nav fly-nav-user">
      <c:if test="${student eq null  }" >
      <c:if test="${teacher eq null  }" >
      <!-- 未登入的状态 -->
      <li class="layui-nav-item">
        <a href="toWebLoginstu">学生端登入</a>
      </li>
      <li class="layui-nav-item">
        <a href="toWebLogintec">教师端登入</a>
      </li>
      <li class="layui-nav-item">
        <a href="toWebRegister">学生端注册</a>
      </li>
        <li class="layui-nav-item">
        <a href="loginInfo">进入后台系统</a>
      </li>
       </c:if>
      </c:if>
       <c:if test="${student ne null }" >
       		 <!-- 登入后的状态 -->
       		  <li class="layui-nav-item">
		        <a href="toWebSetInfo">用户中心</a>
		      </li>
		      <li class="layui-nav-item">
		        <a href="webLoginOut">退出</a>
		      </li>
       </c:if>
      
     <c:if test="${teacher ne null }" >
       		 <!-- 登入后的状态 -->
       		  <li class="layui-nav-item">
		        <a href="toWebSetInfo">用户中心</a>
		      </li>
		      <li class="layui-nav-item">
		        <a href="webLoginOut">退出</a>
		      </li>
       </c:if>
    </ul>
  </div>
</div>
</body>
</html>