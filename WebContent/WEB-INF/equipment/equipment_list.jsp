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
		            <label class="layui-form-label">器材名称</label>
		            <div class="layui-input-inline">
		              <input type="text" name="title" id="title" placeholder="器材名称" autocomplete="off" class="layui-input">
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
					{{#  if(d.status == '2'){ }}
					<a class="layui-btn layui-btn-xs" lay-event="state">更改可预约</a>
					{{# } }}
					{{#  if(d.status == '1'){ }}
					<a class="layui-btn layui-btn-xs" lay-event="nostate">更改不可预约</a>
					{{# } }}
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
            	,url: '${pageContext.request.contextPath}/selectequData' //数据接口
            , cellMinWidth: 80
            ,cols: [[ //表头
	            /* {field: 'id', title: 'ID'	} */
	            /* , */{field: 'qcbh', title: '器材编号'}
	            ,{field: 'title', title: '器材名称'}
	            ,{field: 'category', title: '分类'}
	            ,{field: 'detail', title: '器材描述'}
	            ,{field: 'photo', title: '器材图片', templet:function(data){
	            	 return '<img class="XXX" src=upload/'+data.photo+' style="height:60px">'	
	            }
	            }
	            
	            ,{field: 'stock', title: '库存数量'}
	            ,{field: 'price', title: '器材价格'}
	            ,{field: 'create_date', title: '发布日期'}
	            ,{field: 'status', title: '租赁状态',templet:function(data){
	            	if(data.status == '1'){
	            		return '可预约';
	            	}else{
	            		return '不可预约';
	            	}
	            }
	            }
	            ,{field: 'admin', title: '器材管理员姓名'}
	            ,{field: 'address', title: '器材地址'}
	            ,{field: 'note', title: '备注'}
	            
	            ,{fixed: 'right', title: '操作', align:'center',width:'20%', toolbar: '#barDemo'}
	        ]]
            , page: true   //开启分页
            , limit: 10   //默认十条数据一页
            , limits: [10, 20, 30, 50]  //数据分页条
            , id: 'testReload'
        });
	    $("#query").click(function(){
	    	var title = $("#title").val();
		    table.reload('testReload', {
	            where: {
	            	title: title
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
	        }else if(layEvent == 'state'){
	        	 layer.confirm('确定更改状态吗', function(index){
	        		 state(data.id,1);
	                //向服务端发送删除指令
	            });
	        }else if(layEvent == 'nostate'){
	        	layer.confirm('确定更改状态吗', function(index){
	        		state(data.id,2);
	                //向服务端发送删除指令
	            });
	        }
	    });
	 	function del(id){
			 $.ajax({
				  type: 'POST',
				  url: '${pageContext.request.contextPath}/delequInfo',
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
	 	function state(id,state){
			 $.ajax({
				  type: 'POST',
				  url: '${pageContext.request.contextPath}/stateequInfo',
				  data: {"id":id,status:state},
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
	 	          ,content: '${pageContext.request.contextPath}/toEditequAct?id='+id
	 	          ,maxmin: true
	 	          ,area: ['500px', '450px']
	 	          ,btn: ['确定', '取消']
	 	          ,yes: function(index, layero){
	 	           // alert("1111");
	 	        	//当点击‘确定'按钮的时候，获取弹出层返回的值
	 	        	var body = layer.getChildFrame('body', index); //得到iframe页的body内容
	 	        	var qcbh = body.find("#qcbh").val();
		        	var title = body.find("#title").val();
		        	var	category_id = body.find("#category_id").val();
		        	var detail = body.find("#detail").val();
		        	var photo = body.find("#photo").val();
		        	var stock = body.find("#stock").val();
		        	var price = body.find("#price").val();
		        	var address = body.find("#address").val();
		        	var note = body.find("#note").val();
	 	        	$.ajax({
	 					  type: 'POST',
	 					  url: '${pageContext.request.contextPath}/editequInfo',
	 					  data: {id:id,qcbh:qcbh,title:title,category_id:category_id,detail:detail,photo:photo,stock:stock,price:price,address:address,note:note},
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
	          ,title: '添加学生'
	          ,content: '${pageContext.request.contextPath}/toAddequAct'
	          ,maxmin: true
	          ,area: ['500px', '450px']
	          ,btn: ['确定', '取消']
	          ,yes: function(index, layero){
	           // alert("1111");
	        	//当点击‘确定'按钮的时候，获取弹出层返回的值
	        	var body = layer.getChildFrame('body', index); //得到iframe页的body内容
	        	var qcbh = body.find("#qcbh").val();
	        	var title = body.find("#title").val();
	        	var	category_id = body.find("#category_id").val();
	        	var detail = body.find("#detail").val();
	        	var photo = body.find("#photo").val();
	        	var stock = body.find("#stock").val();
	        	var price = body.find("#price").val();
	        	var address = body.find("#address").val();
	        	var note = body.find("#note").val();
	        	
	        	$.ajax({
					  type: 'POST',
					  url: '${pageContext.request.contextPath}/addequInfo',
					  data: {qcbh:qcbh,title:title,category_id:category_id,detail:detail,photo:photo,stock:stock,price:price,address:address,note:note},
					  /* dataType: "json", */
					  success:function(req){
					        //请求成功时处理
					        if(req=='success'){
					        	layer.alert("操作成功");
					        	window.location.href= '${pageContext.request.contextPath}/equPage';
					        }else if(req=='repeat'){
					        	layer.alert("重复");
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