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
		              <input type="text" name="eno" id="eno" placeholder="请输入工号" autocomplete="off" class="layui-input">
		            </div>
		          </div>
		          <div class="layui-inline">
		            <label class="layui-form-label">姓名</label>
		            <div class="layui-input-inline">
		              <input type="text" name="realname" id="realname" placeholder="请输入姓名" autocomplete="off" class="layui-input">
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
					{{#  if(d.state == 0){ }}
    				<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
					{{# } }}
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
            	,url: '${pageContext.request.contextPath}/selectAminData' //数据接口
            , cellMinWidth: 80
            ,cols: [[ //表头
	            {field: 'id', title: 'ID'	}
	            ,{field: 'realname', title: '姓名'}
	            ,{field: 'eno', title: '工号'}
	            ,{field: 'photo', title: '头像', templet:function(data){
	            	 return '<img class="XXX" src=upload/'+data.photo+' style="height:60px">'	
	            }
	            }
	            ,{fixed: 'right', title: '操作', align:'center', toolbar: '#barDemo'}
	        ]]
            , page: true   //开启分页
            , limit: 10   //默认十条数据一页
            , limits: [10, 20, 30, 50]  //数据分页条
            , id: 'testReload'
        });
	    $("#query").click(function(){
	    	var eno = $("#eno").val();
	    	var realname = $("#realname").val();
		    table.reload('testReload', {
	            where: {
	            	eno: eno,
	            	realname:realname
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
				  url: '${pageContext.request.contextPath}/delAminInfo',
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
	 	          ,content: '${pageContext.request.contextPath}/toEditAminAct?id='+id
	 	          ,maxmin: true
	 	          ,area: ['500px', '450px']
	 	          ,btn: ['确定', '取消']
	 	          ,yes: function(index, layero){
	 	           // alert("1111");
	 	        	//当点击‘确定'按钮的时候，获取弹出层返回的值
	 	        	var body = layer.getChildFrame('body', index); //得到iframe页的body内容
	 	        	var realname = body.find("#realname").val();
	 	        	var eno = body.find("#eno").val();
	 	        	var pwd = body.find("#pwd").val();
	 	          	var photo = body.find("#photo").val();
	 	        	$.ajax({
	 					  type: 'POST',
	 					  url: '${pageContext.request.contextPath}/editAdminInfo',
	 					  data: {"id":id,realname:realname,eno:eno,pwd:pwd,photo:photo},
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
	          ,title: '添加管理员'
	          ,content: '${pageContext.request.contextPath}/toAddAdminAct'
	          ,maxmin: true
	          ,area: ['500px', '450px']
	          ,btn: ['确定', '取消']
	          ,yes: function(index, layero){
	           // alert("1111");
	        	//当点击‘确定'按钮的时候，获取弹出层返回的值
	        	var body = layer.getChildFrame('body', index); //得到iframe页的body内容
	        	var eno = body.find("#eno").val();
	        	var realname = body.find("#realname").val();
	        	var pwd = body.find("#pwd").val();
	        	var photo = body.find("#photo").val();
	        	$.ajax({
					  type: 'POST',
					  url: '${pageContext.request.contextPath}/addAdminInfo',
					  data: {eno:eno,realname:realname,pwd:pwd,photo:photo},
					  /* dataType: "json", */
					  success:function(req){
					        //请求成功时处理
					        if(req=='success'){
					        	layer.alert("操作成功");
					        	window.location.href= '${pageContext.request.contextPath}/adminPage';
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