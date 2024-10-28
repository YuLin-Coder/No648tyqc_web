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
<title>体育器材预约管理系统</title>
  <link rel="stylesheet" href="<%=path %>/static/res/layui/css/layui.css">
  <link rel="stylesheet" href="<%=path %>/static/res/css/global.css">
  <style>
 	 .header{border-bottom: 1px solid #404553; border-right: 1px solid #404553;}
  </style>
</head>
<body>
   <jsp:include   page="header.jsp" flush="true"/> 

<div class="layui-hide-xs">
  <div class="fly-panel fly-column">
  </div>
</div>

<div class="layui-container">
  <div class="layui-row layui-col-space15">
    <div class="layui-col-md8 content detail">
      <div class="fly-panel detail-box">
        <h1>${p.title }</h1>
        <input  type="hidden" id="id" value="${p.id }"> 
        <div class="fly-detail-info">
          <!-- <span class="layui-badge">审核中</span> -->
        </div>
        <div class="detail-about">
          <a class="fly-avatar" href="../user/home.html">
            <img src="upload/${p.photo }" alt="贤心">
          </a>
          <div class="fly-detail-user">
            <a href="javascript:void(0)" class="fly-link">
              <cite>编号:${p.qcbh }</cite>
             
            </a>
          
          </div>
          <div class="detail-hits" id="LAY_jieAdmin" data-id="123">
            <span style="padding-right: 10px; color: #FF7200"> 库存数量:${p.stock }</span>  
            <span class="layui-btn layui-btn-xs jie-admin" type="edit"><a >${p.category }</a></span>
          </div>
        </div>
      </div>

      <div class="fly-panel detail-box" id="flyReply">
        <fieldset class="layui-elem-field layui-field-title" style="text-align: center;">
          <legend>详情内容</legend>
        </fieldset>
		<div>
		  <span>器材价格：${p.price }；器材管理员姓名：${p.admin }</span><br/>
		  
				器材描述：${p.detail }
		</div>
        
        <div class="layui-form layui-form-pane" style="text-align: center;padding-top:100px">
            <div class="layui-form-item">
          
              <button class="layui-btn" lay-filter="*" lay-submit onclick="add()">预约</button>
            </div>
        </div>
      </div>
    </div>
    <div class="layui-col-md4">
      <dl class="fly-panel fly-list-one">
        <dt class="fly-panel-title">热门公告</dt>
        <c:forEach items="${list }" var="l">
          <dd>
	          <a href="">${l.title }</a>
	        </dd>
        </c:forEach>

        <!-- 无数据时 -->
        <!--
        <div class="fly-none">没有相关数据</div>
        -->
      </dl>

    

     <!--  <div class="fly-panel" style="padding: 20px 0; text-align: center;">
        <img src="../../res/images/weixin.jpg" style="max-width: 100%;" alt="layui">
        <p style="position: relative; color: #666;">微信扫码关注 layui 公众号</p>
      </div> -->

    </div>
  </div>
</div>
<input type="hidden" id="id" value="${id }">
<div class="fly-footer">
<p> 2022 &copy; <a href="javascript:void(0)" >xxx制作</a></p>
  <p>
  
  </p>
</div>
<script src="<%=path %>/js/jquery-3.3.1.js"></script>
<script src="<%=path %>/static/res/layui/layui.js"></script>
<script src="layui/layui.js"></script>
 <script type="text/javascript">
 layui.use(['layer','form','table','jquery'], function () {//调用layui组件
		var form = layui.form;
		var layer=layui.layer;
		var table=layui.table;
	    $=layui.jquery;  
	    
	 	
	  
});
	    
	    function add(){
	    	var id = $("#id").val();
			layer.open({
		          type: 2
		          ,title: '添加订单'
		          ,content: '${pageContext.request.contextPath}/toaddorder'
		          ,maxmin: true
		          ,area: ['600px', '550px']
		          ,btn: ['确定', '取消']
		          ,yes: function(index, layero){
		           // alert("1111");
		        	//当点击‘确定'按钮的时候，获取弹出层返回的值
		        	var body = layer.getChildFrame('body', index); //得到iframe页的body内容
		        	var start_time = body.find("#start_time").val();
		        	var end_time = body.find("#end_time").val();
		        	var quantity = body.find("#quantity").val();
		        	$.ajax({
						  type: 'POST',
						  url: '${pageContext.request.contextPath}/addOrderInfo',
						  data: {start_time:start_time,end_time:end_time,e_id:id,quantity:quantity},
						  /* dataType: "json", */
						  success:function(req){
						        //请求成功时处理
						        if(req=='success'){
						        	layer.alert("操作成功");
						        	window.location.href= '${pageContext.request.contextPath}/webProductDetail?id='+id;
						        }else if(req=='nonum'){
						        	layer.alert("库存不足");
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