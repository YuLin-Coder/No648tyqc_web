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
<title>管理系统</title>
<meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
<link rel="stylesheet" type="text/css" href="<%=path %>/static/layui/css/layui.css"> 
<link rel="stylesheet" href="<%=path %>/static/layui/css/modules/layer/default/layer.css"/>
<link rel="stylesheet" href="<%=path %>/static/css/global.css"/>

<script src="<%=path %>/static/js/jquery/jquery-2.1.4.min.js" type="text/javascript"></script>
<script src="<%=path %>/static/layui/layui.js" type="text/javascript"></script>
<script src="<%=path %>/static/js/index/index.js" type="text/javascript"></script>
<script src="<%=path %>/static/js/index/freezeheader.js" type="text/javascript"></script>
<script src="<%=path %>/static/layui/lay/modules/layer.js" type="text/javascript"></script>
<script src="<%=path %>/static/js/index/sliders.js" type="text/javascript"></script>
<script src="<%=path %>/static/js/index/html5.js" type="text/javascript"></script>
<script src="<%=path %>/static/js/index/article_details.js" type="text/javascript"></script>
</head>
<body>
<div class="layui-header header">
    	<div class="main">
    <ul class="layui-nav layui-nav-left" lay-filter="filter">
      <a class="fly-logo" href="javascript:void(0)" style="color: white;font-size:18px">
      		体育器材预约管理系统
    </a>
      <li class="layui-nav-item layui-this nav-left">
        <a href="webIndex">首页</a>
      </li>
      <li class="layui-nav-item">
        <a href="webNews">公告列表</a>
      </li>
      <li class="layui-nav-item">
        <a href="webProduct">器械项目列表</a>
      </li>
    <!--   <li class="layui-nav-item">
        <a href="time_line.html">相册</a>
      </li> -->
    </ul>
    <ul class="layui-nav layui-layout-right layui-nav-right" lay-filter="filter">
      <c:if test="${student eq null }">
      		 <li class="layui-nav-item">
		        <a href="toWebLogin"><img src="<%=path %>/static/images/head.jpg" class="layui-nav-img">登录</a>
		       
		      </li>
      </c:if>
        <c:if test="${student ne null }">
      <li class="layui-nav-item">
        <a href="javascript:;"><img src="upload/${student.photo }" class="layui-nav-img">${student.nickname}</a>
        <dl class="layui-nav-child">
          	<dd><a href="toWebSetInfo">修改信息</a></dd>
            <dd><a href="webLoginOut">退了</a></dd>
        </dl>
      </li>
        </c:if>
    </ul>
  </div>
    </div>

    <div class="layui-btn-fluid" style="padding-top:70px;">
   
    	<div class=" layui-btn-fluid">
  <ul class="layui-nav layui-nav-tree layui-inline" lay-filter="user">
   <!--  <li class="layui-nav-item">
      <a href="toWebSetInfo">
        <i class="layui-icon">&#xe609;</i>
        我的主页
      </a>
    </li> -->
    
    <li class="layui-nav-item ">
      <a href="toWebSetInfo">
        <i class="layui-icon">&#xe620;</i>
        基本设置
      </a>
    </li>
    <li class="layui-nav-item layui-this">
      <a href="toMyWebOrders">
        <i class="layui-icon">&#xe611;</i>
        我的订单
      </a>
    </li>
  </ul>

  
  <div class="fly-panel fly-panel-user">
    <div class="layui-tab layui-tab-brief" lay-filter="user" id="LAY_msg" style="margin-top: 15px;">
	   <!--  <button class="layui-btn layui-btn-danger" id="LAY_delallmsg">清空全部消息</button> -->
	    <div  id="LAY_minemsg" style="margin-top: 10px;">
        <!--<div class="fly-none">您暂时没有最新消息</div>-->
        <ul class="mine-msg" >
          
        </ul>
        <div class="layui-col-md12">
        <div class="layui-card">
          <div class="layui-card-body">
            <table class="layui-table">
              <colgroup>
                <col width="150">
                <col width="150">
                <col width="200">
                <col>
              </colgroup>
              <thead>
                <tr>
                  <th>订单编号</th>
                  <th>器材名称</th>
                  <th>预约数量</th>
                  <th>预约状态</th>
                  <th>器材状态</th>
                  <th>预约日期</th>
                  <th>开始时间</th>
                  <th>结束时间</th>
                  <th style="width:300px">操作</th>
                </tr> 
              </thead>
              <tbody id="tbody1">
                
              </tbody>
            </table>
          </div>
        </div>
      </div>
        <input type="hidden" id="dataTotal1" value='${dataTotal1}'>
		   <input type="hidden" id="initPageSize1" value='${dataSize}'>
		   <div class="pages" id="dataPage1">
		
		
		   </div>
      </div>
	  </div>
	</div>

  </div>
</div>
    </div>
    
    <script src="layui/layui.js"></script>
    <script src="<%=path %>/static/res/layui/layui.js"></script>
