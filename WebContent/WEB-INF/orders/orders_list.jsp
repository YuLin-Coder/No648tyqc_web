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
</head>
<body>

 <div class="layui-col-md12">
       <div class="layui-card">
       		 <div class="layui-form layui-card-header layuiadmin-card-header-auto">
		        <div class="layui-form-item">
		          <div class="layui-inline">
		            <label class="layui-form-label">订单编号</label>
		            <div class="layui-input-inline">
		              <input type="text" name="order_no" id="order_no" placeholder="请输入订单编号" autocomplete="off" class="layui-input">
		            </div>
		          </div>
		          <div class="layui-inline">
		            <label class="layui-form-label">下单人</label>
		            <div class="layui-input-inline">
		              <input type="text" name="nickname" id="nickname" placeholder="请输入下单人" autocomplete="off" class="layui-input">
		            </div>
		          </div>
		          <div class="layui-inline">
		            <button class="layui-btn layuiadmin-btn-list" lay-submit lay-filter="LAY-app-contlist-search" id="query2">
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
{{#  if(d.state == 0 && d.status !=0){ }}
    				<a class="layui-btn layui-btn-xs" lay-event="edit">完成订单</a>
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
            	,url: '${pageContext.request.contextPath}/selectOrdersData' //数据接口
            , cellMinWidth: 80
            ,cols: [[ //表头
	           /*  {field: 'id', title: 'ID',align:'center'}
	            , */{field: 'order_no', title: '订单编号', align:'center'}
	            ,{field: 'nickname', title: '下单人', align:'center'}
	            ,{field: 'pname', title: '洗衣价格服务', align:'center'}
	            ,{field: 'quantity', title: '洗衣件数', align:'center'}
	            ,{field: 'total_price', title: '总价格', align:'center'}
	            ,{field: 'status', title: '支付状态', align:'center',templet:function(data){
	            	if(data.status == '0'){
	            		return '未支付';
	            	}else {
	            		return '已支付';
	            	}
	            }}
	            ,{field: 'state', title: '交易状态', width:90,align:'center',templet:function(data){
	            	if(data.status == '0'){
	            		return '交易中';
	            	}else if(data.status == '1'){
	            		return '交易成功';
	            	}else{
	            		return '交易失败';
	            	}
	            }}
	            ,{field: 'create_time', title: '订单时间', width:185,align:'center'}
	            ,{fixed: 'right', width:160,title: '操作', align:'center', toolbar: '#barDemo'}
	        ]]
            , page: true   //开启分页
            , limit: 10   //默认十条数据一页
            , limits: [10, 20, 30, 50]  //数据分页条
            , id: 'testReload'
        });
	    $("#query2").click(function(){
	    	var order_no = $("#order_no").val();
	    	var nickname = $("#nickname").val();
		    table.reload('testReload', {
	            where: {
	            	order_no: order_no,
	            	nickname:nickname
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
	        	 layer.confirm('确定完成订单吗', function(index){
	        		 edit(data.id);
	            });
	           
	        }
	    });
	 	function del(id){
			 $.ajax({
				  type: 'POST',
				  url: '${pageContext.request.contextPath}/delOrdersInfo',
				  data: {"id":id},
				  /* dataType: "json", */
				  success:function(req){
					        //请求成功时处理
					        if(req=='ok'){
					        	layer.closeAll();
					        	  table.reload('testReload'); //数据刷新
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
	 	function edit(id){
	 		 $.ajax({
				  type: 'POST',
				  url: '${pageContext.request.contextPath}/editOrdersInfo',
				  data: {"id":id},
				  /* dataType: "json", */
				  success:function(req){
					        //请求成功时处理
					        if(req=='success'){
					        	layer.closeAll();
					        	  table.reload('testReload'); //数据刷新
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
  function add(){
		layer.open({
	          type: 2
	          ,title: '添加公告'
	          ,content: '${pageContext.request.contextPath}/toAddBoardAct'
	          ,maxmin: true
	          ,area: ['500px', '450px']
	          ,btn: ['确定', '取消']
	          ,yes: function(index, layero){
	           // alert("1111");
	        	//当点击‘确定'按钮的时候，获取弹出层返回的值
	        	var body = layer.getChildFrame('body', index); //得到iframe页的body内容
	        	var title = body.find("#title").val();
	        	var content = body.find("#content").val();
	        	
	        	$.ajax({
					  type: 'POST',
					  url: '${pageContext.request.contextPath}/addBoardInfo',
					  data: {title:title,content:content},
					  /* dataType: "json", */
					  success:function(req){
					        //请求成功时处理
					        if(req=='success'){
					        	layer.alert("操作成功");
					        	layer.closeAll();
					        	table.reload('testReload'); //数据刷新
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