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
<meta charset="utf-8">
<title>体育器材管理系统</title>
<meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
<link rel="stylesheet" type="text/css" href="<%=path %>/static/layui/css/layui.css"> 
<link rel="stylesheet" href="<%=path %>/static/layui/css/modules/layer/default/layer.css"/>
<link rel="stylesheet" href="<%=path %>/static/css/global.css"/>

<script src="<%=path %>/static/js/jquery/jquery-2.1.4.min.js" type="text/javascript"></script>
<script src="<%=path %>/static/layui/layui.js" type="text/javascript"></script>
<script src="<%=path %>/static/js/index/index.js" type="text/javascript"></script>
<script src="<%=path %>/static/js/index/freezeheader.js" type="text/javascript"></script>
<script src="<%=path %>/static/layui/lay/modules/layer.js" type="text/javascript"></script>
<script src="<%=path %>/static/js/index/sliders.js" type="text/javascript"></script>
<script src="<%=path %>/static/js/index/html5.js" type="text/javascript"></script>
<script type="text/javascript">
$(function(){
	var oLi = document.getElementById("tab").getElementsByTagName("li");
	var oUl = document.getElementById("ms-main").getElementsByTagName("div");
	for(var i = 0; i < oLi.length; i++)
	{
		oLi[i].index = i;
		oLi[i].onmouseover = function ()
		{
			for(var n = 0; n < oLi.length; n++) oLi[n].className="";
			this.className = "cur";
			for(var n = 0; n < oUl.length; n++) oUl[n].style.display = "none";
			oUl[this.index].style.display = "block"
		}	
	}
});
</script>
<!--
-->
</head>
<body>
<div class="layui-header header">
  <div class="main">
    <ul class="layui-nav layui-nav-left" lay-filter="filter">
     <a class="fly-logo" href="javascript:void(0)" style="color: white;font-size:18px">
      		体育器材管理系统
    </a>
      <li class="layui-nav-item layui-this nav-left">
        <a href="webIndex">首页</a>
      </li>
      <li class="layui-nav-item">
        <a href="webNews">公告列表</a>
      </li>
      <li class="layui-nav-item">
        <a href="webProduct">洗衣项目列表</a>
      </li>
    <!--   <li class="layui-nav-item">
        <a href="time_line.html">相册</a>
      </li> -->
    </ul>
    <ul class="layui-nav layui-layout-right layui-nav-right" lay-filter="filter">

      <li class="layui-nav-item">
        <a href="toWebSetInfo">我的主页<span class="layui-badge-dot"></span></a>
      </li>
      <c:if test="${user eq null }">
      		 <li class="layui-nav-item">
		        <a href="toWebLogin"><img src="<%=path %>/static/images/head.jpg" class="layui-nav-img">登录</a>
		       
		      </li>
      </c:if>
        <c:if test="${user ne null }">
      <li class="layui-nav-item">
        <a href="javascript:;"><img src="upload/${user.tx }" class="layui-nav-img">${user.nickname}</a>
        <dl class="layui-nav-child">
          	<dd><a href="toWebSetInfo">修改信息</a></dd>
            <dd><a href="webLoginOut">退了</a></dd>
        </dl>
      </li>
        </c:if>
    </ul>
  </div>
</div>

<div class="layui-container container">
  <div class="layui-row layui-col-space20">
    <div class="layui-col-md8">
      <div class="carousel">
      </div>
      <div class="article-main">
        <h2>
          最新新闻推荐
        </h2>
		 <c:forEach items="${boards}" var="c">
	        <div class="article-list">
	          <figure><img lay-src="<%=path %>/static/images/02.jpg"></figure>
	          <ul>
	            <h3>
	              <a href="webNewsDetail?id=${c.id}">${c.title}</a>
	            </h3>
	            <p></p>
	            <p class="autor">
	              <span class="lm f_l"><a href="#">新闻公告</a></span>
	              <%-- <span class="dtime f_l">${c.create_time}</span> --%>
	          </ul>
	        </div>
 		</c:forEach>
      </div>
    </div>
    <div class="layui-col-md4">
        
      <div class="tuwen">
        <h3>比赛项目推荐</h3>
        <ul>
       <c:forEach items="${sports}" var="c">
          <li><a href="#"><img lay-src="upload/${c.photo }"><b>${c.name }</b></a>
            <p><span class="tutime">${c.createDate }</span></p>
          </li>
         </c:forEach>
        </ul>
      </div>
      <div class="ad"> <img lay-src="<%=path %>/static/images/03.jpg"> </div>
      <div class="links">
        <h3><span>[<a href="#">申请友情链接</a>]</span>友情链接</h3>
        <ul>
          <li><a href="#">web开发</a></li>
          <li><a href="#">前端设计</a></li>
          <li><a href="#">Html</a></li>
          <li><a href="#">CSS3</a></li>
          <li><a href="#">Html5+css3</a></li>
          <li><a href="#">百度</a></li>
        </ul>
      </div>
    </div>
  </div>
</div>
  <div class="fly-footer">
  <p> 2022 &copy; <a href="www.ymkz.top" >源码客栈制作</a></p>
  <p>
  
  </p>
</div>
</body>
</html>
