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
<title>体育器材预约管理系统</title>
  <link rel="stylesheet" href="<%=path %>/static/res/layui/css/layui.css">
  <link rel="stylesheet" href="<%=path %>/static/res/css/global.css">
  <style>
 	 .header{border-bottom: 1px solid #404553; border-right: 1px solid #404553;}
  </style>
</head>
<body>
   <jsp:include   page="header.jsp" flush="true"/> 

<div class="layui-hide-xs">
  <div class="fly-panel fly-column">
  </div>
</div>

<div class="layui-container">
  <div class="layui-row layui-col-space15">
    <div class="layui-col-md12 content detail">
      <div class="fly-panel detail-box">
        <h1>公告名称：${board.title}</h1>
     <%--<div class="fly-detail-info">
          <span class="layui-badge">宠物类别：${category.name}</span>
          <span class="layui-badge layui-bg-green fly-detail-column">动态</span>
          
          <span class="layui-badge" style="background-color: #999;">未结</span>
          <span class="layui-badge" style="background-color: #5FB878;">已结</span>
          
          <span class="layui-badge layui-bg-black">置顶</span>
          <span class="layui-badge layui-bg-red">精帖</span>
          
          <div class="fly-admin-box" data-id="123">
            <span class="layui-btn layui-btn-xs jie-admin" type="del">删除</span>
            
            <span class="layui-btn layui-btn-xs jie-admin" type="set" field="stick" rank="1">置顶</span> 
            <span class="layui-btn layui-btn-xs jie-admin" type="set" field="stick" rank="0" style="background-color:#ccc;">取消置顶</span>
            
            <span class="layui-btn layui-btn-xs jie-admin" type="set" field="status" rank="1">加精</span> 
            <span class="layui-btn layui-btn-xs jie-admin" type="set" field="status" rank="0" style="background-color:#ccc;">取消加精</span>
          </div>
          <span class="fly-list-nums"> 
            <a href="#comment"><i class="iconfont" title="回答">&#xe60c;</i> 66</a>
            <i class="iconfont" title="人气">&#xe60b;</i> 99999
          </span>
        </div>--%>
        <div class="detail-about">
          <a class="fly-avatar" href="../user/home.html">
            <img src="<%=path%>/upload/${admin.photo}">
          </a>
          <div class="fly-detail-user">
            <a href="../user/home.html" class="fly-link">
              <cite>发布者：${admin.realname}</cite>
             <i class="iconfont icon-renzheng" title="认证信息：{{ rows.user.approve }}"></i>
            <!--   <i class="layui-badge fly-badge-vip">VIP3</i> -->
            </a>
            <span>发布时间：${board.fbsj}</span>
          </div>
         <div class="detail-hits" id="LAY_jieAdmin" data-id="123">
            <%--<span cstyle="padding-right: 10px; color: #FF7200">悬赏：60飞吻</span>  --%>
         
          </div>
        </div>
        <div class="detail-body photos">
           <p>公告内容:${board.content}</p>



        </div>
      </div>

    </div>




</div>
</div>
<input type="hidden" id="id" value="${id }">
<div class="fly-footer">
<p> 2022 &copy; <a href="javascript:void(0)" >xxx制作</a></p>
  <p>
  
  </p>
</div>
<script src="<%=path %>/js/jquery-3.3.1.js"></script>
<script src="<%=path %>/static/res/layui/layui.js"></script>
<script src="layui/layui.js"></script>
 <script type="text/javascript">
 layui.use(['layer','form','table','jquery'], function () {//调用layui组件
		var form = layui.form;
		var layer=layui.layer;
		var table=layui.table;
	    $=layui.jquery;  
	    
	 	
	  
});
	    

    </script>

</body>
</html>