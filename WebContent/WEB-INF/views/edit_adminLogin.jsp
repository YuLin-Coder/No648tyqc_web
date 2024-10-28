
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
<title>校运动会后台管理系统</title>
<link rel="stylesheet" type="text/css" href="<%=path %>/layui/css/layui.css"> 
<link rel="stylesheet" type="text/css" href="<%=path %>/layui/css/admin.css"> 
<link rel="stylesheet" type="text/css" href="<%=path %>/layui/css/login.css">  
</head>
<body>

 
  <div class="layui-fluid">
    <div class="layui-row layui-col-space15">
      <div class="layui-col-md12">
        <div class="layui-card">
          <div class="layui-card-header">我的登录信息</div>
          <div class="layui-card-body" pad15>
             <div  >
         		  <input type="hidden" name="id" id="id" value="${admin.id }" />
         		  
            	  <div class="layui-form-item">
	                <label class="layui-form-label">工号</label>
	                <div class="layui-input-inline">
	                  <input type="text" name="eno"  value="${admin.eno}" id="eno" lay-verify="required" lay-verType="tips" class="layui-input" readonly>
	                </div>
	              </div> 
	              
	               <div class="layui-form-item">
	                <label class="layui-form-label">密&emsp;码</label>
	                <div class="layui-input-inline">
	                  <input type="password" name="pwd"  value="${admin.pwd}" id="pwd"  value=" "  lay-verify="required" lay-verType="tips" class="layui-input">
	                </div>
	              </div> 
              
	              <br>
	              <div class="layui-form-item">
	                <div class="layui-input-block">
	     				<button class="layui-btn" type="submit" id="update">确认修改</button>
	           
	                </div>
	              </div>
              </div>
            </div>
            
            
          </div>
        </div>
      </div>
    </div>
		
	


<script src="<%=path %>/layui/layui.js"></script>
<script>

	layui.use([ 'form',"upload",  'jquery','layer',"element" ], function() {
		var form = layui.form,
		 layer = layui.layer,
		 $= layui.jquery;
		 upload = layui.upload,
		 form.render();//这句一定要加，占坑
		 //拖拽上传
		 
		 
		 $('#update').click(function(){  
			  var phone = $.trim($("#phone").val());
			  var pwd = $.trim($("#pwd").val());
			/*   if(phone==""){
					layer.msg('工号不允许为空',function() {time:2000}); 
					$("#phone").css("border","1px solid red");
					return false;  
					
		  		} */
			  
			  if(pwd==""){
					layer.msg('密码不允许为空',function() {time:2000}); 
					$("#pwd").css("border","1px solid red");
					return false;  
		  		}
			  
			  $.ajax({
				  type: 'POST',
				  url: '${pageContext.request.contextPath}/updateAdminLoginAct',
				  data: {pwd:pwd},
				  success:function(result){
					  console.log(result)
					  if(result == 'success'){
		    			  alert("修改成功！");
		    			  top.window.location.href='${pageContext.request.contextPath}/toLoginOutAct';
					  }else if(result == 'repeat'){
						  alert("手机号重复！");
					  }else{
						  alert("请先登录！");
					  }
				 },
				  error:function(req){
				         //请求出错处理
						console.log(req);
					      }
				});
		})  
	    
	
	  });
	  

	 
   


</script>
</body>
</html>