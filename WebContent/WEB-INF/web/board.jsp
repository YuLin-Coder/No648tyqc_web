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
<body class="fly-full">

   <jsp:include   page="header.jsp" flush="true"/> 

<div class="fly-panel fly-column">
</div>

<div class="layui-container">
  <div class="layui-row layui-col-space15">
    <div class="layui-col-md8">
      <div class="fly-panel" style="margin-bottom: 0;">
        

        <ul class="fly-list" id="tbody1">          
        </ul>
        
       <input type="hidden" id="dataTotal1" value='${dataTotal1}'>
		   <input type="hidden" id="initPageSize1" value='${dataSize}'>
		   <div class="pages" id="dataPage1">
		
		
		   </div>

      </div>
    </div>
    <div class="layui-col-md4">
      <dl class="fly-panel fly-list-one">
        <dt class="fly-panel-title">本周热议</dt>
        <c:forEach items="${list }" var="l">
          <dd>
	          <a href="boardDetail?id=${l.id}">${l.title }</a>
	        </dd>
        </c:forEach>
      
      </dl>
      
    <!--   <div class="fly-panel fly-link">
        <h3 class="fly-panel-title">友情链接</h3>
        <dl class="fly-panel-main">
          <dd><a href="http://www.layui.com/" target="_blank">layui</a><dd>
          <dd><a href="http://layim.layui.com/" target="_blank">WebIM</a><dd>
          <dd><a href="http://layer.layui.com/" target="_blank">layer</a><dd>
          <dd><a href="http://www.layui.com/laydate/" target="_blank">layDate</a><dd>
          <dd><a href="mailto:xianxin@layui-inc.com?subject=%E7%94%B3%E8%AF%B7Fly%E7%A4%BE%E5%8C%BA%E5%8F%8B%E9%93%BE" class="fly-link">申请友链</a><dd>
        </dl>
      </div> -->

    </div>
  </div>
</div>              <!--<span class="layui-badge layui-bg-red">精帖</span>-->
            </div>
          </li>
    
  </ul>
   

  <div style="text-align: center;">
  </div>

</div>
<div class="fly-footer">
  <p><a href="http://fly.layui.com/" target="_blank">体育器材预约管理系统</a> 2022 &copy; <a href="javascript:void(0)" >layui.com 出品</a></p>
  <p>
  
  </p>
</div>
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
        var url = '${pageContext.request.contextPath}/selectWebNewsData';// 获取分页数据的连接
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
        param.page = data.pageNum;
        param.limit = data.pageSize;
        var list = data.list;
        var html = '';
        for(var i in list){
        	var inx = parseInt(i)+1;
            html +=
                '<li >'
                +'<a   class="fly-avatar" href="boardDetail?id='+list[i].id+'" style="padding-left: 10px;padding-top: 12px;font-size: 23px;">'  
                 +inx /* '<img src="${pageContext.request.contextPath}/upload/board.png" />' */
                +'</a>'
                +' <h2><a href="boardDetail?id='+list[i].id+'">'+list[i].title +'</a><a class="layui-badge">发布时间：'+list[i].fbsj +'</a></h2>'
                +'<div class="fly-list-info">'
                +'  <cite>'+list[i].content +'</cite>'
                +' </div>'
                +'</li>';
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
</body>
</html>