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
<style type="text/css">
        .layui-table-cell {
            height: auto;
            line-height: 60px;
        }
    </style>
</head>
<body>

 <div class="layui-col-md12">
       <div class="layui-card">
       		 <div class="layui-form layui-card-header layuiadmin-card-header-auto">
		        <div class="layui-form-item">
		          <div class="layui-inline">
		            <label class="layui-form-label">工号</label>
		            <div class="layui-input-inline">
		              <input type="text" name="tno" id="tno" placeholder="请输入工号" autocomplete="off" class="layui-input">
		            </div>
		          </div>
		          <div class="layui-inline">
		            <label class="layui-form-label">姓名</label>
		            <div class="layui-input-inline">
		              <input type="text" name="name" id="name" placeholder="请输入姓名" autocomplete="off" class="layui-input">
		            </div>
		          </div>
		          <div class="layui-inline">
		            <button class="layui-btn layuiadmin-btn-list" lay-submit lay-filter="LAY-app-contlist-search" id="query">
		              <i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
		            </button>
		          </div>
		        </div>
		   </div>
          <div class="layui-card-body">
           <div style="padding-bottom: 10px;">
	          <button class="layui-btn layuiadmin-btn-useradmin" data-type="add" onclick="add()">添加</button>
	        </div>
           <div class="layui-row ">
                <table id="demo" lay-filter="test"></table>
            </div>
			 <script type="text/html" id="barDemo">
    				<a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    				<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
			</script>
          
          </div>
        </div>
      </div>

