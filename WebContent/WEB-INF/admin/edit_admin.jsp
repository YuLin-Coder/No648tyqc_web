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
      <label class="layui-form-label">工号</label>
      <div class="layui-input-inline">
        <input type="text" name="eno" lay-verify="eno"id="eno" placeholder="请输入工号" autocomplete="off" class="layui-input" value="${admin.eno }">
      </div>
    </div>
  	<div class="layui-form-item">
	      <label class="layui-form-label">姓名</label>
	      <div class="layui-input-inline">
	        <input type="text" name="realname"id="realname" lay-verify="realname" placeholder="请输入姓名" autocomplete="off" class="layui-input" value="${admin.realname }">
	      </div>
    </div>
    
         <div class="layui-form-item">
             <label class="layui-form-label">头&emsp;像</label>
             <div class="layui-input-inline">
                 <div class="layui-input-inline uploadHeadImage">
			        <div class="layui-upload-drag" id="headImg">
			          <img class="layui-upload-img headImage" src="upload/${admin.photo }" id="demo1" style="width:130px;height:100%">
			            <p id="demoText"></p>
			            <p>点击上传图片</p>
			        </div>
			    </div>
        </div>
        
    </div>
   <input type="hidden" name="photo" id="photo" value="${admin.photo }"/>
            
     <div class="layui-form-item">
      <label class="layui-form-label">密码</label>
      <div class="layui-input-inline">
        <input type="text" name="pwd" id="pwd" placeholder="请输入密码" autocomplete="off" class="layui-input" value="${admin.pwd }">
      </div>
    </div>
      
    <div class="layui-form-item layui-hide">
      <input type="button" lay-submit lay-filter="LAY-user-front-submit" id="LAY-user-front-submit" value="确认">
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
	    var uploadInst = upload.render({
	    	
	        elem: '#headImg'
	        , url: '${pageContext.request.contextPath}/addPhotoAct'
	        ,method: 'post'
	        , size: 5000
	        , before: function (obj) {
	            //预读本地文件示例，不支持ie8
	            obj.preview(function (index, file, result) {
	                $('#demo1').attr('src', result); //图片链接（base64）
	            });
	        }
	        , done: function (res) {
	            //如果上传失败
	            if (res.code > 0) {
	                return layer.msg('上传失败');
	            }
	            //上传成功
	            //打印后台传回的地址: 把地址放入一个隐藏的input中, 和表单一起提交到后台, 此处略..
	            /*   console.log(res.data.src);*/
	            /* window.parent.uploadHeadImage(res.data.src); */
	            console.log(res.data.src);
	            $("#photo").val(res.data.src);
	            var demoText = $('#demoText');
	            demoText.html('<span style="color: #8f8f8f;">上传成功!!!</span>');
	        }
	        , error: function (res) {
                //演示失败状态，并实现重传
                var demoText = $('#demoText');
                demoText.html('<span style="color: #FF5722;">上传失败</span> <a class="layui-btn layui-btn-mini demo-reload">重试</a>');
                demoText.find('.demo-reload').on('click', function () {
                    uploadInst.upload();
                });
            }
	       
	    });
	 
	 

  });
		   

</script>
</body>
</html>