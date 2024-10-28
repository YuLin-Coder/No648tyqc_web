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
<meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
<link rel="stylesheet" href="<%=path %>/static/res/layui/css/layui.css">
  <link rel="stylesheet" href="<%=path %>/static/res/css/global.css">
</head>
<body>


      <jsp:include   page="header.jsp" flush="true"/> 

<div class="layui-container fly-marginTop">
  <div class="fly-panel fly-panel-user" pad20>
    <div class="layui-tab layui-tab-brief" lay-filter="user">
      <ul class="layui-tab-title">
        <li><a href="toWebLoginstu">学生端登入</a></li>
        <li class="layui-this">学生端注册</li>
      </ul>
      <div class="layui-form layui-tab-content" id="LAY_ucm" style="padding: 20px 0;">
        <div class="layui-tab-item layui-show">
          <div class="layui-form layui-form-pane">
            <form action="<%=path %>/webRegister" method="post" onSubmit="return tijiao(this)" id="loginForm" name="loginForm">
              <div class="layui-form-item">
                <label for="L_email" class="layui-form-label">学号</label>
                <div class="layui-input-inline">
                  <input type="text" id="stuno" name="stuno" required  lay-verify="required" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-mid layui-word-aux">将会成为您唯一的登入名</div>
              </div>
              <div class="layui-form-item">
                <label for="L_username" class="layui-form-label">昵称</label>
                <div class="layui-input-inline">
                  <input type="text" id="nickname" name="nickname" required lay-verify="required" autocomplete="off" class="layui-input">
                </div>
              </div>
              <div class="layui-form-item">
                <label for="L_username" class="layui-form-label">真实姓名</label>
                <div class="layui-input-inline">
                  <input type="text" id="realname" name="realname" required lay-verify="required" autocomplete="off" class="layui-input">
                </div>
              </div>
              <div class="layui-form-item">
                <label for="L_username" class="layui-form-label">手机号</label>
                <div class="layui-input-inline">
                  <input type="text" id="phone" name="phone" required lay-verify="required" autocomplete="off" class="layui-input">
                </div>
              </div>
              <div class="layui-form-item">
                <label for="L_pass" class="layui-form-label">密码</label>
                <div class="layui-input-inline">
                  <input type="password" id="pwd" name="pwd" required lay-verify="required" autocomplete="off" class="layui-input">
                </div>
              </div>
               <span id="error2" style="color:red">${msg}</span>
              <div class="layui-form-item">
                <button class="layui-btn" lay-filter="*" lay-submit>立即注册</button>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>

</div>
<div class="fly-footer">
  <p><a href="http://fly.layui.com/" target="_blank">体育器材预约管理系统</a> 2022 &copy; <a href="javascript:void(0)" >layui.com 出品</a></p>
  <p>
  
  </p>
</div>

	


<script src="<%=path %>/layui/layui.js"></script>
<script>

layui.use([ 'form','jquery','layer' ], function() {
	var form = layui.form,
	 layer = layui.layer,
	 $= layui.jquery;
	 form.render();//这句一定要加，占坑

	 
	
	  
	 $('#denglu').click(function(){  
		  var $1 = $.trim($('#phone').val());
		  var $2 = $.trim($("#pwd").val());
		     if($1 == ''){  
		         layer.msg('手机号不能为空',function() {time:2000}); 
		         return false;  
		     }
		     if($2 == ''){  
		         layer.msg('密码不能为空',function() {time:2000}); 
		         return false;  
		     }
	})
	 
   

});
</script>
</body>
</html>