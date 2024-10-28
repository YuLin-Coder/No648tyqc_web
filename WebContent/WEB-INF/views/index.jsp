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
<title>体育器材预约管理系统</title>
<link rel="stylesheet" type="text/css" href="layui/css/layui.css">
  <link rel="stylesheet" href="layui/css/admin.css" media="all"> 
</head>
<body class="layui-layout-body">
  	<div id="LAY_app">
	    <div class="layui-layout layui-layout-admin">
	      <div class="layui-header">
	        <!-- 头部区域 -->
	        <ul class="layui-nav layui-layout-left">
	          <li class="layui-nav-item layadmin-flexible" lay-unselect>
	            <a href="javascript:;" layadmin-event="flexible" title="侧边伸缩">
	              <i class="layui-icon layui-icon-shrink-right" id="LAY_app_flexible"></i>
	            </a>
	          </li>
	        </ul>
	        <ul class="layui-nav layui-layout-right" lay-filter="layadmin-layout-right">
	          
	          <li class="layui-nav-item layui-hide-xs" lay-unselect>
	            <a href="webIndex" layadmin-event="fullscreen">
	            	  进入网站
	            </a>
	          </li>
	          <li class="layui-nav-item" lay-unselect>
	            <a href="javascript:;">
	              <cite>${admin.realname }</cite>
	            </a>
	            <dl class="layui-nav-child">
	              <dd><a href="findMyInfoAct?id=${admin.id }" target="mainFrame">个人信息</a></dd>
	              <hr>
	              <dd  style="text-align: center;"><a  href="webIndex">退出</a></dd>
	            </dl>
	          </li>
	          
	          <li class="layui-nav-item layui-hide-xs" lay-unselect>
	            <a href="javascript:;" layadmin-event="about"><i class="layui-icon layui-icon-more-vertical"></i></a>
	          </li>
	          <li class="layui-nav-item layui-show-xs-inline-block layui-hide-sm" lay-unselect>
	            <a href="javascript:;" layadmin-event="more"><i class="layui-icon layui-icon-more-vertical"></i></a>
	          </li>
	        </ul>
	      </div>
	      
	      <!-- 侧边菜单 -->
	      <div class="layui-side layui-side-menu">
	        <div class="layui-side-scroll">
	          <div class="layui-logo" lay-href="home/console.html">
	            <span>体育器材预约管理系统</span>
	          </div>
	          
	          <ul class="layui-nav layui-nav-tree" lay-shrink="all" id="LAY-system-side-menu" lay-filter="layadmin-system-side-menu">
	            <li data-name="home" class="layui-nav-item layui-nav-itemed">
		              <a href="javascript:;" lay-tips="主页" lay-direction="2">
		                <i class="layui-icon layui-icon-home"></i>
		                <cite>主页</cite>
		              </a>
		              <dl class="layui-nav-child">
		                <dd data-name="console" class="layui-this">
		                  <a href="toConsoleAct"   target="mainFrame">控制台</a>
		                </dd>
		              </dl>
	            </li>
	            <li data-name="user" class="layui-nav-item">
		              <a href="javascript:;" lay-tips="用户" lay-direction="2">
		                <i class="layui-icon layui-icon-user"></i>
		                <cite>用户管理</cite>
		              </a>
		              <dl class="layui-nav-child">
			                <dd>
			                   <a href="adminPage" target="mainFrame">管理员列表</a>
			                </dd>
			                 <dd>
			                   <a href="teacherPage" target="mainFrame">教师列表</a>
			                </dd>
			                 <dd>
			                   <a href="stuPage" target="mainFrame">学生列表</a>
			                </dd>
		              </dl>
	            </li>
	            <li data-name="user" class="layui-nav-item">
		              <a href="javascript:;" lay-tips="用户" lay-direction="2">
		                <i class="layui-icon layui-icon-dollar"></i>
		                <cite>器材分类管理</cite>
		              </a>
		              <dl class="layui-nav-child">
			                <dd>
			                 
			                   <a href="catPage" target="mainFrame">器材分类列表</a>
			                </dd>
		              </dl>
	            </li>
	            <li data-name="user" class="layui-nav-item">
		              <a href="javascript:;" lay-tips="用户" lay-direction="2">
		                <i class="layui-icon layui-icon-note"></i>
		                <cite>公告管理</cite>
		              </a>
		              <dl class="layui-nav-child">
			                <dd>
			                  <a href="boardPage" target="mainFrame">公告列表</a>
			                </dd>
		              </dl>
	            </li>
	            <li data-name="user" class="layui-nav-item">
		              <a href="javascript:;" lay-tips="用户" lay-direction="2">
		                <i class="layui-icon layui-icon-survey"></i>
		                <cite>器材管理</cite>
		              </a>
		              <dl class="layui-nav-child">
			                <dd>
			                  <a href="equPage" target="mainFrame">器材列表</a>
			                </dd>
		              </dl>
	            </li>
	            
	             <li data-name="user" class="layui-nav-item">
		              <a href="javascript:;" lay-tips="用户" lay-direction="2">
		                <i class="layui-icon layui-icon-rmb"></i>
		                <cite>预约管理</cite>
		              </a>
		              <dl class="layui-nav-child">
			                <dd>
			                  <a href="appPage" target="mainFrame">预约列表</a>
			                </dd>
		              </dl>
	            </li>
	            <li data-name="set" class="layui-nav-item">
		              <a href="javascript:;" lay-tips="设置" lay-direction="2">
			                <i class="layui-icon layui-icon-set"></i>
			                <cite>个人信息</cite>
		              </a>
		              <dl class="layui-nav-child">
			                <dd><a href="findMyInfoAct?id=${admin.id }" target="mainFrame">修改个人资料</a></dd>
		              </dl>
		              <dl class="layui-nav-child">
			                <dd><a href="findMyLoginInfoAct?id=${admin.id }" target="mainFrame">修改登录信息</a></dd>
		              </dl>
	            </li>
	         
	          </ul>
	        </div>
	      </div>
	
	      <!-- 页面标签 -->
	      <div class="layadmin-pagetabs" id="LAY_app_tabs">
	        <div class="layui-icon layadmin-tabs-control layui-icon-down">
	        </div>
	      </div>
	      
	      
	      <!-- 主体内容 -->
	      <div class="layui-body" id="LAY_app_body">
	        <div class="layadmin-tabsbody-item layui-show">
	           <iframe src="toConsoleAct" id="mainFrame" name="mainFrame" style="width:100%;height:100%;"  frameborder="0" class="mainFrame"></iframe>
	        </div>
	      </div>
	      
	      <!-- 辅助元素，一般用于移动设备下遮罩 -->
	      <div class="layadmin-body-shade" layadmin-event="shade"></div>
	    </div>
	  </div>

	<script src="layui/layui.js"></script>
	<script>
	
		/* layui.use('element', function(){
		  var element = layui.element;
		  
		}); */
		 layui.config({
			    base: 'static/layuiadmin/' //静态资源所在路径
			  }).extend({
			    index: 'lib/index' //主入口模块
			  }).use('index');
	</script>
</body>
</html>