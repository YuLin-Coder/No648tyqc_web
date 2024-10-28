<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
    <link rel="stylesheet" href="<%=path %>/static/layuiadmin/layui/css/layui.css" media="all">
  <link rel="stylesheet" href="<%=path %>/static/layuiadmin/style/admin.css" media="all">
</head>
<body>
  
  <div class="layui-fluid">
    <div class="layui-row layui-col-space15">
      <div class="layui-col-md8">
        <div class="layui-row layui-col-space15">
          <div class="layui-col-md12">
            <div class="layui-card">
              <div class="layui-card-header">营业数据</div>
              <div class="layui-card-body">

                <div class="layui-carousel layadmin-carousel layadmin-backlog">
                  <div carousel-item>
                    <ul class="layui-row layui-col-space10">
                      <li class="layui-col-xs6">
                        <a lay-href="app/content/comment.html" class="layadmin-backlog-body">
                          <h3>本月单数</h3>
                          <p><cite>${monthNum }</cite></p>
                        </a>
                      </li>
                      <li class="layui-col-xs6">
                        <a lay-href="app/forum/list.html" class="layadmin-backlog-body">
                          <h3>本月金额</h3>
                          <p><cite>${monthPrice }</cite></p>
                        </a>
                      </li>
                      <li class="layui-col-xs6">
                        <a lay-href="template/goodslist.html" class="layadmin-backlog-body">
                          <h3>累计单数</h3>
                          <p><cite>${allNum }</cite></p>
                        </a>
                      </li>
                      <li class="layui-col-xs6">
                        <a href="javascript:;" onclick="layer.tips('不跳转', this, {tips: 3});" class="layadmin-backlog-body">
                          <h3>累计金额</h3>
                          <p><cite>${allPrice }</cite></p>
                        </a>
                      </li>
                    </ul>
                  </div>
                </div>
              </div>
            </div>
          </div>
          
        </div>
      </div>
      
      <div class="layui-col-md4">
        <div class="layui-card">
          <div class="layui-card-header">新闻列表</div>
          <div class="layui-card-body layui-text">
            <table class="layui-table">
              <colgroup>
                <col width="100">
                <col>
              </colgroup>
              <tbody>
              	 <c:forEach items="${list }" var="l">
			          <tr>
				         <td> ${l.title }</td>
				       </tr>
			        </c:forEach>
              </tbody>
            </table>
          </div>
        </div>
        
        
        

      </div>
      
    </div>
  </div>
<script src="<%=path %>/js/jquery-3.3.1.js"></script>
  <script src="<%=path %>/static/layuiadmin/layui/layui.js?t=1"></script>  
    <script>
  layui.config({
    base: '<%=path %>/static/layuiadmin/' //静态资源所在路径
  }).extend({
    index: 'lib/index' //主入口模块
  }).use(['index', 'console']);
  </script>
</body>
</html>

