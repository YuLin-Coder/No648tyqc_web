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
		            <label class="layui-form-label">编号</label>
		            <div class="layui-input-inline">
		              <input type="text" name="order_no" id="order_no" placeholder="请输入编号" autocomplete="off" class="layui-input">
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
           <div class="layui-row ">
                <table id="demo" lay-filter="test"></table>
            </div>
			 <script type="text/html" id="barDemo">
					{{#  if(d.status == '2'){ }}
					<a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="state">通过</a>
					<a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="nostate">拒绝</a>
					{{# } }}
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
            	,url: '${pageContext.request.contextPath}/selectappData' //数据接口
            , cellMinWidth: 80
            ,cols: [[ //表头
	            {field: 'id', title: 'ID'	}
	            ,{field: 'order_no', title: '预约编号'}
	            ,{field: 'ename', title: ' 器材名称'}
	            ,{field: 'quantity', title: '器材数量'}
	            ,{field: 'stuno_or_tno', title: '学/工'}
	            ,{field: 'create_date', title: '预约时间'}
	            ,{field: 'start_time', title: '开始时间'}
	            ,{field: 'end_time', title: '结束时间'}
	            ,{field: 'status', title: '预约状态',templet:function(data){
	            	if(data.status == '0'){
	            		return '预约失败';
	            	}else if(data.status == '1'){
	            		return '预约成功';
	            	}else{
	            		return '预约中';
	            	}
	            		}}
	            ,{field: 'state', title: '老师or学生',templet:function(data){
	            	if(data.state == '1'){
	            		return '学生';
	            	}else{
	            		return '老师';
	            	}
	            	}}
	            ,{field: 'code', title: '器材状态',templet:function(data){
	            	if(data.code == '0'){
	            		return '未归还';
	            	}else{
	            		return '已归还';
	            	}
	            	}}
	            
	            ,{fixed: 'right', title: '操作', align:'center',width:'20%', toolbar: '#barDemo'}
	        ]]
            , page: true   //开启分页
            , limit: 10   //默认十条数据一页
            , limits: [10, 20, 30, 50]  //数据分页条
            , id: 'testReload'
        });
	    $("#query").click(function(){
	    	var order_no = $("#order_no").val();
		    table.reload('testReload', {
	            where: {
	            	order_no: order_no
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
	        	 layer.confirm('确定审核通过吗', function(index){
	        		 state(data.id,1);
	                //向服务端发送删除指令
	            });
	        }else if(layEvent == 'nostate'){
	        	layer.confirm('确定审核不通过吗', function(index){
	        		state(data.id,0);
	                //向服务端发送删除指令
	            });
	        }
	    });
	    
	    function state(id,state){
			 $.ajax({
				  type: 'POST',
				  url: '${pageContext.request.contextPath}/stateAppInfo',
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
	    
	 	function del(id){
			 $.ajax({
				  type: 'POST',
				  url: '${pageContext.request.contextPath}/delappInfo',
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
	 	          ,content: '${pageContext.request.contextPath}/toEditstuAct?id='+id
	 	          ,maxmin: true
	 	          ,area: ['500px', '450px']
	 	          ,btn: ['确定', '取消']
	 	          ,yes: function(index, layero){
	 	           // alert("1111");
	 	        	//当点击‘确定'按钮的时候，获取弹出层返回的值
	 	        	var body = layer.getChildFrame('body', index); //得到iframe页的body内容
	 	        	var stuno = body.find("#stuno").val();
		        	var realname = body.find("#realname").val();
		        	var	nickname = body.find("#nickname").val();
		        	var pwd = body.find("#pwd").val();
		        	var photo = body.find("#photo").val();
		        	var sex = body.find("input[name='sex']:checked").val();
		        	var phone = body.find("#phone").val();
		        	var major = body.find("#major").val();
		        	var bj = body.find("#bj").val();
		        	var grade = body.find("#grade").val();
	 	        	$.ajax({
	 					  type: 'POST',
	 					  url: '${pageContext.request.contextPath}/editstuInfo',
	 					  data: {id:id,stuno:stuno,realname:realname,nickname:nickname,pwd:pwd,photo:photo,sex:sex,phone:phone,major:major,bj:bj,grade:grade},
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
	          ,content: '${pageContext.request.contextPath}/toAddstuAct'
	          ,maxmin: true
	          ,area: ['500px', '450px']
	          ,btn: ['确定', '取消']
	          ,yes: function(index, layero){
	           // alert("1111");
	        	//当点击‘确定'按钮的时候，获取弹出层返回的值
	        	var body = layer.getChildFrame('body', index); //得到iframe页的body内容
	        	var stuno = body.find("#stuno").val();
	        	var realname = body.find("#realname").val();
	        	var	nickname = body.find("#nickname").val();
	        	var pwd = body.find("#pwd").val();
	        	var photo = body.find("#photo").val();
	        	var sex = body.find("input[name='sex']:checked").val();
	        	var phone = body.find("#phone").val();
	        	var major = body.find("#major").val();
	        	var bj = body.find("#bj").val();
	        	var grade = body.find("#grade").val();
	        	
	        	$.ajax({
					  type: 'POST',
					  url: '${pageContext.request.contextPath}/addstuInfo',
					  data: {stuno:stuno,realname:realname,nickname:nickname,pwd:pwd,photo:photo,sex:sex,phone:phone,major:major,bj:bj,grade:grade},
					  /* dataType: "json", */
					  success:function(req){
					        //请求成功时处理
					        if(req=='success'){
					        	layer.alert("操作成功");
					        	window.location.href= '${pageContext.request.contextPath}/stuPage';
					        }else if(req=='repeat'){
					        	layer.alert("学号重复");
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