<script src="layui/layui.js"></script>
 <script>
 
  layui.use(['layer','form','table','jquery'], function () {//调用layui组件
		var form = layui.form;
   		var layer=layui.layer;
   		var table=layui.table;
	    $=layui.jquery;  
	    
	    table.render({
            elem: '#demo'  //绑定table id
            	,url: '${pageContext.request.contextPath}/selectTrData' //数据接口
            , cellMinWidth: 80
            ,cols: [[ //表头
	           /*  {field: 'id', title: 'ID'	}
	            , */{field: 'name', title: '姓名'}
	            ,{field: 'tno', title: '工号'}
	            ,{field: 'photo', title: '头像', templet:function(data){
	            	 return '<img class="XXX" src=upload/'+data.photo+' style="height:60px">'	
	            }
	            }
	            
	            ,{field: 'sex', title: '性别'}
	            ,{field: 'age', title: '年龄'}
	            ,{field: 'education', title: '学历'}
	            ,{field: 'insitute', title: '所属学院'}
	            ,{field: 'job', title: '职位'}
	            ,{field: 'note', title: '简介'}
	            ,{field: 'phone', title: '手机号'}
	            
	            ,{fixed: 'right', title: '操作', align:'center',width:'15%', toolbar: '#barDemo'}
	        ]]
            , page: true   //开启分页
            , limit: 10   //默认十条数据一页
            , limits: [10, 20, 30, 50]  //数据分页条
            , id: 'testReload'
        });
	    $("#query").click(function(){
	    	var tno = $("#tno").val();
	    	var name = $("#name").val();
		    table.reload('testReload', {
	            where: {
	            	tno: tno,
	            	name:name
	            }
	        });
	    })
	    table.on('tool(test)',function (obj) { //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
	        var data = obj.data; //获得当前行数据
	        var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
	        var tr = obj.tr; //获得当前行 tr 的DOM对象
	        if (layEvent === 'del'){
	            layer.confirm('真的删除行么', function(index){
	            	  del(data.id);
	                //向服务端发送删除指令
	            });
	        }else if(layEvent === 'edit'){
	            edit(data.id);
	        }
	    });
	 	function del(id){
			 $.ajax({
				  type: 'POST',
				  url: '${pageContext.request.contextPath}/delTrInfo',
				  data: {"id":id},
				  /* dataType: "json", */
				  success:function(req){
					        //请求成功时处理
					        if(req=='ok'){
					        	layer.closeAll();
					        	//window.location.reload();
					        	  table.reload('testReload'); //数据刷新
					        }else{
					        	layer.alert("请先登录");
					        }
				 },
				  error:function(req){
				         //请求出错处理
						console.log(req);
					      }
			});
	 }
	 	
	 	
	 	function edit(id){
	 		layer.open({
	 	          type: 2
	 	          ,title: '修改用户'
	 	          ,content: '${pageContext.request.contextPath}/toEditTrAct?id='+id
	 	          ,maxmin: true
	 	          ,area: ['500px', '450px']
	 	          ,btn: ['确定', '取消']
	 	          ,yes: function(index, layero){
	 	           // alert("1111");
	 	        	//当点击‘确定'按钮的时候，获取弹出层返回的值
	 	        	var body = layer.getChildFrame('body', index); //得到iframe页的body内容
	 	        	var tno = body.find("#tno").val();
		        	var name = body.find("#name").val();
		        	var pwd = body.find("#pwd").val();
		        	var photo = body.find("#photo").val();
		        	var sex = body.find("input[name='sex']:checked").val();
		        	var age = body.find("#age").val();
		        	var education = body.find("#education").val();
		        	var insitute = body.find("#insitute").val();
		        	var job = body.find("#job").val();
		        	var note = body.find("#note").val();
		        	var phone = body.find("#phone").val();
	 	        //	var money = body.find("#money").val();
	 	        	$.ajax({
	 					  type: 'POST',
	 					  url: '${pageContext.request.contextPath}/editTrInfo',
	 					  data: {id:id,tno:tno,name:name,pwd:pwd,photo:photo,sex:sex,age:age,education:education,insitute:insitute,job:job,note:note,phone:phone},
	 					  /* dataType: "json", */
	 					  success:function(req){
	 						        //请求成功时处理
	 						        if(req=='success'){
	 						        	layer.alert("操作成功");
	 						        	layer.closeAll();
	 						        	//window.location.reload();
	 						        	  table.reload('testReload'); //数据刷新
	 						        }else if(req =='repeat'){
	 						        	layer.alert("工号重复");
	 						        }else{
	 						        	layer.alert("服务器错误，请重试");
	 						        }
	 					 },
	 					  error:function(req){
	 					         //请求出错处理
	 							console.log(req);
	 						      }
	 				});
	 	        	
	 	        	
	 	          }
	 	        });
	 	}
	  
  });
  function add(){
		layer.open({
	          type: 2
	          ,title: '添加教师'
	          ,content: '${pageContext.request.contextPath}/toAddTrAct'
	          ,maxmin: true
	          ,area: ['500px', '450px']
	          ,btn: ['确定', '取消']
	          ,yes: function(index, layero){
	           // alert("1111");
	        	//当点击‘确定'按钮的时候，获取弹出层返回的值
	        	var body = layer.getChildFrame('body', index); //得到iframe页的body内容
	        	var tno = body.find("#tno").val();
	        	var name = body.find("#name").val();
	        	var pwd = body.find("#pwd").val();
	        	var photo = body.find("#photo").val();
	        	var sex = body.find("input[name='sex']:checked").val();
	        	var age = body.find("#age").val();
	        	var education = body.find("#education").val();
	        	var insitute = body.find("#insitute").val();
	        	var job = body.find("#job").val();
	        	var note = body.find("#note").val();
	        	var phone = body.find("#phone").val();
	        	
	        	$.ajax({
					  type: 'POST',
					  url: '${pageContext.request.contextPath}/addTrInfo',
					  data: {tno:tno,name:name,pwd:pwd,photo:photo,sex:sex,age:age,education:education,insitute:insitute,job:job,note:note,phone:phone},
					  /* dataType: "json", */
					  success:function(req){
					        //请求成功时处理
					        if(req=='success'){
					        	layer.alert("操作成功");
					        	window.location.href= '${pageContext.request.contextPath}/teacherPage';
					        }else if(req=='repeat'){
					        	layer.alert("工号重复");
					        }else{
					        	layer.alert("服务器错误，请重试");
					        }
					 },
					  error:function(req){
					         //请求出错处理
							console.log(req);
						      }
				});
	        	
	        	
	          }
	        });
	}
  </script>      
</body>
</html>