<script src="<%=path %>/js/jquery-3.3.1.js"></script>
<script type="text/javascript">
    $(function() {
        // 初始化数据分页列表
      initDataList1();
    });

    // 初始化数据分页列表
    var initDataList1 = function() {
        var pageNum = 1;// 初始化当前是第一页
        var pageSize = $("#initPageSize1").val();// 初始化每页条数
        var total = $("#dataTotal1").val();// 总条数
        var pageDivId = 'dataPage1';// 分页的div的id
        var url = '${pageContext.request.contextPath}/selectWebMyOrdersData';// 获取分页数据的连接
        var param = {page:pageNum, limit:pageSize}// 查询条件
        getDataList1(pageDivId, total, param, url);
    }

    //ajax后台请求获得数据列表
    var getDataList1 = function(pageDivId, total, param, url) {
        $.ajax({
            type : "get",
            url : url,
            data : param,
            async : false,
            dataType:"json",
            success : function(data){
                createDataList1(data, pageDivId, total, param, url);
            }
        });
    }
    
    
    //创建数据列表html
    var createDataList1 = function(data, pageDivId, total, param, url) {
        total = data.total;
        param.limit =data.pageSize;
        param.page =  data.pageNum;
        var list = data.list;
        var html = '';
        for(var i in list){
        	var code = list[i].code;
        	
        	var codeData;
        	var status = list[i].status;
        	var statusData;
        	if(code == '0'){
        		codeData = '未归还';
        	}else{
        		codeData = '已归还';
        	}
        	if(status == '0'){
        		statusData = '预约失败';
        	}else if(status == '1'){
        		statusData = '预约成功';
        	}else{
        		statusData = '预约中';
        	}
        	if(code == '0'){
        		if(status == '1'){
        			html +=
                        '<tr >'
                        +'<td>'+list[i].order_no +'</td>'  
                        +'<td>'+list[i].ename +'</td>'  
                        +'<td>'+list[i].quantity +'</td>'  
                        +'<td>'+statusData +'</td>'  
                        +'<td>'+codeData +'</td>'  
                        +'<td>'+list[i].create_date +'</td>'  
                        +'<td>'+list[i].start_time +'</td>'  
                        +'<td>'+list[i].end_time +'</td>'  
                        +'<td>'  
                        +'<i class="pid" style="display:none">'+list[i].id +'</i>'  
                        +'<a href="javascript:;" class="layui-buy layui-btn layui-btn-small layui-btn-danger layui-buy" >归还</a> &nbsp;'  
                        +'</td>'  
                        +'</tr>';
        		}else{
        			html +=
                        '<tr >'
                        +'<td>'+list[i].order_no +'</td>'  
                        +'<td>'+list[i].ename +'</td>'  
                        +'<td>'+list[i].quantity +'</td>'  
                        +'<td>'+statusData +'</td>'  
                        +'<td>'+codeData +'</td>'  
                        +'<td>'+list[i].create_date +'</td>'  
                        +'<td>'+list[i].start_time +'</td>'  
                        +'<td>'+list[i].end_time +'</td>'  
                        +'<td>'  
                        +'<i class="pid" style="display:none">'+list[i].id +'</i>'  
                        +'</td>'  
                        +'</tr>';
        		}
        		
        		
        	}else{
        		
        		html +=
                    '<tr >'
                    +'<td>'+list[i].order_no +'</td>'  
                    +'<td>'+list[i].ename +'</td>'  
                    +'<td>'+list[i].quantity +'</td>'  
                    +'<td>'+statusData +'</td>'  
                    +'<td>'+codeData +'</td>'  
                    +'<td>'+list[i].create_date +'</td>'  
                    +'<td>'+list[i].start_time +'</td>'  
                    +'<td>'+list[i].end_time +'</td>'  
                    +'<td>'  
                    +'<i class="pid" style="display:none">'+list[i].id +'</i>'  
                    +'</td>'  
                    +'</tr>';
        	}
            
        }
        $("#tbody1").html('').append(html);

        // 创建分页div的html
        createPageDiv1(pageDivId, total, param, url);
    }
    //创建分页div的html
    var createPageDiv1 = function(pageDivId, total, param, url) {
        layui.use([ 'laypage', 'layer' ], function() {
            var laypage = layui.laypage, layer = layui.layer;
            laypage.render({
                elem : pageDivId,
                curr : param.page,
                limit : param.limit,
                count : total,
                prev : '<',
                next: '>',
                limits : [ 10, 20, 30, 40, 50, 60, 70, 80, 90, 100 ],
                layout : [ 'prev', 'page', 'next', 'count',  'limit', 'skip' ],
                jump : function(obj, first) {
                	param.page = obj.curr;
                    param.limit = obj.limit;
                    total = obj.count;
                    if (!first) {
                        getDataList1(pageDivId, total, param, url);
                    }
                }
            });
        })
    }
</script>
 <script>
 
  layui.use(['layer','form','jquery'], function () {//调用layui组件
		var form = layui.form;
   		var layer=layui.layer;
	    $=layui.jquery;  
	    form.render();
	   
	    $(".layui-buy").on('click',function(){
	    	
	   	 var uid=$(this).parents("td").find(".pid").text();
		  layer.confirm('确认归还吗?', { btn: ['是','否'],btn1: function(){
	          $.ajax({
	                   url:"buyMyOrders",
	                    type: "POST",
	                    data:{'id':uid},
	                    success:function (data) {
	                    	if(data == 'nologin'){
	                    		
	    	                 	layer.msg('请先登录',{
	    	                        offset:['50%'],
	    	                        time: 1000 //2秒关闭（如果不配置，默认是3秒）
	    	                  },function(){
	    	                	  window.location.href="${pageContext.request.contextPath}/toMyWebOrders";//相当于刷新界面   
	    	                  }); 
	                    	}else{
	                    		layer.msg('归还成功',{
	    	                        offset:['50%'],
	    	                        time: 1000 //2秒关闭（如果不配置，默认是3秒）
	    	                  },function(){
	    	                	  window.location.href="${pageContext.request.contextPath}/toMyWebOrders";//相当于刷新界面   
	    	                  }); 
	                    	}
	                    	
	                 	

	                    }
	                  });
	          },
	          btn2: function(index){
	                  layer.close(index);
	          }
	      })
		
	 	 });  
	    
	    
  });
  </script> 
    </body>
</html>